use Practica1_201701187
--Crear Tabla temporal
CREATE TABLE #Tabla_Temporal(
rut_proveedor int,
nombre varchar(500),
direccion varchar(500),
telefono bigint,
pagina_web varchar(500),
rut_cliente int,
nombre_cliente varchar(500),
apellido_cliente varchar(500),
direccion_cliente varchar(500),
telefono_cliente bigint,
id_producto int,
nombre_producto varchar(500),
descripcion varchar(500),
precio money,
stock int,
proveedor_prod int,
nombre_categoria varchar(500),
descripcion_categoria varchar(500),
id_venta int,
fecha_venta varchar(500),
cliente int,
descuento money,
monto_total money,
producto int,
cantidad int
);

BULK INSERT #Tabla_Temporal
FROM 'D:\Casca\Documents\IPC2\Practica 1\Archivo.csv'
   WITH 
      (
         FIELDTERMINATOR =';',
         ROWTERMINATOR ='\n',
		 FIRSTROW = 2
 );

 SELECT * FROM #Tabla_Temporal
 DROP TABLE #Tabla_Temporal

 INSERT INTO Cliente (RUT,Nombre,Apellido,Direccion)
 SELECT DISTINCT rut_cliente,nombre_cliente,apellido_cliente,direccion_cliente