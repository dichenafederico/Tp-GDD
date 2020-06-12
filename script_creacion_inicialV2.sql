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
-----------------------------------CREACIÓN SCHEMA-----------------------------------------------
-------------------------------------------------------------------------------------------------

GO
	CREATE SCHEMA [SELECT_BEST_TEAM_FROM_CUARENTENA] --Buscar cuál es el usuario correcto con el que crear el schema
GO


-------------------------------------------------------------------------------------------------
-----------------------------------DROP DE TABLES------------------------------------------------
-------------------------------------------------------------------------------------------------

IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Venta_Habitacion', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Venta_Habitacion];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Compra_Estadias', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Compra_Estadias];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Compra_Pasaje', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Compra_Pasaje];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Compra', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Compra];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Venta_Pasaje', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Venta_Pasaje];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Factura', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Factura];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Venta', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Venta];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Estadia_Habitacion', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Estadia_Habitacion];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Estadia', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Estadia];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Habitacion', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Habitacion];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Habitacion', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Tipo_Habitacion];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Hotel', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Hotel];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Cliente', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Cliente];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Sucursal', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Sucursal];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca_Avion', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Butaca_Avion];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Pasaje', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Pasaje];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Butaca];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Vuelo', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Vuelo];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Avion', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Avion];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Aerolinea', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Aerolinea];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Ruta_Aerea', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Ruta_Aerea];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Ciudad', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Ciudad];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Operacion', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[Tipo_Operacion];




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

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca(
	id_butaca integer IDENTITY PRIMARY KEY,
	butaca_numero numeric(18, 0) NOT NULL,
	butaca_tipo nvarchar(255) NOT NULL
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
	id_aerolinea integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Aerolinea(id_aerolinea), --Lo hice nulleable
	id_hotel integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Hotel(id_hotel) -- Lo hice nulleable
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

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Operacion (descripcion) values --FUNCIONA
	('Estadia'),
	('Pasaje')
GO	

SELECT * FROM gd_esquema.Maestra

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Ciudad (ciudad_nombre) -- FUNCIONA
	SELECT DISTINCT RUTA_AEREA_CIU_ORIG --deberia agregar tambien ciudad destino? nose si puede haber alguna ciudad que no este como origen
	FROM gd_esquema.Maestra 
	WHERE RUTA_AEREA_CIU_ORIG IS NOT NULL
GO	


INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Ruta_Aerea (ruta_aerea_codigo,ruta_aerea_ciu_orig,ruta_aerea_ciu_dest) -- FUNCIONA
	SELECT DISTINCT RUTA_AEREA_CODIGO,
		(SELECT id_ciudad FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Ciudad c WHERE m.ruta_aerea_ciu_orig = c.ciudad_nombre),
		(SELECT id_ciudad FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Ciudad c WHERE m.ruta_aerea_ciu_dest = c.ciudad_nombre)
	FROM gd_esquema.Maestra m
	WHERE RUTA_AEREA_CODIGO IS NOT NULL
GO


INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Aerolinea (aerolinea_razon_social) --FUNCIONA
	SELECT DISTINCT EMPRESA_RAZON_SOCIAL
	FROM gd_esquema.Maestra Where HOTEL_CALLE IS NULL
GO


INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Avion (avion_modelo,avion_identificador,id_aerolinea) --FUNCIONA
	SELECT DISTINCT AVION_MODELO,AVION_IDENTIFICADOR, 
		(SELECT id_aerolinea FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Aerolinea a WHERE a.aerolinea_razon_social = m.EMPRESA_RAZON_SOCIAL)
	FROM gd_esquema.Maestra m
	WHERE AVION_MODELO IS NOT NULL AND AVION_IDENTIFICADOR IS NOT NULL
GO


INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Vuelo (vuelo_codigo,vuelo_fecha_salida,vuelo_fecha_llegada,id_avion,id_ruta_aerea) --FUNCIONA
	SELECT DISTINCT VUELO_CODIGO,VUELO_FECHA_SALUDA,VUELO_FECHA_LLEGADA,a.id_avion,r.id_ruta_aerea
	FROM gd_esquema.Maestra m
	 join [SELECT_BEST_TEAM_FROM_CUARENTENA].Ruta_Aerea r
	 on r.ruta_aerea_codigo = m.RUTA_AEREA_CODIGO 
	 join [SELECT_BEST_TEAM_FROM_CUARENTENA].Avion a
	 on m.AVION_IDENTIFICADOR = a.avion_identificador 
	 where m.RUTA_AEREA_CODIGO IS NOT NULL
GO


INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca (butaca_numero,butaca_tipo) --FUNCIONA
	SELECT DISTINCT BUTACA_NUMERO,BUTACA_TIPO
	FROM gd_esquema.Maestra m
	WHERE BUTACA_NUMERO IS NOT NULL AND BUTACA_TIPO IS NOT NULL
	ORDER BY BUTACA_NUMERO
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Pasaje (pasaje_codigo,pasaje_costo,pasaje_precio,pasaje_fecha_compra,id_avion,id_butaca) --FUNCIONA PERO PASAJE_FECHA_COMPRA tiene valores nulos , que hacemos? 
	SELECT DISTINCT m.PASAJE_CODIGO,m.PASAJE_COSTO,m.PASAJE_PRECIO,m.PASAJE_FECHA_COMPRA, a.id_avion, b.id_butaca 
	FROM gd_esquema.Maestra m
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Avion a
	on m.AVION_IDENTIFICADOR = a.avion_identificador 
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca b
	on b.butaca_numero = m.BUTACA_NUMERO	
	where m.RUTA_AEREA_CODIGO IS NOT NULL AND m.PASAJE_FECHA_COMPRA IS NOT NULL
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca_Avion (id_butaca, id_avion) --FUNCIONA
	SELECT DISTINCT p.id_butaca,p.id_avion	
	FROM gd_esquema.Maestra m
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Pasaje p
	on m.PASAJE_CODIGO = p.pasaje_codigo
	WHERE m.PASAJE_CODIGO IS NOT NULL	
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Sucursal (sucursal_dir,sucursal_mail,sucursal_telefono) -- FUNCIONA
	SELECT DISTINCT SUCURSAL_DIR,SUCURSAL_MAIL,SUCURSAL_TELEFONO
	FROM gd_esquema.Maestra
	WHERE SUCURSAL_DIR IS NOT NULL
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Cliente (cliente_apellido,cliente_nombre,cliente_dni,cliente_fecha_nac,cliente_mail,cliente_telefono) -- FUNCIONA
	SELECT DISTINCT CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DNI,CLIENTE_FECHA_NAC,CLIENTE_MAIL,CLIENTE_TELEFONO
	FROM gd_esquema.Maestra
	WHERE CLIENTE_DNI IS NOT NULL
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Hotel (hotel_calle,hotel_nro_calle,hotel_razon_social) -- FUNCIONA
	SELECT DISTINCT HOTEL_CALLE,HOTEL_NRO_CALLE, EMPRESA_RAZON_SOCIAL
	FROM gd_esquema.Maestra Where HOTEL_CALLE IS NOT null
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Habitacion (tipo_habitacion_codigo,tipo_habitacion_desc) -- FUNCIONA
	SELECT DISTINCT TIPO_HABITACION_CODIGO,TIPO_HABITACION_DESC
	FROM gd_esquema.Maestra 
	WHERE TIPO_HABITACION_CODIGO IS NOT NULL
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Habitacion (habitacion_numero,habitacion_piso,habitacion_frente,habitacion_costo,habitacion_precio,id_hotel,id_tipo_habitacion) -- FUNCIONA
	SELECT DISTINCT HABITACION_NUMERO,HABITACION_PISO,HABITACION_FRENTE,HABITACION_COSTO,HABITACION_PRECIO,h.id_hotel,th.id_tipo_habitacion
	FROM gd_esquema.Maestra m
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Hotel h
	on m.EMPRESA_RAZON_SOCIAL = h.hotel_razon_social
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Habitacion th
	on m.TIPO_HABITACION_CODIGO = th.tipo_habitacion_codigo
	where m.HOTEL_CALLE IS NOT NULL
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Estadia (estadia_fecha,estadia_checkin,estadia_checkout,estadia_cantidad_noches,estadia_codigo) -- FUNCIONA
	SELECT DISTINCT ESTADIA_FECHA_INI,ESTADIA_FECHA_INI, (DATEADD(dd, estadia_cantidad_noches, ESTADIA_FECHA_INI)),ESTADIA_CANTIDAD_NOCHES,ESTADIA_CODIGO 
	FROM gd_esquema.Maestra 
	where ESTADIA_CODIGO IS NOT NULL
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta (venta_numero,id_tipo_operacion,venta_fecha,id_sucursal,id_cliente) --FUNCIONA
	SELECT DISTINCT FACTURA_NRO, (CASE WHEN HOTEL_CALLE IS NULL THEN 2 ELSE 1 END), FACTURA_FECHA, s.id_sucursal, c.id_cliente
	FROM gd_esquema.Maestra m
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Sucursal s
	on s.sucursal_dir = m.SUCURSAL_DIR
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Cliente c
	on c.cliente_dni = m.CLIENTE_DNI
	where m.cliente_dni IS NOT NULL AND m.sucursal_dir IS NOT NULL
GO


INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Factura (factura_fecha,factura_nro,id_venta) --FUNCIONA
	SELECT DISTINCT FACTURA_FECHA,FACTURA_NRO, v.id_venta
	FROM gd_esquema.Maestra
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta v
	on FACTURA_NRO = v.venta_numero
	where FACTURA_NRO IS NOT NULL 
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta_Pasaje (id_venta,id_pasaje) --FUNCIONA
	SELECT DISTINCT  v.id_venta, p.id_pasaje
	FROM gd_esquema.Maestra m
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta v
	on v.venta_numero = m.FACTURA_NRO 
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Pasaje p
	on p.pasaje_codigo = m.PASAJE_CODIGO
	where m.FACTURA_NRO IS NOT NULL AND m.PASAJE_CODIGO IS NOT NULL
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra (compra_numero,compra_fecha,id_tipo_operacion,id_aerolinea,id_hotel) --FUNCIONA pero poruqe cambie a nulleables id_aerolinea y id_hotel
	SELECT DISTINCT COMPRA_NUMERO, COMPRA_FECHA, (CASE WHEN m.HOTEL_CALLE = NULL THEN 2 ELSE 1 END), a.id_aerolinea, h.id_hotel
	FROM gd_esquema.Maestra m
	left join [SELECT_BEST_TEAM_FROM_CUARENTENA].Aerolinea a
	on a.aerolinea_razon_social = m.EMPRESA_RAZON_SOCIAL AND m.HOTEL_CALLE IS NULL 
	left join [SELECT_BEST_TEAM_FROM_CUARENTENA].Hotel h
	on h.hotel_razon_social = m.EMPRESA_RAZON_SOCIAL AND m.HOTEL_CALLE IS NOT NULL	
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra_Pasaje (id_compra,id_pasaje) --FUNCIONA
	SELECT DISTINCT c.id_compra, p.id_pasaje 
	FROM gd_esquema.Maestra m
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra c
	on c.compra_numero = m.COMPRA_NUMERO 
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Pasaje p
	on p.pasaje_codigo = m.PASAJE_CODIGO
	where m.PASAJE_CODIGO IS NOT NULL
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra_Estadias (id_compra,id_estadia) --FUNCIONA 
	SELECT DISTINCT c.id_compra, e.id_estadia 
	FROM gd_esquema.Maestra m
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra c
	on c.compra_numero = m.COMPRA_NUMERO 
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Estadia e
	on e.estadia_codigo = m.ESTADIA_CODIGO
	where m.ESTADIA_CODIGO IS NOT NULL
GO

INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta_Habitacion (id_venta,id_habitacion) --FUNCIONA
	SELECT  v.id_venta, h.id_habitacion
	FROM gd_esquema.Maestra m
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta v
	on v.venta_numero = m.FACTURA_NRO 
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Habitacion h
	on h.habitacion_numero = m.HABITACION_NUMERO 
	join [SELECT_BEST_TEAM_FROM_CUARENTENA].Hotel hot
	on hot.id_hotel = h.id_hotel  
	where m.FACTURA_NRO IS NOT NULL AND m.HOTEL_CALLE IS NOT NULL
GO
