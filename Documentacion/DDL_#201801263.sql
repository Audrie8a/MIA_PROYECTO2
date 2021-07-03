alter table SolicitudAmistad drop constraint fk_EstadoAmistad_SolicitudAmistad;
alter table SolicitudAmistad drop constraint fk_Usuario_SolicitudAmistad;
alter table SolicitudAmistad drop constraint fk_Amigo_SolicitudAmistad;
alter table Mensaje drop constraint fk_UsuarioA_Mensaje;
alter table Mensaje drop constraint fk_UsuarioB_Mensaje;
alter table Publicacion drop constraint fk_Usuario_Publicacion;
alter table Publicar drop constraint fk_Publicacion_Publicar;
alter table Publicar drop constraint fk_Tag_Publicar;
drop table Usuario;
drop sequence idUsuarioSeq;
drop table EstadoAmistad;
drop sequence idEstadoAmistadSeq;
drop table SolicitudAmistad;
drop sequence idSolicitudAmistadSeq;
drop table Mensaje;
drop sequence idMensajeSeq;
drop table Publicar;
drop sequence idPublicarSeq;
drop table Tags;
drop sequence idTagsSeq;
drop sequence idPublicacionSeq;
drop table Publicacion;

commit;

create sequence idUsuarioSeq start with 1 increment by 1;
Create table Usuario(
    id_Usuario number default idUsuarioSeq.nextval,
    Nombre varchar(45) null,
    Usuario varchar(45) null,
    Passwords varchar(45) null,
    Foto varchar(500) null,
    ModoBot int null,
    primary key (Usuario)
);


Create sequence idEstadoAmistadSeq start with 1 increment by 1;
Create table EstadoAmistad(
    id_EstadoAmistad number default idEstadoAmistadSeq.nextval,
    Estado varchar(45),
    primary key (id_EstadoAmistad)
);

Create sequence idSolicitudAmistadSeq start with 1 increment by 1;
Create table SolicitudAmistad(
    id_SolicidtudAmistad number default idSolicitudAmistadSeq.nextval,
    UsuarioA varchar(45) not null,
    UsuarioB varchar(45) not null,
    Fecha date,
    id_EstadoAmistad int not null,
    primary key (id_SolicidtudAmistad)
);

alter table SolicitudAmistad add constraint fk_EstadoAmistad_SolicitudAmistad foreign key (id_EstadoAmistad) references EstadoAmistad(id_EstadoAmistad);
alter table SolicitudAmistad add constraint fk_Usuario_SolicitudAmistad foreign key (UsuarioA) references Usuario(Usuario);
alter table SolicitudAmistad add constraint fk_Amigo_SolicitudAmistad foreign key (UsuarioB) references Usuario(Usuario);

Create sequence idMensajeSeq start with 1 increment by 1;
Create table Mensaje(
    id_Mensaje number default idMensajeSeq.nextval,
    Fecha date,
    UsuarioA varchar(45) not null,
    UsuarioB varchar(45) not null,
    Texto varchar(1000) null,
    primary key (id_Mensaje)
);

alter table Mensaje add constraint fk_UsuarioA_Mensaje foreign key (UsuarioA) references Usuario(Usuario);
alter table Mensaje add constraint fk_UsuarioB_Mensaje foreign key (UsuarioB) references Usuario(Usuario);

Create sequence idPublicacionSeq start with 1 increment by 1;
Create table Publicacion(
    id_Publicacion number default idPublicacionSeq.nextval,
    Fecha date,
    Usuario varchar(45) not null,
    Texto varchar(1000) null,
    Imagen varchar(500) null,
    primary key (id_Publicacion)
);
alter table Publicacion add constraint fk_Usuario_Publicacion foreign key (Usuario) references Usuario(Usuario);

Create sequence idTagsSeq start with 1 increment by 1;
Create table Tags(
    id_Tag number default idTagsSeq.nextval,
    Tags varchar(45) null,
    primary key (id_Tag)
);


Create sequence idPublicarSeq start with 1 increment by 1;
Create table Publicar(
    id_Publicar number default idPublicarSeq.nextval,
    id_Tag int not null,
    id_Publicacion int not null,
    primary key (id_Publicar)
);

alter table Publicar add constraint fk_Publicacion_Publicar foreign key (id_Publicacion) references Publicacion(id_Publicacion);
alter table Publicar add constraint fk_Tag_Publicar foreign key (id_Tag) references Tags(id_Tag);





commit;


----PROCEDIMIENTOS
create or replace procedure insertTags(
    TG in Tags.Tags%TYPE
)
IS 
    idP int;
    idT int;
    cont int;
BEGIN
    idP:=0;
    idT:=0;
    select id_Publicacion into idP from (select * from Publicacion order by id_publicacion desc) where rownum=1;
    select count(*) into cont from Tags where Tags=TG;
    DBMS_OUTPUT.PUT_LINE(cont);
    if cont=0 then
        insert into Tags (Tags) values(TG);        
        select id_Tag into idT from (select * from Tags order by id_Tag desc) where rownum=1;
        DBMS_OUTPUT.PUT_LINE(idT);
    else
        select id_Tag into idT from Tags where Tags=TG;        
    end if;
    DBMS_OUTPUT.PUT_LINE(idT);
    insert into Publicar (id_Tag, id_Publicacion) values (idT,idP);
END;

drop procedure Registro;

create or replace Procedure Registro(
    Nmb in Usuario.Nombre%TYPE,
    Usr in Usuario.Usuario%TYPE,
    Pass in Usuario.Passwords%TYPE,
    Pic in Usuario.Foto%TYPE
)is
begin
    insert into Usuario (Nombre, Usuario,Passwords, Foto, ModoBot) values(Nmb,Usr,Pass,Pic,0);
end;
    


drop procedure Login;

create or replace Procedure Login(
            usr in usuario.usuario%TYPE,
            pass in usuario.passwords%TYPE
)as 
    c SYS_REFCURSOR;
begin
    OPEN c for
    select Usuario from Usuario where (Usuario=usr and Passwords=pass);
    dbms_sql.return_result(c);
end Login;


commit;
