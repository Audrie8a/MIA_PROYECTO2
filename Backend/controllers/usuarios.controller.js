const BD = require('../BD/conexion');
var crypto=require('crypto');

//Obtener Publicaciones Usuario
exports.getPublicaciones = async (req, res) => {
    try {
        const { Usuario} = req.body

        //Lista Amigos Que les envió solicitud de amistad
        let sql = `select solicitudamistad.usuariob
        from SolicitudAmistad, Usuario
        where SolicitudAmistad.usuarioa=usuario.usuario
        and solicitudamistad.id_estadoamistad=1
        and Usuario.usuario='${Usuario}'`;
        //console.log(sql);
        let result = await BD.Open(sql, [], true);
        let ListaUsuarios=["'"+Usuario+"'"];
        result.rows.map( user=>{
            ListaUsuarios.push( "'"+user[0]+"'");
        }
        );
        //Lista Amigos Que le enviaron solicitud de amistad
        sql = `select solicitudamistad.usuarioa
        from SolicitudAmistad, Usuario
        where SolicitudAmistad.usuariob=usuario.usuario
        and solicitudamistad.id_estadoamistad=1
        and Usuario.usuario='${Usuario}'`;
        result = await BD.Open(sql, [], true);
        result.rows.map( user=>{
           ListaUsuarios.push( "'"+user[0]+"'");
        }
        );

        let Amigos ="";
        for (let index = 0; index < ListaUsuarios.length; index++) {
            if(index!=ListaUsuarios.length-1){
                Amigos+=ListaUsuarios[index]+",";
            }else{
                Amigos+=ListaUsuarios[index];
            }
            
        }

        
        let publicacionSchema = {
            "id_Publicacion":"",
            "Fecha": "",
            "Texto": "",
            "Imagen": "",
            "Usuario": "",
            "Tags":""
        }

        sql = `select  distinct publicacion.id_publicacion ,Publicacion.Fecha, publicacion.texto, publicacion.imagen,usuario.usuario
        from Publicacion, Usuario, Publicar
        where publicacion.usuario=usuario.usuario
        and publicacion.id_publicacion=publicar.id_publicacion
        and usuario.usuario in (${Amigos})
        order by publicacion.fecha desc`;
        result = await BD.Open(sql, [], true);

        
        let lstIdsPublicaciones=[];
        result.rows.map(ids=>{
            lstIdsPublicaciones.push(ids[0]);
        })

        let lstTags=[];
        for (let index = 0; index < lstIdsPublicaciones.length; index++) {
            sql=`select tags.tags
            from Publicacion, Publicar, Tags
            where Publicacion.id_Publicacion= publicar.id_publicacion
            and tags.id_tag=publicar.id_tag
            and publicacion.id_publicacion=${lstIdsPublicaciones[index]}`;
            let result2 = await BD.Open(sql,[],true);
            let Tags="";

            
            result2.rows.map(tgs=>{
                Tags+=tgs[0]+" ";
            });

            lstTags.push(Tags);
        }
        
        let cont =0;
        Publicaciones = result.rows.map(user => {
            
            publicacionSchema = {
                "id_Publicacion": user[0],
                "Fecha":user[1],
                "Texto":user[2],
                "Imagen":user[3],
                "Usuario":user[4],
                "Tags":lstTags[cont]
            }
            cont++;
            return publicacionSchema
        })

        
        if (publicacionSchema.Usuario != '') {

            res.json(Publicaciones);
            console.log("Obteniendo Publicaciones Usuario!");
        } else {
            console.log("No hay publicaciones que mostrar!");
            res.json("false");
        }
    }
    catch (error) {
        console.log("Error al obtener Publicaciones  => ", error)
        res.json("error")
    }
}

//Obtener Amigos Usuario
exports.getAmigos = async (req, res) => {
    try {
        
        const { Usuario} = req.body

        //Lista Amigos Que les envió solicitud de amistad
        let sql = `select solicitudamistad.usuariob
        from SolicitudAmistad, Usuario
        where SolicitudAmistad.usuarioa=usuario.usuario
        and solicitudamistad.id_estadoamistad=1
        and Usuario.usuario='${Usuario}'`;
        //console.log(sql);
        let result = await BD.Open(sql, [], true);
        let ListaUsuarios=[];
        result.rows.map( user=>{
            ListaUsuarios.push(user[0]);
        }
        );
        //Lista Amigos Que le enviaron solicitud de amistad
        sql = `select solicitudamistad.usuarioa
        from SolicitudAmistad, Usuario
        where SolicitudAmistad.usuariob=usuario.usuario
        and solicitudamistad.id_estadoamistad=1
        and Usuario.usuario='${Usuario}'`;
        result = await BD.Open(sql, [], true);
        result.rows.map( user=>{
           ListaUsuarios.push( user[0]);
        }
        );
        

        let Amigos=[];
        let Amigo = {
            "Usuario":""
        }

        
        for (let index = 0; index < ListaUsuarios.length; index++) {
            Amigo={
                "Usuario": ListaUsuarios[index]
            }
            Amigos.push(Amigo);
        }
        
       res.json(Amigos);
    }
    catch (error) {
        console.log("Error al obtener Amigos  => ", error)
        res.json("error")
    }
}

