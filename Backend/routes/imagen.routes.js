 
const express = require("express");
const router = express.Router();
const multer=require('multer');
const storage = multer.diskStorage({
    destination: function(req,file, cb){
        cb(null,'Public');
    },
    filename: function(req,file,cb){
        cb(null, `${file.originalname}`);
    },
})
const upload=(multer({storage}));
//const upload=multer({storage:storage});

router.post('/upload',upload.single('file'),(req,res)=>{
    const file=req.file;
    if(file){
        res.json(file);
    }else{
        throw new error("Archivo no accesibel!");
    }
})
module.exports = router