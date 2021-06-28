const InicioRouter = require('./routes/inicio.routes');
const usuariosRouter=require('./routes/usuarios.routes');
const Img = require('./routes/imagen.routes');


var express = require('express');
const ejs=require('ejs');
const morgan=require('morgan');
const bodyParser = require('body-parser');
const path = require('path');

var app = express();
const cors = require('cors');
const port = 3000




app.use(morgan('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))
app.use(cors());



//Rutas
app.get('/', function(req,res){
res.send("Bienvenido!")
});

app.use("/",InicioRouter)
app.use("/User",usuariosRouter)
app.use("/Img",Img);

app.use(express.static('Public'));




app.listen(port, function () {
  console.log('Listening on port',port);
});