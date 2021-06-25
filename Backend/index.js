const InicioRouter = require('./routes/inicio.routes');
const usuariosRouter=require('./routes/usuarios.routes');

var express = require('express');
const morgan=require('morgan');
const bodyParser = require('body-parser');

var app = express();
const cors = require('cors')
const port = 3000

app.use(morgan('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))
app.use(cors())

//app.use("/estudiantes", estudiantesRouter)
app.get('/', function(req,res){
res.send("Bienvenido!")
});

app.use("/",InicioRouter)
app.use("/User",usuariosRouter)

app.listen(port, function () {
  console.log('Listening on port',port);
});