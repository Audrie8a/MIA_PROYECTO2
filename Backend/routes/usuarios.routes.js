 
const express = require("express");
const router = express.Router();
const usuariosController= require("../controllers/usuarios.controller");

router.post("/login",usuariosController.ingresar);
//router.post("/crearUsuario",usuariosController.addUsuario);
router.post("/registro",usuariosController.addUsuario);
module.exports = router