exports.getSugerencias = async (req, res) => {
    try {        
        const { Usuario} = req.body

        //Lista Amigos Que les envió solicitud de amistad
        let sql = `select solicitudamistad.usuariob
        from SolicitudAmistad, Usuario
        where SolicitudAmistad.usuarioa=usuario.usuario
        and solicitudamistad.id_estadoamistad=1
        and Usuario.usuario='${Usuario}'`;
        //console.log(sql);
        let result = await BD.Open(sql, [], true);
        let ListaUsuarios=["'"+Usuario+"'"];
        result.rows.map( user=>{
            ListaUsuarios.push("'"+user[0]+"'");
        }
        );
        //Lista Amigos Que le enviaron solicitud de amistad
        sql = `select solicitudamistad.usuarioa
        from SolicitudAmistad, Usuario
        where SolicitudAmistad.usuariob=usuario.usuario
        and solicitudamistad.id_estadoamistad=1
        and Usuario.usuario='${Usuario}'`;
        result = await BD.Open(sql, [], true);
        result.rows.map( user=>{
           ListaUsuarios.push( "'"+user[0]+"'");
        }
        );

        let Amigos ="";
        for (let index = 0; index < ListaUsuarios.length; index++) {
            if(index!=ListaUsuarios.length-1){
                Amigos+=ListaUsuarios[index]+",";
            }else{
                Amigos+=ListaUsuarios[index];
            }
            
        }

        sql = `select distinct usuario.usuario
        from Usuario
        where usuario.usuario not in (${Amigos})`;
        result = await BD.Open(sql, [], true);

        let lstAmigos=[];
        let Amigo = {
            "Usuario":""
        }
        
        
        result.rows.map( user=>{
            Amigo={
                "Usuario": user[0]
            }
            lstAmigos.push(Amigo);
        });
        
       res.json(lstAmigos);
       
    }
    catch (error) {
        console.log("Error al obtener Sugerencias!  => ", error)
        res.json("error")
    }
}

exports.getDatosUsuario = async (req, res) => {
    try {        
        const { Usuario} = req.body

        //Lista Amigos Que les envió solicitud de amistad
        let sql = `select * from Usuario
        where Usuario='${Usuario}'`;
        //console.log(sql);
        let result = await BD.Open(sql, [], true);
        
        let Dato = {
            "Nombre":"",
            "Usuario":"",
            "Passwords":"",
            "Foto":"",
            "ModoBot":""
        }

        
        result.rows.map( user=>{
            Dato = {
                "Nombre": user[1],
                "Usuario":user[2],
                "Passwords":user[3],
                "Foto":user[4],
                "ModoBot":user[5]
            }
        });
        
        //FALTA DESENCRIPTAR LA CONTRASEÑA

       res.json(Dato);
    }
    catch (error) {
        console.log("Error al obtener Datos del Usuario  => ", error)
        res.json("error")
    }
}

exports.updateDatosUsuario = async (req, res) => {
    try {        
        const { Usuario,Nombre,Passwords,Foto,ModoBot} = req.body
        //Lista Amigos Que les envió solicitud de amistad
        let sql = `update Usuario set Nombre='${Nombre}', Passwords='${Passwords}', Foto='${Foto}' , ModoBot=${ModoBot}
        where Usuario='${Usuario}'`;
        
        let result = await BD.Open(sql, [], true);

        console.log("Datos Editados!");
        res.json("true");
    }
    catch (error) {
        console.log("Error al actualizar Datos  => ", error)
        res.json("error")
    }
}

exports.eliminarAmigo = async (req, res) => {
    try {        
        const { Usuario,Amigs} = req.body

        //Lista Amigos Que les envió solicitud de amistad
        let sql = `delete from SolicitudAmistad where (SolicitudAmistad.usuarioa='${Usuario}' and SolicitudAmistad.usuariob='${Amigs}') 
        or (solicitudamistad.usuariob='${Usuario}' and solicitudamistad.usuarioa='${Amigs}')`;

        let result = await BD.Open(sql, [], true);
        
        console.log("Amigo Eliminado!");
        res.json("true");
    }
    catch (error) {
        console.log("Error al eliminar Amigo  => ", error)
        res.json("error")
    }
}

exports.agregarAmigo = async (req, res) => {
    try {        
        const { UsuarioA,UsuarioB} = req.body

        //Lista Amigos Que les envió solicitud de amistad
        let sql = `insert into SolicitudAmistad (UsuarioA, UsuarioB, Fecha, id_EstadoAmistad) values('${UsuarioA}','${UsuarioB}',(select current_date from dual),1)`;
        let result = await BD.Open(sql, [], true);
        
        console.log("Amigo Agregado!");
        res.json("true");
    }
    catch (error) {
        console.log("Error al agregar Amigo  => ", error)
        res.json("error")
    }
}

