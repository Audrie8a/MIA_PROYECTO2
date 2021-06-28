import { Component, OnInit,ElementRef,ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { UsuarioService } from 'src/app/services/usuario.service';
import { MatDialog,MatDialogConfig,MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { UpdateUserComponent } from '../update-user/update-user.component';


@Component({
  selector: 'app-usuario',
  templateUrl: './usuario.component.html',
  styleUrls: ['./usuario.component.css']
})
export class UsuarioComponent implements OnInit {

  @ViewChild('fileInput',{static:false}) fileInput!: ElementRef;

  PF: string ="1";
  Usr: string | null="";
  Publicaciones: any;
  Amigos: any;
  Sugerencias: any;
  DatosUsuario: any;

  //Publicacion
  txtTag:string ='';
  txtPublicacion: string = '';
  ImagenP: string = '';
  lstTags=[''];
  Tags='';
  //Filtrar
  TagsF='';
  txtTagF:string='';

  myImg="http://localhost:3000/";

  constructor(public usuarioService:UsuarioService,
    public _routre:Router,
    public route: ActivatedRoute,
    private dialog: MatDialog) { }

  ngOnInit(): void {
    let usuario=this.route.snapshot.paramMap.get("id");
    this.Usr=usuario;
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

  async EliminarAmigo(Usuario: string){
    let respuesta = await this.usuarioService.eliminarAmigo(this.Usr,Usuario);
    if(respuesta=="true"){
      this.ngOnInit();
      alert("Amigo eliminado!");
    }else{
      alert("Error al eliminar amigo!");
    }
  }

  async AgregarAmigo(Usuario: string){
    let respuesta = await this.usuarioService.agregarAmigo(this.Usr,Usuario);
    if(respuesta=="true"){
      this.ngOnInit();
      alert("Amigo añadido!");
    }else{
      alert("Error al añadir amigo!");
    }
  }

  async crearPublicacion(){
    if(this.ImagenP!=''){
      let respuesta=await this.usuarioService.crearPublicacion(this.Usr,this.txtPublicacion, this.ImagenP.substr(12,this.ImagenP.length),this.Tags );
      if(respuesta=="true"){
        this.onFileUpload();
        this.ngOnInit();
        this.Tags='';
        alert("Publicado!");
      }else{
        alert("Error al Publicar!");
      }
    }else{
      alert("Se necesita una imagen para publicar!");
    }
  }

  borrarFiltros(){
    this.ngOnInit();
  }

  async FiltrarPublicacion(){

    let respuesta=await this.usuarioService.getPublicacionesFiltradas(this.Usr,this.TagsF);
    this.Publicaciones =respuesta;
    this.TagsF='';
    if(respuesta=='false'){
      alert("No ha publicaciones con este tag!");
    }
    //this.ngOnInit();
  }

  addTagFiltro(){
    if(this.txtTagF!=''){
      if(this.txtTagF[0]=='#'){
        let splitted=this.txtTagF.split(" ");
        splitted.forEach(element => {
          if(element!=''){
            this.TagsF+="'"+element+"'"+"**";
          }
        });
        this.FiltrarPublicacion();
        alert("Filtrando...");
        this.txtTagF="";
      }else{
        alert("Error, se necesita iniciar con un #");
      }

    }else{
      alert('No se puede agregar un tag vacío!');
    }
  }

  addTag(){
    if(this.txtTag!=''){
      if(this.txtTag[0]=='#'){
        this.Tags+=this.txtTag+"**";
        alert("Tag Agregado!");
        this.txtTag="";
      }else{
        alert("Error, se necesita iniciar con un #");
      }

    }else{
      alert('No se puede agregar un tag vacío!');
    }
  }


  onFileUpload(){
    const imageBlob = this.fileInput.nativeElement.files[0];
    alert(imageBlob);
    const file = new FormData();
    file.set('file', imageBlob);
    this.usuarioService.saveImagen(file);
  }


  onEdit(){
    const dialogConfig= new MatDialogConfig();
    //dialogConfig.disableClose=true;
    dialogConfig.autoFocus=true;
    dialogConfig.width="60%";
    this.dialog.open(UpdateUserComponent,dialogConfig);
  }

  openDialog(): void {

  }


}
