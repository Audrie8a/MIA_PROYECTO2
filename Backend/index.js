const InicioRouter = require('./routes/inicio.routes');
const usuariosRouter=require('./routes/usuarios.routes');
const Img = require('./routes/imagen.routes');
const chat =require('./routes/chat.routes');

var express = require('express');
const ejs=require('ejs');
const morgan=require('morgan');
const bodyParser = require('body-parser');
const path = require('path');

var app = express();
const http=require('http').Server(app);
const io=require("socket.io")(http,{
  cors:{
    origin:true,
    credentials: true,
    methods:["GET","POST"]
  }
})
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

app.use("/",InicioRouter);
app.use("/User",usuariosRouter);
app.use("/Img",Img);


app.use(express.static('Public'));

io.on('connection',(socket)=>{
  console.log("Nuevo Usuario Conectado!");
  socket.on("test",(texto)=>{
    console.log("evento TEST: "+texto.texto);
    socket.emit("test2");
  })
})

http.listen(port, function () {
  console.log('Listening on port',port);
});
