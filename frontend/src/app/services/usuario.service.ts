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

  getPublicacionesFiltradas(Usuario:string | null, Tag1: string){
    const ruta = this.url+"Filtrar";
    const data = {Usuario, Tag1};
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

  getDatosUsuario (Usuario:string | null){
    const ruta = this.url+"Datos";
    const data = {Usuario};
    return this.httpClient.post(ruta,data).toPromise();
  }

  eliminarAmigo(Usuario:string | null, Amigs: string){
    const ruta = this.url+"Eliminar";
    const data = {Usuario, Amigs};
    return this.httpClient.post(ruta, data).toPromise();

  }

  agregarAmigo(UsuarioA:string | null, UsuarioB: string){
    const ruta = this.url+"Agregar";
    const data = {UsuarioA, UsuarioB};
    return this.httpClient.post(ruta, data).toPromise();

  }

  crearPublicacion(Usuario: string | null, Texto:string, Imagen:string, Tags:string){
    const ruta= this.url+"Publicar";
    const data={Usuario, Texto, Imagen, Tags};
    return this.httpClient.post(ruta,data).toPromise();
  }

  updatUsuario(Usuario: string | null, Nombre:string, Passwords:string, Foto:string){
    const ruta= this.url+"UpdateDatos";
    const data={Usuario, Nombre, Passwords, Foto};
    return this.httpClient.post(ruta,data).toPromise();
  }

  saveImagen(file: FormData){
    const ruta="http://localhost:3000/Img/upload";
    return this.httpClient.post(ruta,file).subscribe(response =>{
      alert(response);
    });
  }
}
