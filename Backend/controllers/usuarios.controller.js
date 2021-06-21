const BD = require('../BD/conexion');

//Ingresar
exports.ingresar = async (req, res) => {
    try {
        const { nickname, contrasena } = req.body
        let sql = `select cod_tipoUsuario from Usuario where nickname='${nickname}' and contrasena='${contrasena}'`
        let result = await BD.Open(sql, [], true);
        let usuarioSchema = {
            "cod_Tipo": ""
        }
        usuario = result.rows.map(user => {
            usuarioSchema = {
                "cod_Tipo": user[0]
            }

            return usuarioSchema
        })

        if (usuarioSchema.cod_Tipo != '') {

            res.json(usuarioSchema.cod_Tipo);
            console.log(usuarioSchema.cod_Tipo);
        } else {
            res.json("false");
        }
    }
    catch (error) {
        console.log("Error al crear el usuario => ", error)
        res.json("error")
    }
}

