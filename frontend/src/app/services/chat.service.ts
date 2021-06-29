import { Injectable } from '@angular/core';
import { SocketService } from './socket.service';

@Injectable({
  providedIn: 'root'
})
export class ChatService {

  chats=[{text:"",messageType:0}];

  constructor(private socket:SocketService) {
    this.onReciveMessage();
  }

  sendMessage(messageInfo: any){
    this.chats.push(messageInfo);
    this.socket.io.emit("sendMessage",messageInfo);
  }

  onReciveMessage(){
    this.socket.io.on("reciveMessage",(messageInfo)=>{
      this.chats.push(messageInfo);
    })
  }
}
