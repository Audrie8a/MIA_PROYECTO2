const BD = require('../BD/conexion');
var crypto=require('crypto');



//Ingresar
exports.ingresar = async (req, res) => {
    try {
        const { Usuario, Passwords } = req.body
        let hash=crypto.createHash('md5').update(Passwords).digest('hex');
        let sql = `select Usuario from Usuario where Usuario='${Usuario}' and Passwords='${hash}'`
        let result = await BD.Open(sql, [], true);
        let usuarioSchema = {
            "Usuario": ""
        }
        usuario = result.rows.map(user => {
            usuarioSchema = {
                "Usuario": user[0]
            }

            return usuarioSchema
        })

        if (usuarioSchema.Usuario != '') {

            res.json(usuarioSchema.Usuario);
            console.log("Bienvenido ", usuarioSchema.Usuario);
        } else {
            res.json("false");
        }
    }
    catch (error) {
        console.log("Error al ingresar  => ", error)
        res.json("error")
    }
}

exports.addUsuario = async (req, res) => {
    try {
        const { Nombre, Usuario, Passwords, Foto } = req.body
        let hash=crypto.createHash('md5').update(Passwords).digest('hex');
        console.log(hash);
        let sql = `insert into Usuario (Nombre, Usuario, Passwords, Foto,ModoBot) values ('${Nombre}','${Usuario}','${hash}', '${Foto}',0)`;
        await BD.Open(sql, [], true);
        console.log("Usuario creado exitosamente");
        res.json("true")
    }
    catch (error) {
        console.log("Error al crear el usuario => ", error)
        res.json("error")
    }
}

//Ingresar
exports.Login = async (req, res) => {
    try {
        const { Usuario, Passwords } = req.body
        let hash=crypto.createHash('md5').update(Passwords).digest('hex');
        let sql = `call Login('${Usuario}','${hash}')`
        let result = await BD.Open(sql, [], true);
        let usuarioSchema = {
            "Usuario": ""
        }
        usuario = result.rows.map(user => {
            usuarioSchema = {
                "Usuario": user[0]
            }

            return usuarioSchema
        })

        if (usuarioSchema.Usuario != '') {

            res.json(usuarioSchema.Usuario);
            console.log("Bienvenido ", usuarioSchema.Usuario);
        } else {
            res.json("false");
        }
    }
    catch (error) {
        console.log("Error al ingresar  => ", error)
        res.json("error")
    }
}

exports.Registro = async (req, res) => {
    try {
        const { Nombre, Usuario, Passwords, Foto } = req.body
        let hash=crypto.createHash('md5').update(Passwords).digest('hex');
        console.log(hash);
        let sql = `call Registro ('${Nombre}','${Usuario}','${hash}', '${Foto}')`;
        await BD.Open(sql, [], true);
        console.log("Usuario creado exitosamente");
        res.json("true")
    }
    catch (error) {
        console.log("Error al crear el usuario => ", error)
        res.json("error")
    }
}