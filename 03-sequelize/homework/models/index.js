var Sequelize = require("sequelize");
const S = Sequelize;

var db = new Sequelize("postgres://postgres:1234@localhost:5432/henryblog", {
  logging: false,
});

const Page = db.define("page", {
  // Tu código acá:
  title:{
    type: S.DataTypes.STRING,
    allowNull: false,
  },
  urlTitle: {
    type: S.DataTypes.STRING,
    allowNull: false,
  },content: {
    type: S.DataTypes.TEXT,
    allowNull: false
  }, status: {
    type: S.DataTypes.ENUM('open', 'closed')
  },
  route: {
    type: S.DataTypes.VIRTUAL,
    get(){
      return '/pages/'+ this.getDataValue('urlTitle');
    }
  }
});

// .addHook() method
Page.beforeValidate(page => {
  return page.urlTitle = page.title.replace(/\s+/g, '_').replace(/\W/g, '');
}); 

const User = db.define("users", {
  name: {
    type: S.DataTypes.STRING,
    allowNull: false
  }, 
  email: {
    type: S.DataTypes.STRING,
    allowNull: false,
    unique: true,
  }
});

const Category = db.define("category", {
  // Tu código acá:
  name: {
    type:  S.DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
  description: {
    type: S.DataTypes.STRING,
  }
});

// Vincular User con Page
// Tu código acá:
User.hasMany(Page);
Page.belongsTo(User);

Page.belongsToMany(Category, { through: 'page_categories' });
Category.belongsToMany(Page, { through: 'page_categories' });

module.exports = {
  User,
  Page,
  Category,
  db,
};
