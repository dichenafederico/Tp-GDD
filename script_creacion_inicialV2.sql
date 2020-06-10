USE [GD1C2020]
GO


--COSAS A HACER:
--Creación de Esquema (y sus drop previos)
--Creación de Tablas (y sus drop previos)
--OPCIONAL: Creación de triggers
--OPCIONAL: Creación de vistas
--OPCIONAL: Creación de funciones escalares
--Creación de stored procedures para llenar las tablas del DER
--Ejecución de stored procedures anteriores
--Drop de tablas reales auxiliares. Deben quedar solo las tablas del DER

-------------------------------------------------------------------------------------------------
-----------------------------------DROP DE TABLES------------------------------------------------
-------------------------------------------------------------------------------------------------
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].RUTA_AEREA', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[RUTA_AEREA];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].VUELO', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[VUELO];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].AVION', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[AVION];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].AEROLINEA', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[AEROLINEA];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].PASAJE', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[PASAJE];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].VENTA_PASAJE', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[VENTA_PASAJE];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].COMPRA_PASAJE', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[COMPRA_PASAJE];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BUTACA', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BUTACA];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].COMPRA', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[COMPRA];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].COMPRA_HABITACION', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[COMPRA_HABITACION];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].HABITACION', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[HABITACION];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].ESTADIA_HABITACION', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[ESTADIA_HABITACION];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].TIPO_HABITACION', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[TIPO_HABITACION];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].HOTEL', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[HOTEL];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].TIPO_OPERACION', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[TIPO_OPERACION];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].VENTA_HABITACION', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[VENTA_HABITACION];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].VENTA', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[VENTA];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].CLIENTE', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[CLIENTE];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].SUCURSAL', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[SUCURSAL];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].FACTURA', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[FACTURA];


-------------------------------------------------------------------------------------------------
-----------------------------------CREACIÓN SCHEMA-----------------------------------------------
-------------------------------------------------------------------------------------------------


IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'SELECT_BEST_TEAM_FROM_CUARENTENA')
BEGIN
	EXEC ('CREATE SCHEMA [SELECT_BEST_TEAM_FROM_CUARENTENA] AUTHORIZATION gd') --Buscar cuál es el usuario correcto con el que crear el schema
END
GO

-------------------------------------------------------------------------------------------------
-----------------------------------CREACIÓN DE TABLAS--------------------------------------------
-------------------------------------------------------------------------------------------------


CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Ciudad(
	id_ciudad integer IDENTITY PRIMARY KEY,
	ciudad_nombre nvarchar(255) NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Ruta_Aerea(
	id_ruta_aerea integer IDENTITY PRIMARY KEY,
	ruta_aerea_codigo numeric(18, 0) NOT NULL,	
	ruta_aerea_ciu_orig integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Ciudad(id_ciudad),
	ruta_aerea_ciu_dest integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Ciudad(id_ciudad)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Aerolinea(
	id_aerolinea integer IDENTITY PRIMARY KEY,
	aerolinea_razon_social nvarchar(255) NOT NULL,	
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Avion(
	id_avion integer IDENTITY PRIMARY KEY,
	avion_modelo nvarchar(50) NOT NULL,
	avion_identificador nvarchar(50) NOT NULL,
	id_aerolinea integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Aerolinea(id_aerolinea)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Vuelo(
	id_vuelo integer IDENTITY PRIMARY KEY,
	vuelo_codigo numeric(19, 0) NOT NULL,
	vuelo_fecha_salida datetime NOT NULL,
	vuelo_fecha_llegada datetime NOT NULL,
	id_avion integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Avion(id_avion),
	id_ruta_aerea integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Ruta_Aerea(id_ruta_aerea)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Pasaje(
	id_pasaje integer IDENTITY PRIMARY KEY,
	pasaje_codigo numeric(18, 0) NOT NULL,
	pasaje_costo numeric(18, 2) NOT NULL,
	pasaje_precio numeric(18, 2) NOT NULL,
	pasaje_fecha_compra datetime NOT NULL,
	id_avion integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Avion(id_avion),
	id_butaca integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca(id_butaca)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca(
	id_butaca integer IDENTITY PRIMARY KEY,
	butaca_numero numeric(18, 0) NOT NULL,
	butaca_tipo nvarchar(255) NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca_Avion(
	id_butaca integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca(id_butaca),
	id_avion integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Avion(id_avion),
	PRIMARY KEY (id_butaca,id_avion)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Operacion(
	id_tipo_operacion integer IDENTITY PRIMARY KEY,
	descripcion nvarchar(50) NOT NULL,
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Sucursal(
	id_sucursal integer IDENTITY PRIMARY KEY,
	sucursal_dir nvarchar(255) NOT NULL,
	sucursal_mail nvarchar(255) NOT NULL,
	sucursal_telefono numeric(18, 0) NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Cliente(
	id_cliente integer IDENTITY PRIMARY KEY,
	cliente_apellido nvarchar(255) NOT NULL,
	cliente_nombre nvarchar(255) NOT NULL,
	cliente_dni numeric(18, 0) NOT NULL,
	cliente_fecha_nac datetime NOT NULL,
	cliente_mail nvarchar(255) NOT NULL,
	cliente_telefono integer NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta(
	id_venta integer IDENTITY PRIMARY KEY,
	venta_numero numeric(18, 0) NOT NULL,
	id_tipo_operacion integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Operacion(id_tipo_operacion),
	venta_fecha datetime NOT NULL,
	id_sucursal integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Sucursal(id_sucursal),
	id_cliente integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Cliente(id_cliente)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta_Pasaje(
	id_venta integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta(id_venta),
	id_pasaje integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Pasaje(id_pasaje),
	PRIMARY KEY (id_venta,id_pasaje)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Factura(
	id_factura integer IDENTITY PRIMARY KEY,
	factura_fecha datetime NOT NULL,
	factura_nro numeric(18, 0) NOT NULL,
	id_venta integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta(id_venta)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Hotel(
	id_hotel integer IDENTITY PRIMARY KEY,
	hotel_calle nvarchar(50) NOT NULL,
	hotel_nro_calle numeric(18, 0) NOT NULL,
	hotel_razon_social nvarchar(255) NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Habitacion(
	id_tipo_habitacion integer IDENTITY PRIMARY KEY,
	tipo_habitacion_codigo numeric(18, 0) NOT NULL,
	tipo_habitacion_desc nvarchar(50) NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Habitacion(
	id_habitacion integer IDENTITY PRIMARY KEY,
	habitacion_numero numeric(18, 0) NOT NULL,
	habitacion_piso numeric(18, 0) NOT NULL,
	habitacion_frente nvarchar(50) NOT NULL,
	habitacion_costo  numeric(18, 2) NOT NULL,
	habitacion_precio  numeric(18, 0) NOT NULL,
	id_hotel integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Hotel(id_hotel),
	id_tipo_habitacion integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Habitacion(id_tipo_habitacion)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra(
	id_compra integer IDENTITY PRIMARY KEY,
	compra_numero numeric(18, 0) NOT NULL,
	compra_fecha datetime NOT NULL,
	id_tipo_operacion integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Operacion(id_tipo_operacion),
	id_aerolinea integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Aerolinea(id_aerolinea),
	id_hotel integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Hotel(id_hotel)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra_Pasaje(
	id_compra integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra(id_compra),
	id_pasaje integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Pasaje(id_pasaje),
	PRIMARY KEY (id_compra,id_pasaje)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Estadia(
	id_estadia integer IDENTITY PRIMARY KEY,
	estadia_fecha datetime NOT NULL,
	estadia_checkin datetime NOT NULL,
	estadia_checkout datetime NOT NULL,
	estadia_cantidad_noches  numeric(18, 0) NOT NULL,
	estadia_codigo  numeric(18, 0) NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Estadia_Habitacion(
	id_estadia integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Estadia(id_estadia),
	id_habitacion integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Habitacion(id_habitacion),
	PRIMARY KEY (id_estadia,id_habitacion)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra_Estadias(
	id_compra integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra(id_compra),
	id_estadia integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Estadia(id_estadia),
	PRIMARY KEY (id_compra,id_estadia)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta_Habitacion(
	id_venta integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta(id_venta),
	id_habitacion integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Habitacion(id_habitacion),
	PRIMARY KEY (id_venta,id_habitacion)
	)
GO

--------------------------------------------------------------
-------------------Migración de los datos---------------------
--------------------------------------------------------------

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Operacion (descripcion) values
	('Estadia'),
	('Pasaje')
GO	

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Ciudad (ciudad_nombre) 
	SELECT DISTINCT RUTA_AEREA_CIU_ORIG 
	FROM gd_esquema.Maestra 
GO	

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Ruta_Aerea (ruta_aerea_codigo,ruta_aerea_ciu_orig,ruta_aerea_ciu_dest) 
	SELECT DISTINCT RUTA_AEREA_CODIGO,RUTA_AEREA_CIU_ORIG,RUTA_AEREA_CIU_DEST
	FROM gd_esquema.Maestra
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Aerolinea (aerolinea_razon_social) 
	SELECT DISTINCT EMPRESA_RAZON_SOCIAL
	FROM gd_esquema.Maestra Where HOTEL_CALLE = null
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Avion (avion_modelo,avion_identificador,id_aerolinea) 
	SELECT DISTINCT AVION_MODELO,AVION_IDENTIFICADOR
	FROM gd_esquema.Maestra
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Vuelo (vuelo_codigo,vuelo_fecha_salida,vuelo_fecha_llegada,id_avion,id_ruta_aerea) 
	SELECT DISTINCT VUELO_CODIGO,VUELO_FECHA_SALUDA,VUELO_FECHA_LLEGADA,AVION_IDENTIFICADOR,r.ruta_aerea_codigo
	FROM gd_esquema.Maestra m
	 join [SELECT_BEST_TEAM_FROM_CUARENTENA].Ruta_Aerea r
	 on r.ruta_aerea_codigo = m.RUTA_AEREA_CODIGO 
	 where m.RUTA_AEREA_CODIGO != null
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca (butaca_numero,butaca_tipo) 
	SELECT DISTINCT BUTACA_NUMERO,BUTACA_TIPO
	FROM gd_esquema.Maestra
GO


INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Pasaje (pasaje_codigo,pasaje_costo,pasaje_precio,pasaje_fecha_compra,id_avion,id_butaca) 
	SELECT DISTINCT PASAJE_CODIGO,PASAJE_COSTO,PASAJE_PRECIO,PASAJE_FECHA_COMPRA,VUELO_CODIGO
	FROM gd_esquema.Maestra
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca_Avion (id_avion) 
	SELECT DISTINCT BUTACA_NUMERO,AVION_IDENTIFICADOR
	FROM gd_esquema.Maestra
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Sucursal (sucursal_dir,sucursal_mail,sucursal_telefono) 
	SELECT DISTINCT SUCURSAL_DIR,SUCURSAL_MAIL,SUCURSAL_TELEFONO
	FROM gd_esquema.Maestra
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Cliente (cliente_apellido,cliente_nombre,cliente_dni,cliente_fecha_nac,cliente_mail,cliente_telefono) 
	SELECT DISTINCT CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DNI,CLIENTE_FECHA_NAC,CLIENTE_MAIL,CLIENTE_TELEFONO
	FROM gd_esquema.Maestra
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Hotel (hotel_calle,hotel_nro_calle,hotel_razon_social) 
	SELECT DISTINCT HOTEL_CALLE,HOTEL_NRO_CALLE, EMPRESA_RAZON_SOCIAL
	FROM gd_esquema.Maestra Where HOTEL_CALLE != null
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Habitacion (tipo_habitacion_codigo,tipo_habitacion_desc) 
	SELECT DISTINCT TIPO_HABITACION_CODIGO,TIPO_HABITACION_DESC
	FROM gd_esquema.Maestra 
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Habitacion (habitacion_numero,habitacion_piso,habitacion_frente,habitacion_costo,habitacion_precio,id_hotel,id_tipo_habitacion) 
	SELECT DISTINCT HABITACION_NUMERO,HABITACION_PISO,HABITACION_FRENTE,HABITACION_COSTO,HABITACION_PRECIO, 
	(SELECT id_hotel from [SELECT_BEST_TEAM_FROM_CUARENTENA].hotel h
	 where hotel_razon_social = m.EMPRESA_RAZON_SOCIAL AND HOTEL_CALLE != null ),
	 TIPO_HABITACION_CODIGO
	FROM gd_esquema.Maestra m
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Estadia (estadia_fecha,estadia_checkin,estadia_checkout,estadia_cantidad_noches,estadia_codigo) 
	SELECT DISTINCT ESTADIA_FECHA_INI,ESTADIA_FECHA_INI, (DATEADD(dd, estadia_cantidad_noches, ESTADIA_FECHA_INI)),ESTADIA_CANTIDAD_NOCHES,ESTADIA_CODIGO 
	FROM gd_esquema.Maestra 
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta (venta_numero,id_tipo_operacion,venta_fecha,id_sucursal,id_cliente) 
	SELECT DISTINCT FACTURA_NRO, (CASE WHEN HOTEL_CALLE = NULL THEN 2 ELSE 1 END), FACTURA_FECHA, s.id_sucursal, c.id_cliente
	FROM gd_esquema.Maestra m
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Sucursal s
	on s.sucursal_dir = m.SUCURSAL_DIR
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Cliente c
	on c.cliente_dni = m.CLIENTE_DNI
	where m.cliente_dni != null AND m.sucursal_dir != null
GO


INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Factura (factura_fecha,factura_nro,id_venta) 
	SELECT DISTINCT FACTURA_FECHA,FACTURA_NRO
	FROM gd_esquema.Maestra
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta v
	on FACTURA_NRO = v.venta_numero
	where FACTURA_NRO != null 
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta_Pasaje (id_venta,id_pasaje) 
	SELECT  v.id_venta, p.id_pasaje
	FROM gd_esquema.Maestra m
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta v
	on v.venta_numero = m.FACTURA_NRO 
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Pasaje p
	on p.pasaje_codigo = m.PASAJE_CODIGO
	where m.FACTURA_NRO != null AND m.PASAJE_CODIGO != null
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra (compra_numero,compra_fecha,id_tipo_operacion,id_aerolinea,id_hotel) 
	SELECT DISTINCT COMPRA_NUMERO, COMPRA_FECHA, (CASE WHEN m.HOTEL_CALLE = NULL THEN 2 ELSE 1 END), a.id_aerolinea, h.id_hotel
	FROM gd_esquema.Maestra m
	left join [SELECT_BEST_TEAM_FROM_CUARENTENA].Aerolinea a
	on a.aerolinea_razon_social = m.EMPRESA_RAZON_SOCIAL AND m.HOTEL_CALLE = null 
	left join [SELECT_BEST_TEAM_FROM_CUARENTENA].Hotel h
	on h.hotel_razon_social = m.EMPRESA_RAZON_SOCIAL AND m.HOTEL_CALLE != null
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra_Pasaje (id_compra,id_pasaje) 
	SELECT  c.id_compra, p.id_pasaje --distinct soolo para el pasaje?
	FROM gd_esquema.Maestra m
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra c
	on c.compra_numero = m.COMPRA_NUMERO 
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Pasaje p
	on p.pasaje_codigo = m.PASAJE_CODIGO
	where m.PASAJE_CODIGO != null
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra_Estadias (id_compra,id_estadia) 
	SELECT  c.id_compra, e.estadia_codigo --distinct solo para la estadia?
	FROM gd_esquema.Maestra m
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra c
	on c.compra_numero = m.COMPRA_NUMERO 
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Estadia e
	on e.estadia_codigo = m.ESTADIA_CODIGO
	where m.ESTADIA_CODIGO != null
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta_Habitacion (id_venta,id_habitacion) 
	SELECT  v.id_venta, h.id_habitacion --distinct solo para la habitacion?
	FROM gd_esquema.Maestra m
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta v
	on v.venta_numero = m.FACTURA_NRO 
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Habitacion h
	on h.habitacion_numero = m.HABITACION_NUMERO 
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Hotel hot
	on hot.id_hotel = h.id_hotel  
	where m.FACTURA_NRO != null AND m.HOTEL_CALLE != null
GO