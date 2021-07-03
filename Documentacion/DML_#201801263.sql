insert into Usuario (Nombre, Usuario, Passwords, Foto,ModoBot) values ('Audrie', 'Audrie8a', '5f84a0cd34888c26ed138fb1951f59d1','Audrie.jpg',1);
insert into Usuario (Nombre, Usuario, Passwords, Foto,ModoBot) values ('Rodrigo', 'Rodri8a', 'e5fd467f8ebf9a0fe9363e0a231b60da','Rodrigo.jpeg',1);
insert into Usuario (Nombre, Usuario, Passwords, Foto,ModoBot) values ('Johanna', 'Joha8a', '713429ae64fd51fce6925f1142cb18b5','',1);
insert into Usuario (Nombre, Usuario, Passwords, Foto,ModoBot) values ('Sergio', 'SegiDC', '0364ecca65343cf314ce967fbad8d1aa','Sergi.jpg',1);
insert into Usuario (Nombre, Usuario, Passwords, Foto,ModoBot) values ('Alejandro', 'AleDC', '99d2b056ffd07b81266308735821ac36','Alejandro.png',1);

insert into Publicacion (Fecha,Usuario, Texto, Imagen) values ('24-06-2021','Audrie8a','Mi primer Publicacion', 'P2.jpg');
insert into Publicacion (Fecha,Usuario, Texto, Imagen) values ('25-06-2021','Rodri8a','Mi primer Publicacion Rodrigo', 'P3.jpg');
insert into Publicacion (Fecha,Usuario, Texto, Imagen) values ('26-06-2021','Joha8a','Publicacion Joha', 'P1.jpg');
insert into Tags(Tags) values ('Ninguno');
insert into Tags(Tags) values ('#NoCovid');
insert into Tags(Tags) values ('#Feliz');
insert into Tags(Tags) values ('#New');
insert into EstadoAmistad (Estado) values ('Aceptada');
insert into EstadoAmistad (Estado) values ('Rechazada');
--insert into EstadoAmistad (Estado) values ('Espera');
insert into Publicar (id_Tag, id_Publicacion) values (2,1);
insert into Publicar (id_Tag, id_Publicacion) values (2,2);
insert into Publicar (id_Tag, id_Publicacion) values (3,2);
insert into Publicar (id_Tag, id_Publicacion) values (2,3);
insert into Publicar (id_Tag, id_Publicacion) values (3,3);
insert into Publicar (id_Tag, id_Publicacion) values (4,3);
insert into SolicitudAmistad (UsuarioA, UsuarioB, Fecha, id_EstadoAmistad) values('Audrie8a','Rodri8a','25-06-2021',1);
insert into SolicitudAmistad (UsuarioA, UsuarioB, Fecha, id_EstadoAmistad) values('Audrie8a','Joha8a','25-06-2021',2);
insert into SolicitudAmistad (UsuarioA, UsuarioB, Fecha, id_EstadoAmistad) values('Joha8a','Rodri8a','25-06-2021',1);
insert into SolicitudAmistad (UsuarioA, UsuarioB, Fecha, id_EstadoAmistad) values('Audrie8a','AleDC','25-06-2021',2);


commit;

--Iniciar Sesión
select Usuario from Usuario where Usuario='Audrie8a' and Passwords='5f84a0cd34888c26ed138fb1951f59d1';

--Registrar
call Registro ('Johanna Ochoa Bocekmann','Johanna8a','0364ecca65343cf314ce967fbad8d1aa', '');

--Obtener Publicaciones según usuario
select  distinct publicacion.id_publicacion ,Publicacion.Fecha, publicacion.texto, publicacion.imagen,usuario.usuario
        from Publicacion, Usuario, Publicar
        where publicacion.usuario=usuario.usuario
        and publicacion.id_publicacion=publicar.id_publicacion
        and usuario.usuario in ('Audrie8a','Rodri8a')
        order by publicacion.fecha desc;
        
--Obtener tags por publicación
select tags.tags
            from Publicacion, Publicar, Tags
            where Publicacion.id_Publicacion= publicar.id_publicacion
            and tags.id_tag=publicar.id_tag
            and publicacion.id_publicacion=1;

--Obtener Amigos según Usuario
select solicitudamistad.usuarioa
        from SolicitudAmistad, Usuario
        where SolicitudAmistad.usuariob=usuario.usuario
        and solicitudamistad.id_estadoamistad=1
        and Usuario.usuario='Audrie8a';
        
--Obtener sugerencias de personas para posibles amigos
select distinct usuario.usuario
        from Usuario
        where usuario.usuario not in ('Audrie8a','Rodri8a');

--Obtener datos del usuario
select * from Usuario
        where Usuario='Audrie8a';

--Editar datos Usuario
update Usuario set Nombre='Annelisse ', Passwords='5f84a0cd34888c26ed138fb1951f59d1', Foto='Audrie.jpg' , ModoBot=1
        where Usuario='Audrie8a';
        
--Elimina Amigo
delete from SolicitudAmistad where (SolicitudAmistad.usuarioa='Audrie8a' and SolicitudAmistad.usuariob='AleDC') 
        or (solicitudamistad.usuariob='Audrie8a' and solicitudamistad.usuarioa='AleDC');
        
--Agregar Usuario como Amigo
insert into SolicitudAmistad (UsuarioA, UsuarioB, Fecha, id_EstadoAmistad) values('Audrie8a','Joha8a',(select current_date from dual),1);

--Crear publicacion
insert into Publicacion (Fecha,Usuario, Texto, Imagen) 
        values ((select current_date from dual),'Audrie8a','Esta es la nueva vacuna del covid', 'vacuna.jpeg');

--Insertar Tags
call insertTags('#Vacuna');

--Obtener Publicaciones Filtradas
select distinct Publicacion.id_Publicacion, Publicacion.Fecha,Publicacion.Texto, Publicacion.Imagen, Publicacion.Usuario
        from Publicar, Publicacion, Tags
        where publicar.id_tag=tags.id_tag
        and Publicar.id_Publicacion=publicacion.id_publicacion
        and Lower(tags.tags) in (Lower('#Feliz'))
        and Publicacion.Usuario in ('Audrie8a','Joha8a','Rodri8a')
        order by publicacion.fecha desc;


