const { DataTypes, Model } = require("sequelize");

module.exports = sequelize => {
    sequelize.define('User', {
        firstName: {
            type: DataTypes.STRING,
        },
        lastName: {
            type: DataTypes.STRING,
        },
    })
}

//maneras de crear entidades
// const User = sequelize.define('User', { 

//     firstName: {
//         type: DataTypes.STRING
//     },
//     lastName: {
//         type: DataTypes.STRING
//     },
// })
//******************************* */
// class User extends Model{}

// User.init({
//     firstNAme: {
//         type: DataTypes.STRING
//     },
//     lastName: {
//         type: DataTypes.STRING
//     }
// }, {
//     sequelize, //Connection instance
//     modelName: 'User' //Moddel name
//     }    
// );

// module.exports = User;