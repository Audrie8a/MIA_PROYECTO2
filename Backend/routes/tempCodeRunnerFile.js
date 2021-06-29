const http=require('http').Server(express);
const io=require('socket.io')(http,{
  cors:{
    origin: true,
    credentials: true,
    methods:["GET","POST"]
  }
})

io.on('connection', (socket) => {
    console.log('Un usuario Conectado');
  
  
  });