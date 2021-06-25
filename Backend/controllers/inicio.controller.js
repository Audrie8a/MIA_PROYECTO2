const BD = require('../BD/conexion');

//Ingresar
exports.ingresar = async (req, res) => {
    try {
        const { Usuario, Passwords } = req.body
        let sql = `select Usuario from Usuario where Usuario='${Usuario}' and Passwords='${Passwords}'`
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
        let sql = `insert into Usuario (Nombre, Usuario, Passwords, Foto) values ('${Nombre}','${Usuario}','${Passwords}', '${Foto}')`;
        await BD.Open(sql, [], true);
        console.log("Usuario creado exitosamente");
        res.json("true")
    }
    catch (error) {
        console.log("Error al crear el usuario => ", error)
        res.json("error")
    }
}

