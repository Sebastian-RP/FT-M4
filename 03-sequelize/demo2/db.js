const { Sequelize, Model } = require('sequelize');
const userModel = require('./Models/User');
const pollitoModel = require('./Models/pollito');

const sequelize = new Sequelize('postgres://postgres:1234@localhost:5432/sebastian-test', {
    logging: false,
});//ambos metodos de conecciones no tienen problema

// const sequelize = new Sequelize('database', 'username', 'password',
// {
//     host: 'localhost',
//     dialect: 'postgres'/*'mysql' | 'maridb' | 'postgres | 'mssql */
// });

//las tablas se le llama modelos, y son las que vamos a crear y sincronizar con la base de datos

userModel(sequelize); 
pollitoModel(sequelize);

//sincronizar con la tabla de datos
sequelize.models.User.sync();
sequelize.models.Pollito.sync({ force: true });//sin parametros dentro de sync() crea la tabla si no existe o no hace nada si ya existe
// sequelize.models.Pollito.sync({force: true});//elimina (drop) la tabla y luego la vuelve a crear
// sequelize.models.Pollito.sync({alter: true});//aplica los cambios necesarios a la tabla actual para que coincida con el modelo

//instancias(ingresar datos)
userModel.create({firstName: "jane ", lastName: "asdf"})
.then((result) => {
    console.log(result);
}); 