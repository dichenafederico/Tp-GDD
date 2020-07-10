USE [GD1C2020]
GO


-------------------------------------------------------------------------------------------------
-----------------------------------DROP DE TABLES------------------------------------------------
-------------------------------------------------------------------------------------------------


IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Pasajes', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Pasajes];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Estadias', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Estadias];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tipo_Habitaciones', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Tipo_Habitaciones];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Habitaciones', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Habitaciones];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Butacas', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Butacas];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Aviones', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Aviones];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Rutas', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Rutas];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Ciudades', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Ciudades];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Clientes', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Clientes];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Tiempo];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Proveedores', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Proveedores];



-------------------------------------------------------------------------------------------------
-----------------------------------CREACIÓN DE TABLAS--------------------------------------------
-------------------------------------------------------------------------------------------------

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Proveedores(
	cod_proveedor integer IDENTITY PRIMARY KEY,
	proveedor_razon_social nvarchar(255) NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo(
	cod_tiempo integer IDENTITY PRIMARY KEY,
	cod_mes integer NOT NULL,
	cod_anio integer NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Clientes(
	cod_cliente integer IDENTITY PRIMARY KEY,
	cliente_apellido nvarchar(255) NOT NULL,
	cliente_nombre nvarchar(255) NOT NULL,
	cliente_dni numeric(18, 0) NOT NULL,
	cliente_fecha_nac datetime NOT NULL,
	cliente_mail nvarchar(255) NOT NULL,
	cliente_telefono integer NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Ciudades(
	cod_ciudad integer IDENTITY PRIMARY KEY,
	ciudad_nombre nvarchar(255) NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Rutas(
	cod_ruta integer IDENTITY PRIMARY KEY,
	ruta_aerea_codigo numeric(18, 0) NOT NULL,	
	ruta_aerea_ciu_orig integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Ciudades(cod_ciudad),
	ruta_aerea_ciu_dest integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Ciudades(cod_ciudad)
	)
GO

/*
CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Aerolineas(
	cod_aerolinea integer IDENTITY PRIMARY KEY,
	aerolinea_razon_social nvarchar(255) NOT NULL
	)
GO
*/

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Aviones(
	cod_avion integer IDENTITY PRIMARY KEY,
	avion_modelo nvarchar(50) NOT NULL,
	avion_identificador nvarchar(50) NOT NULL,
	id_proveedor integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_proveedores(cod_proveedor)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Butacas(
	cod_butaca integer IDENTITY PRIMARY KEY,
	butaca_tipo nvarchar(255) NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Habitaciones(
	cod_habitacion integer IDENTITY PRIMARY KEY,
	habitacion_numero numeric(18, 0) NOT NULL,
	habitacion_piso numeric(18, 0) NOT NULL,
	habitacion_frente nvarchar(50) NOT NULL,
	habitacion_costo  numeric(18, 2) NOT NULL,
	habitacion_precio  numeric(18, 2) NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tipo_Habitaciones(
	cod_tipo_habitacion integer IDENTITY PRIMARY KEY,
	tipo_habitacion_codigo numeric(18, 0) NOT NULL,
	tipo_habitacion_desc nvarchar(50) NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Estadias(
	cod_tiempo integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo(cod_tiempo),
	cod_proveedor integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Proveedores(cod_proveedor),
	cod_cliente integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Clientes(cod_cliente),
	cod_habitacion integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Habitaciones(cod_habitacion),
	tipo_operacion integer NOT NULL,
	cantidad integer NOT NULL,
	costo_total numeric(18,2) NOT NULL,
	ganancia_total numeric(18,2) NOT NULL,
	cantidad_camas integer NOT NULL,
	PRIMARY KEY (cod_tiempo,cod_proveedor,cod_cliente,cod_habitacion)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Pasajes(
	cod_tiempo integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo(cod_tiempo),
	cod_proveedor integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Proveedores(cod_proveedor),
	cod_cliente integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Clientes(cod_cliente),
	cod_ruta integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Rutas(cod_ruta),
	cod_butaca integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Butacas(cod_butaca),
	cod_avion integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Habitaciones(cod_habitacion),
	tipo_operacion integer NOT NULL,
	cantidad integer NOT NULL,
	costo_total numeric(18,2) NOT NULL,
	ganancia_total numeric(18,2) NOT NULL,
	PRIMARY KEY (cod_tiempo,cod_proveedor,cod_cliente,cod_ruta,cod_butaca,cod_avion)
	)
GO


--------------------------------------------------------------
-------------------Migración de los datos---------------------
--------------------------------------------------------------

--BI_Proveedores
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Proveedores(proveedor_razon_social)
	SELECT DISTINCT hotel_razon_social as proveedor_razon_social
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Hotel
	WHERE hotel_razon_social IS NOT NULL
	UNION
	SELECT DISTINCT aerolinea_razon_social as proveedor_razon_social
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Aerolinea
	WHERE aerolinea_razon_social IS NOT NULL
GO	



--BI_Tiempo



--BI_Clientes
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Clientes(cliente_apellido,cliente_nombre,cliente_dni,cliente_fecha_nac,cliente_mail,cliente_telefono)
	SELECT DISTINCT cliente_apellido,cliente_nombre,cliente_dni,cliente_fecha_nac,cliente_mail,cliente_telefono
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Cliente
	WHERE cliente_dni IS NOT NULL
GO

--BI_Ciudades
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Ciudades(ciudad_nombre)
	SELECT DISTINCT ciudad_nombre 
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Ciudad 
	WHERE ciudad_nombre IS NOT NULL
GO


--BI_Rutas
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Rutas(ruta_aerea_codigo,ruta_aerea_ciu_orig,ruta_aerea_ciu_dest)
	SELECT DISTINCT ruta_aerea_codigo, ruta_aerea_ciu_orig, ruta_aerea_ciu_dest
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Ruta_Aerea
	WHERE RUTA_AEREA_CODIGO IS NOT NULL
GO


--BI_Aviones  --FALTA TERMINAR EL TERCER CAMPO
/*
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Aviones (avion_modelo,avion_identificador,id_aerolinea)
	SELECT DISTINCT avion_modelo,avion_identificador,
		(SELECT cod_proveedor FROM SELECT_BEST_TEAM_FROM_CUARENTENA.BI_Proveedores)
	FROM gd_esquema.Maestra m
	WHERE AVION_MODELO IS NOT NULL AND AVION_IDENTIFICADOR IS NOT NULL
GO
*/


--BI_Butacas
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Butacas (butaca_tipo)
	SELECT DISTINCT butaca_tipo
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Butaca
	WHERE butaca_tipo IS NOT NULL
GO



--BI_Habitaciones
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Habitaciones (habitacion_numero,habitacion_piso,habitacion_frente,habitacion_costo,habitacion_precio)
	SELECT DISTINCT habitacion_numero,habitacion_piso,habitacion_frente,habitacion_costo,habitacion_precio
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Habitacion
	where habitacion_numero IS NOT NULL
GO



--BI_Tipo_Habitaciones
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tipo_Habitaciones (tipo_habitacion_codigo,tipo_habitacion_desc)
	SELECT DISTINCT tipo_habitacion_codigo,tipo_habitacion_desc
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Tipo_Habitacion
	WHERE tipo_habitacion_codigo IS NOT NULL
GO


--BI_Estadias


--BI_Pasajes


