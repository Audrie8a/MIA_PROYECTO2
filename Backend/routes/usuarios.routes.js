 
const express = require("express");
const router = express.Router();
const usuariosController= require("../controllers/usuarios.controller");

router.post("/Publicaciones",usuariosController.getPublicaciones);
router.post("/Amigos",usuariosController.getAmigos);
router.post("/Sugerencias",usuariosController.getSugerencias);
router.post("/Datos",usuariosController.getDatosUsuario);
router.post("/UpdateDatos",usuariosController.updateDatosUsuario);
router.post("/Eliminar",usuariosController.eliminarAmigo);
router.post("/Agregar",usuariosController.agregarAmigo);
router.post("/Publicar",usuariosController.crearPublicacion);

module.exports = router