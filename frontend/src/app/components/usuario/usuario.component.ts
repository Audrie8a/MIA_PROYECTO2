import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { UsuarioService } from 'src/app/services/usuario.service';
import { MatDialog,MatDialogConfig } from '@angular/material/dialog';
import { UpdateUserComponent } from '../update-user/update-user.component';

@Component({
  selector: 'app-usuario',
  templateUrl: './usuario.component.html',
  styleUrls: ['./usuario.component.css']
})
export class UsuarioComponent implements OnInit {

  Publicaciones: any;
  Amigos: any;
  Sugerencias: any;
  DatosUsuario: any;

  myImg="http://localhost:3000/";

  constructor(public usuarioService:UsuarioService,
    public _routre:Router,
    public route: ActivatedRoute,
    private dialog: MatDialog) { }

  ngOnInit(): void {
    let usuario=this.route.snapshot.paramMap.get("id");
    this.Inicio(usuario)
  }

  Inicio(usuario: string | null){
    if(usuario!=null){
      this.getPublicaciones(usuario);
      this.getAmigos(usuario);
      this.getSugerencias(usuario);
      this.getDatosUsuario(usuario);
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
  async getDatosUsuario(Usuario: string | null){
    this.DatosUsuario= await this.usuarioService.getDatosUsuario(Usuario);
    if(this.DatosUsuario.Foto!=null){
    this.myImg+=this.DatosUsuario.Foto;
    }else{
      this.myImg+="NoFoto.jpg";
    }
  }

  onEdit(){
    const dialogConfig= new MatDialogConfig();
    //dialogConfig.disableClose=true;
    dialogConfig.autoFocus=true;
    dialogConfig.width="60%";
    this.dialog.open(UpdateUserComponent,dialogConfig);
  }

  AgregarAmigo(Usuario: string){
    console.log(Usuario);
  }

}
