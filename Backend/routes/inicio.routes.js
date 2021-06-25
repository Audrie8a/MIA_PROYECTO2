 
const express = require("express");
const router = express.Router();
const usuariosController= require("../controllers/inicio.controller");

router.post("/login",usuariosController.ingresar);
router.post("/registro",usuariosController.addUsuario);
module.exports = router