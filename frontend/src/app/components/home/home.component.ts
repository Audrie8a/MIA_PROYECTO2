import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { HomeService } from 'src/app/services/home.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  constructor(public homeService: HomeService,
    public _activatedRoute: ActivatedRoute,
    public _router: Router) { }

  ngOnInit(): void {
  }

  //Login
  Usuario: string = '';
  Passwords: string = '';

  //Registro
  Usr: string = '';
  Nombre: string = '';
  Pass: string = '';
  Foto: string = '';
  Pass2: string ='';


  buttonDisabled: boolean = false;
  inputHidden: string = 'hidden'; //Estas pasan a text
  selectHidden: string = "visibility: hidden"; // Estas pasan a ""
  dateHidden: string = 'hidden';//Estas pasan a date
  labelHidden: string = 'true'; //Esta pasa a ''

  linkRouter: string = '';

  async Login() {
    let respuesta = await this.homeService.Login(this.Usuario, this.Passwords);
    if (respuesta == 'false' || respuesta == 'error') {
      this.linkRouter = '/Home'
      alert("Usuario o Cotraseña incorrectas!");

    } else if (respuesta == 'error') {
      this.linkRouter = '/Home'
      alert("Error");

    } else {
      this.borrarRegistro();
      alert(respuesta);
      this.linkRouter = '/User';
      this._router.navigate([this.linkRouter, respuesta]);
    }
  }

  async Registrar() {
    if (this.Nombre != '' && this.Pass != '' && this.Pass2!='' && this.Usr != '') {
      if(this.Pass==this.Pass2){
        let respuesta = await this.homeService.Registro(this.Nombre, this.Usr, this.Pass, this.Foto);
        if (respuesta == 'true') {
          alert("Usuario creado existosamente!");
          this.borrarRegistro();
        } else {
          alert("Error al crear el usuario!");
          this.borrarRegistro();
        }
      }
      else{
          alert("Error, las contraseñas no coinciden!");
      }
    } else {
      alert("Por favor llenar todos los campos!");

    }
  }


  borrarRegistro() {
    this.Usuario = '';
    this.Passwords = '';
    this.Usr = '';
    this.Nombre = '';
    this.Pass = '';
    this.Pass2='';
    this.Foto = '';
  }
}
