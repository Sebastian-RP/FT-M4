const { DataTypes, Model } = require("sequelize");

module.exports = sequelize => {
    sequelize.define('Pollito', {
        // pollitoId: {
        //     type: DataTypes.INTEGER,
        //     primaryKey: true,
        //     autoIncrement: true,
        // },
        nombre: {
            type: DataTypes.STRING,
        },
        apellido: {
            type: DataTypes.STRING,
        },
        age: {
            type: DataTypes.INTEGER
        }, 
        address: {
            type: DataTypes.TEXT
        }
    },{
        // timestamps: false,
        createAt: false,//deseo que no me agregue este campo
        updateAt: true,
    });
}