USE [GD1C2020]
GO


-------------------------------------------------------------------------------------------------
-----------------------------------DROP DE TABLES------------------------------------------------
-------------------------------------------------------------------------------------------------


IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Proveedores', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Proveedores];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Tiempo];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Clientes', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Clientes];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Ciudades', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Ciudades];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Rutas', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Rutas];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Aerolineas', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Aerolineas];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Aviones', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Aviones];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Butacas', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Butacas];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Habitaciones', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Habitaciones];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Pasajes', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Pasajes];
IF OBJECT_ID('[SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Estadias', 'U') IS NOT NULL DROP TABLE SELECT_BEST_TEAM_FROM_CUARENTENA.[BI_Estadias];



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

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Aerolineas(
	cod_aerolinea integer IDENTITY PRIMARY KEY,
	aerolinea_razon_social nvarchar(255) NOT NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Aviones(
	cod_avion integer IDENTITY PRIMARY KEY,
	avion_modelo nvarchar(50) NOT NULL,
	avion_identificador nvarchar(50) NOT NULL,
	id_aerolinea integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Aerolineas(cod_aerolinea)
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
	habitacion_precio  numeric(18, 2) NOT NULL,
	tipo_habitacion_codigo numeric(18, 0) NOT NULL,
	tipo_habitacion_desc nvarchar(50)
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