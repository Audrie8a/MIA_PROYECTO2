import { Injectable } from '@angular/core';
import { HttpClient } from "@angular/common/http";

@Injectable({
  providedIn: 'root'
})
export class UsuarioService {

  url:string="http://localhost:3000/User/"
  constructor(private httpClient: HttpClient) { }

  getPublicaciones(Usuario:string | null){
    const ruta = this.url+"Publicaciones";
    const data = {Usuario};
    return this.httpClient.post(ruta,data).toPromise();
  }

  getAmigos (Usuario:string | null){
    const ruta = this.url+"Amigos";
    const data = {Usuario};
    return this.httpClient.post(ruta,data).toPromise();
  }

  getSugerencias (Usuario:string | null){
    const ruta = this.url+"Sugerencias";
    const data = {Usuario};
    return this.httpClient.post(ruta,data).toPromise();
  }
}
