import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { UsuarioService } from 'src/app/services/usuario.service';
@Component({
  selector: 'app-usuario',
  templateUrl: './usuario.component.html',
  styleUrls: ['./usuario.component.css']
})
export class UsuarioComponent implements OnInit {

  Publicaciones: any;
  Amigos: any;
  Sugerencias: any;

  constructor(public usuarioService:UsuarioService,
    public _routre:Router,
    public route: ActivatedRoute ) { }

  ngOnInit(): void {
    let usuario=this.route.snapshot.paramMap.get("id");
    this.Inicio(usuario)
  }

  Inicio(usuario: string | null){
    if(usuario!=null){
      this.getPublicaciones(usuario);
      this.getAmigos(usuario);
      this.getSugerencias(usuario);
    }
  }

  async getPublicaciones(Usuario: string | null){
    this.Publicaciones= await this.usuarioService.getPublicaciones(Usuario);
    //alert(this.Publicaciones);
  }

  async getAmigos(Usuario: string | null){
    this.Amigos= await this.usuarioService.getAmigos(Usuario);
    //alert(this.Amigos);
  }

  async getSugerencias(Usuario: string | null){
    this.Sugerencias= await this.usuarioService.getSugerencias(Usuario);
    //alert(this.Amigos);
  }

}