exports.crearPublicacion = async (req, res) => {
    try {        
        const { Usuario,Texto,Imagen,Tags} = req.body

        var string=Tags.split("**");

        //Lista Amigos Que les envió solicitud de amistad
        let sql = `insert into Publicacion (Fecha,Usuario, Texto, Imagen) 
        values ((select current_date from dual),'${Usuario}','${Texto}', '${Imagen}')`;
        let result = await BD.Open(sql, [], true);

        for (let index = 0; index < string.length; index++) {
            if(string[index]!=''){
                sql=`call insertTags('${string[index]}')`;
                result=await BD.Open(sql,[],true);
            }
            
        }
        console.log("Publicando!");
        res.json("true");
    }
    catch (error) {
        console.log("Error al agregar Amigo  => ", error)
        res.json("error")
    }
}

exports.getPublicacionesFiltradas = async (req, res) => {
    try {
        const { Usuario,Tag1} = req.body

        //Lista Amigos Que les envió solicitud de amistad
        let sql = `select solicitudamistad.usuariob
        from SolicitudAmistad, Usuario
        where SolicitudAmistad.usuarioa=usuario.usuario
        and solicitudamistad.id_estadoamistad=1
        and Usuario.usuario='${Usuario}'`;
        //console.log(sql);
        let result = await BD.Open(sql, [], true);
        let ListaUsuarios=["'"+Usuario+"'"];
        result.rows.map( user=>{
            ListaUsuarios.push( "'"+user[0]+"'");
        }
        );
        //Lista Amigos Que le enviaron solicitud de amistad
        sql = `select solicitudamistad.usuarioa
        from SolicitudAmistad, Usuario
        where SolicitudAmistad.usuariob=usuario.usuario
        and solicitudamistad.id_estadoamistad=1
        and Usuario.usuario='${Usuario}'`;
        result = await BD.Open(sql, [], true);
        result.rows.map( user=>{
           ListaUsuarios.push( "'"+user[0]+"'");
        }
        );

        let Amigos ="";
        for (let index = 0; index < ListaUsuarios.length; index++) {
            if(index!=ListaUsuarios.length-1){
                Amigos+=ListaUsuarios[index]+",";
            }else{
                Amigos+=ListaUsuarios[index];
            }
            
        }

        var string=Tag1.split("**");
        let Tags="";
        for (let index = 0; index < string.length-1; index++) {
            if(string[index]!=''){
                if(index!=string.length-2){
                    Tags+="Lower("+string[index]+")"+",";
                }else{
                    Tags+="Lower("+string[index]+")";
                }
            }
            
        }

        let publicacionSchema = {
            "id_Publicacion":"",
            "Fecha": "",
            "Texto": "",
            "Imagen": "",
            "Usuario": "",
            "Tags":""
        }

        sql = `select distinct Publicacion.id_Publicacion, Publicacion.Fecha,Publicacion.Texto, Publicacion.Imagen, Publicacion.Usuario
        from Publicar, Publicacion, Tags
        where publicar.id_tag=tags.id_tag
        and Publicar.id_Publicacion=publicacion.id_publicacion
        and Lower(tags.tags) in (${Tags})
        and Publicacion.Usuario in (${Amigos})
        order by publicacion.fecha desc`;
        result = await BD.Open(sql, [], true);

        let lstIdsPublicaciones=[];
        result.rows.map(ids=>{
            lstIdsPublicaciones.push(ids[0]);
        })
        
        let lstTags=[];
        for (let index = 0; index < lstIdsPublicaciones.length; index++) {
            sql=`select tags.tags
            from Publicacion, Publicar, Tags
            where Publicacion.id_Publicacion= publicar.id_publicacion
            and tags.id_tag=publicar.id_tag
            and publicacion.id_publicacion=${lstIdsPublicaciones[index]}`;
            let result2 = await BD.Open(sql,[],true);
            let Tags="";

            result2.rows.map(tgs=>{
                Tags+=tgs[0]+" ";
            });

            lstTags.push(Tags);
        }
        
        let cont =0;
        Publicaciones = result.rows.map(user => {
            
            publicacionSchema = {
                "id_Publicacion": user[0],
                "Fecha":user[1],
                "Texto":user[2],
                "Imagen":user[3],
                "Usuario":user[4],
                "Tags":lstTags[cont]
            }
            cont++;
            return publicacionSchema
        })

        
        if (publicacionSchema.Usuario != '') {

            res.json(Publicaciones);
            console.log("Obteniendo Publicaciones Usuario!");
        } else {
            console.log("No hay publicaciones que mostrar!");
            res.json("false");
        }
    }
    catch (error) {
        console.log("Error al obtener Publicaciones  => ", error)
        res.json("error")
    }
}
