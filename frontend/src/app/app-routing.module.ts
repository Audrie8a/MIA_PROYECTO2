import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ChatComponent } from './components/chat/chat.component';
import { HomeComponent } from './components/home/home.component';
import { UsuarioComponent } from './components/usuario/usuario.component';

const routes: Routes = [
  {
    path:'',
    component: HomeComponent
  },
  {
    path:'Home',
    component: HomeComponent
  },
  {
    path:'User/:id',
    component: UsuarioComponent
  },
  {
    path:'Chat',
    component:ChatComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
