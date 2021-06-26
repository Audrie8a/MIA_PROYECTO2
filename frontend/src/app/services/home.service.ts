import { Injectable } from '@angular/core';
import { HttpClient } from "@angular/common/http";

@Injectable({
  providedIn: 'root'
})
export class HomeService {
  url:string="http://localhost:3000/"

  constructor(private httpClient: HttpClient) { }

  //Iniciar Sesión
  Login(Usuario: string, Passwords: string){
    const ruta = this.url+"login";
    const data={Usuario, Passwords};
    return this.httpClient.post(ruta,data).toPromise();
  }

  //Registro
  Registro( Nombre: string, Usuario: string, Passwords: string, Foto: string ){
    const ruta = this.url+"registro";
    const data= {Nombre, Usuario, Passwords, Foto};
    return this.httpClient.post(ruta,data).toPromise();

  }

  saveImagen(file: FormData){
    const ruta=this.url+"Img/upload";
    return this.httpClient.post(ruta,file).subscribe(response =>{
      alert(response);
    });
  }
}
