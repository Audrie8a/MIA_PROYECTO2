import { Component, OnInit,ElementRef,ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { UsuarioService } from 'src/app/services/usuario.service';
import { MatDialog,MatDialogConfig,MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { UpdateUserComponent } from '../update-user/update-user.component';
import { Md5 } from 'ts-md5';


@Component({
  selector: 'app-usuario',
  templateUrl: './usuario.component.html',
  styleUrls: ['./usuario.component.css']
})
export class UsuarioComponent implements OnInit {

  @ViewChild('fileInput',{static:false}) fileInput!: ElementRef;
  @ViewChild('fileInput2',{static:false}) fileInput2!: ElementRef;
  //Inicio
  PF: string ="1";
  Usr: string | null="";
  Publicaciones: any;
  Amigos: any;
  Sugerencias: any;
  DatosUsuario!: any;
  NombreBoton: string="Desactivado";

  //Datos Usuario
  Nom='';
  Pass='';
  Us='';
  //Publicacion
  txtTag:string ='';
  txtPublicacion: string = '';
  ImagenP: string = '';
  lstTags=[''];
  Tags='';
  //Filtrar
  TagsF='';
  txtTagF:string='';

  //Imagenes

  myImg="";

  //Editar
  Nombre: string='';
  Passwords: string='';
  Foto:string='';
  ModoBot:string='';
  Contra:string='';

  constructor(public usuarioService:UsuarioService,
    public _routre:Router,
    public route: ActivatedRoute,
    public dialog: MatDialog) { }

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
    this.Us=this.DatosUsuario.Usuario;
    this.Pass=this.DatosUsuario.Passwords;
    this.Nom=this.DatosUsuario.Nombre;
    if(this.DatosUsuario.Foto!=null){
    this.myImg="http://localhost:3000/"+this.DatosUsuario.Foto;
    }else{
      this.myImg="http://localhost:3000/NoFoto.jpg";
    }

    if(this.DatosUsuario.ModoBot=="1"){
      this.NombreBoton="Activado";
    }else{
      this.NombreBoton="Desactivado";
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
      //alert(this.ImagenP);
      if(this.Tags==''){
        this.Tags='Ninguno'
      }
      let respuesta=await this.usuarioService.crearPublicacion(this.Usr,this.txtPublicacion, this.ImagenP.substr(12,this.ImagenP.length),this.Tags );
      if(respuesta=="true"){
        this.onFileUpload2();
        this.ngOnInit();

        alert("Publicado!");
      }else{
        alert("Error al Publicar!");
      }
    }else{
      alert("Se necesita una imagen para publicar!");
    }
    this.Tags='';
    this.ImagenP='';
    this.txtPublicacion='';
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
    console.log(imageBlob);
    //alert(imageBlob);
    const file = new FormData();
    file.set('file', imageBlob);
    this.usuarioService.saveImagen(file);
  }

  onFileUpload2(){
    const imageBlob = this.fileInput2.nativeElement.files[0];
    console.log(imageBlob);
    //alert(imageBlob);
    const file = new FormData();
    file.set('file', imageBlob);
    this.usuarioService.saveImagen(file);
  }

  openDialog(): void {
    const dialogRef=this.dialog.open(UpdateUserComponent,{
      width:'300px',
      data:{Nombre: this.Nombre, Passwords:this.Passwords}
    });
    dialogRef.afterClosed().subscribe(result=>{
      console.log('The dialog was closed');
      this.Nombre=result.Nombre;
      this.Passwords=result.Passwords;
      this.Contra=result.Contra;
      if(this.Contra==undefined){
        alert("Para Editar, se necesita que ingrese contraseña!");
      }else{
        if(this.Nombre==''){
          this.Nombre=this.DatosUsuario.Nombre;
        }
        if(this.Passwords==''){
          this.Passwords=this.DatosUsuario.Passwords;
        }else if(this.Passwords!=''){
          this.Passwords=Md5.hashStr(result.Passwords).toString();
        }
        let codificado=Md5.hashStr(this.Contra).toString();
        if(codificado==this.DatosUsuario.Passwords){
          this.EditarUsuario(this.Usr, this.Nombre, this.Passwords, this.DatosUsuario.Foto,this.DatosUsuario.ModoBot);
        }else{
          alert("Contraseña Incorrecta! Datos no modificados");
        }
      }
      this.Nombre='';
      this.Passwords='';
      this.Contra='';
    })
  }

  cambiarFotoPerfil(){
    if(this.ImagenP!=''){
    this.onFileUpload();
    this.EditarUsuario(this.Usr, this.DatosUsuario.Nombre, this.DatosUsuario.Passwords,this.ImagenP.substr(12,this.ImagenP.length),this.DatosUsuario.ModoBot);
    this.ngOnInit();
    }else{
      alert('No se ha cargado ninguna imagen!');
    }
  }

  cambiarModoBot(){
    let Modo='';
    if(this.DatosUsuario.ModoBot=="1"){
      Modo="0";
      this.NombreBoton="Desactivado";
    }else{
      Modo="1";
      this.NombreBoton="Activado";
    }
    this.EditarUsuario(this.Usr, this.DatosUsuario.Nombre, this.DatosUsuario.Passwords,this.DatosUsuario.Foto,Modo);
    this.ngOnInit();

  }

  async EditarUsuario(Usuario: string | null, Nmb: string, Passw: string, Ft: string,MB:string){
    let respuesta = await this.usuarioService.updatUsuario(Usuario, Nmb, Passw, Ft,MB);
    if(respuesta=='true'){
      alert("Datos Usuario Editado!")
    }else{
      alert("Error al editar!");
    }
    this.ngOnInit();
  }

}

