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
	cod_cliente integer not null FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Cliente(id_cliente),
	cliente_apellido nvarchar(255) NOT NULL,
	cliente_nombre nvarchar(255) NOT NULL,
	cliente_dni numeric(18, 0) NOT NULL,
	cliente_fecha_nac datetime NOT NULL,
	cliente_mail nvarchar(255) NOT NULL,
	cliente_telefono integer NOT NULL,
	Primary key(cod_cliente)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Ciudades(
	cod_ciudad integer not null FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Ciudad(id_ciudad),
	ciudad_nombre nvarchar(255) NOT NULL,
	Primary key(cod_ciudad)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Rutas(
	cod_ruta integer not null FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Ruta_Aerea(id_ruta_aerea),
	ruta_aerea_codigo numeric(18, 0) NOT NULL,	
	ruta_aerea_ciu_orig integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Ciudades(cod_ciudad),
	ruta_aerea_ciu_dest integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Ciudades(cod_ciudad),
	Primary key(cod_ruta)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Aviones(
	cod_avion integer not null FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Avion(id_avion),
	avion_modelo nvarchar(50) NOT NULL,
	avion_identificador nvarchar(50) NOT NULL,
	id_proveedor integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_proveedores(cod_proveedor),
	Primary key(cod_avion)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Butacas(
	cod_butaca integer not null FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca(id_butaca),
	butaca_tipo nvarchar(255) NOT NULL,
	Primary key(cod_butaca)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Habitaciones(
	cod_habitacion integer not null FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Habitacion(id_habitacion),
	habitacion_numero numeric(18, 0) NOT NULL,
	habitacion_piso numeric(18, 0) NOT NULL,
	habitacion_frente nvarchar(50) NOT NULL,
	habitacion_costo  numeric(18, 2) NOT NULL,
	habitacion_precio  numeric(18, 2) NOT NULL
	Primary key(cod_habitacion)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tipo_Habitaciones(
	cod_tipo_habitacion integer not null FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Habitacion(id_tipo_habitacion),
	tipo_habitacion_codigo numeric(18, 0) NOT NULL,
	tipo_habitacion_desc nvarchar(50) NOT NULL
	Primary key(cod_tipo_habitacion)
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Estadias(
	cod_BI_estadia integer IDENTITY PRIMARY KEY,
    cod_estadia integer NOT NULL,
	cod_tiempo_compra integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo(cod_tiempo),
	cod_tiempo_venta integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo(cod_tiempo),
	cod_tiempo_estadia integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo(cod_tiempo),
	cod_proveedor integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Proveedores(cod_proveedor),
	cod_cliente integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Clientes(cod_cliente),
	cod_habitacion integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Habitaciones(cod_habitacion),
	cod_tipo_habitacion integer NOT NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tipo_Habitaciones(cod_tipo_habitacion),
	tipo_operacion integer NOT NULL,
	cantidad_noches integer NOT NULL,
	costo_total numeric(18,2) NOT NULL,
	ganancia_total numeric(18,2) NOT NULL,
	cantidad_camas integer NOT NULL,
	estadia_vendida bit NULL
	)
GO

CREATE TABLE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Pasajes(
	cod_BI_pasaje integer IDENTITY PRIMARY KEY,
	cod_pasaje integer NOT NULL,
	cod_tiempo_compra integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo(cod_tiempo),
	cod_tiempo_venta integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo(cod_tiempo),
	cod_tiempo_pasaje integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo(cod_tiempo),
	cod_proveedor integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Proveedores(cod_proveedor),
	cod_cliente integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Clientes(cod_cliente),
	cod_ruta integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Rutas(cod_ruta),
	cod_butaca integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Butacas(cod_butaca),
	cod_avion integer NULL FOREIGN KEY REFERENCES [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Habitaciones(cod_habitacion),
	tipo_operacion integer NOT NULL,
	cantidad_pasajes integer NOT NULL,
	costo_total numeric(18,2) NOT NULL,
	ganancia_total numeric(18,2) NOT NULL,
	pasaje_vendido bit NULL
	)
GO

--------------------------------------------------------------
-----------FUNCIÓN PARA OBTENER CANTIDAD DE CAMAS-------------
--------------------------------------------------------------

CREATE FUNCTION fx_obtenerCantidadDeCamas (@tipo_habitacion int)
RETURNS INT
AS
BEGIN 
	declare @retorno int
	SELECT @retorno = CASE WHEN t.tipo_habitacion_desc like 'Base Simple' OR t.tipo_habitacion_desc like 'King'  THEN 1 
	WHEN t.tipo_habitacion_desc like 'Base Doble' THEN 2
	WHEN t.tipo_habitacion_desc like 'Base Triple' THEN 3 
	WHEN  t.tipo_habitacion_desc like 'Base Cuadruple' THEN 4 END
	FROM [SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Habitacion t
	WHERE t.id_tipo_habitacion = @tipo_habitacion
	RETURN @retorno
END
GO


--------------------------------------------------------------
-------------------MIGRACIÓN DE DATOS-------------------------
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
GO
CREATE PROCEDURE seteoDeFechas	
AS
BEGIN
DECLARE @fecha_minima_anio integer
SET @fecha_minima_anio = 2017
DECLARE @fecha_minima_mes integer
SET @fecha_minima_mes = 12
DECLARE @fecha_maxima_anio integer
SET @fecha_maxima_anio = 2018
DECLARE @fecha_maxima_mes integer
SET @fecha_maxima_mes = 7


DECLARE @mes INT = @fecha_minima_mes;
DECLARE @anio INT = @fecha_minima_anio;


	WHILE (1=1)	
	BEGIN
		IF((@anio = @fecha_maxima_anio) AND (@mes = @fecha_maxima_mes))
			BEGIN
				INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo(cod_mes, cod_anio)	VALUES (@mes, @anio)
				BREAK
			END
		ELSE
			BEGIN
				INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo(cod_mes, cod_anio)	VALUES (@mes, @anio)
				SET @mes = @mes + 1
				IF(@mes > 12)
					BEGIN
						SET @anio = @anio + 1
						SET @mes  = 1
					END
			END
	END;
END
GO

EXECUTE seteoDeFechas


--BI_Clientes
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Clientes(cod_cliente, cliente_apellido,cliente_nombre,cliente_dni,cliente_fecha_nac,cliente_mail,cliente_telefono)
	SELECT DISTINCT id_cliente, cliente_apellido,cliente_nombre,cliente_dni,cliente_fecha_nac,cliente_mail,cliente_telefono
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Cliente
	WHERE cliente_dni IS NOT NULL
GO

--BI_Ciudades
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Ciudades(cod_ciudad,ciudad_nombre)
	SELECT DISTINCT id_ciudad, ciudad_nombre 
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Ciudad 
	WHERE ciudad_nombre IS NOT NULL
GO


--BI_Rutas
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Rutas(cod_ruta,ruta_aerea_codigo,ruta_aerea_ciu_orig,ruta_aerea_ciu_dest)
	SELECT DISTINCT id_ruta_aerea,ruta_aerea_codigo, ruta_aerea_ciu_orig, ruta_aerea_ciu_dest
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Ruta_Aerea
	WHERE RUTA_AEREA_CODIGO IS NOT NULL
GO


--BI_Aviones
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Aviones (cod_avion,avion_modelo,avion_identificador,id_proveedor)
	SELECT DISTINCT id_avion,av.avion_modelo,av.avion_identificador,
		(SELECT cod_proveedor FROM SELECT_BEST_TEAM_FROM_CUARENTENA.BI_Proveedores p WHERE p.proveedor_razon_social = ae.aerolinea_razon_social)
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Avion av
	JOIN SELECT_BEST_TEAM_FROM_CUARENTENA.Aerolinea ae ON av.id_aerolinea = ae.id_aerolinea
	WHERE AVION_MODELO IS NOT NULL AND AVION_IDENTIFICADOR IS NOT NULL
GO


--BI_Butacas
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Butacas (cod_butaca,butaca_tipo)
	SELECT DISTINCT id_butaca,butaca_tipo
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Butaca
	WHERE butaca_tipo IS NOT NULL
GO



--BI_Habitaciones
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Habitaciones (cod_habitacion,habitacion_numero,habitacion_piso,habitacion_frente,habitacion_costo,habitacion_precio)
	SELECT DISTINCT id_habitacion, habitacion_numero,habitacion_piso,habitacion_frente,habitacion_costo,habitacion_precio
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Habitacion
	where habitacion_numero IS NOT NULL
GO



--BI_Tipo_Habitaciones
INSERT INTO [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tipo_Habitaciones (cod_tipo_habitacion,tipo_habitacion_codigo,tipo_habitacion_desc)
	SELECT DISTINCT id_tipo_habitacion, tipo_habitacion_codigo,tipo_habitacion_desc
	FROM SELECT_BEST_TEAM_FROM_CUARENTENA.Tipo_Habitacion
	WHERE tipo_habitacion_codigo IS NOT NULL
GO

--BI_Estadias
 INSERT INTO  [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Estadias (cod_estadia,cod_tiempo_compra, cod_tiempo_venta, cod_tiempo_estadia ,cod_proveedor ,cod_cliente ,cod_habitacion ,cod_tipo_habitacion, tipo_operacion,cantidad_noches,costo_total ,ganancia_total ,cantidad_camas)
		SELECT DISTINCT eh.id_estadia, tCompra.cod_tiempo, null,  t.cod_tiempo , c.id_hotel, null, bih.cod_habitacion, h.id_tipo_habitacion, 1, e.estadia_cantidad_noches,
		 (h.habitacion_costo * e.estadia_cantidad_noches), 
		 (h.habitacion_precio * e.estadia_cantidad_noches - (h.habitacion_costo * e.estadia_cantidad_noches)),
		 dbo.fx_obtenerCantidadDeCamas(h.id_tipo_habitacion)		 
		FROM [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra c
		JOIN  [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra_Estadias ce
		on c.id_compra = ce.id_compra
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].Estadia e
		on ce.id_estadia = e.id_estadia
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].Estadia_Habitacion eh
		on e.id_estadia = eh.id_estadia
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].Habitacion h
		on eh.id_habitacion = h.id_habitacion
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Habitaciones bih
		on h.id_habitacion = bih.cod_habitacion
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].Tipo_Habitacion th
		on h.id_tipo_habitacion = th.id_tipo_habitacion
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo t
		on t.cod_anio = YEAR(e.estadia_fecha) AND t.cod_mes = MONTH(e.estadia_fecha)
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo tCompra
		on t.cod_anio = YEAR(c.compra_fecha) AND t.cod_mes = MONTH(c.compra_fecha)
		WHERE c.id_tipo_operacion = 1 AND c.id_hotel IS NOT NULL	

		
		--UPDATE PARA MARCAR LAS ESTADÍAS VENDIDAS
		UPDATE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Estadias 
		SET estadia_vendida = 1, cod_cliente = bic.cod_cliente, cod_tiempo_venta = t.cod_tiempo
		FROM [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta v
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta_Estadia ve
		on v.id_venta = ve.id_venta
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Estadias bie
		on ve.id_estadia = bie.cod_estadia
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo t
		on t.cod_anio = YEAR(v.venta_fecha) AND t.cod_mes = MONTH(v.venta_fecha)
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Clientes bic
		on bic.cod_cliente = v.id_cliente
		WHERE v.id_tipo_operacion = 1 AND bie.cod_estadia = ve.id_estadia


--BI_Pasajes
 INSERT INTO  [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Pasajes(cod_pasaje,cod_tiempo_compra, cod_tiempo_venta, cod_tiempo_pasaje ,cod_proveedor ,cod_cliente ,cod_ruta ,cod_butaca, cod_avion, tipo_operacion,cantidad_pasajes,costo_total ,ganancia_total)
		SELECT DISTINCT p.id_pasaje, tCompra.cod_tiempo, null,  t.cod_tiempo , c.id_aerolinea, null, r.id_ruta_aerea, b.id_butaca, a.id_avion,1,
		1, p.pasaje_costo, (p.pasaje_precio - p.pasaje_costo)
		FROM [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra c
		JOIN  [SELECT_BEST_TEAM_FROM_CUARENTENA].Compra_Pasaje cp
		on c.id_compra = cp.id_compra
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].Pasaje p
		on cp.id_pasaje = p.id_pasaje
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].Vuelo v
		on v.id_vuelo = p.id_vuelo
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].Ruta_Aerea r
		on v.id_ruta_aerea = r.id_ruta_aerea
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].Avion a
		on v.id_avion = a.id_avion
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].Butaca b
		on b.id_butaca = p.id_butaca
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo t
		on t.cod_anio = YEAR(p.pasaje_fecha_compra) AND t.cod_mes = MONTH(p.pasaje_fecha_compra)
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo tCompra
		on t.cod_anio = YEAR(c.compra_fecha) AND t.cod_mes = MONTH(c.compra_fecha)
		WHERE c.id_tipo_operacion = 2 AND c.id_aerolinea IS NOT NULL	
		
		
		--UPDATE PARA MARCAR LAS ESTADÍAS VENDIDAS
		UPDATE [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Pasajes 
		SET pasaje_vendido = 1, cod_cliente = bic.cod_cliente, cod_tiempo_venta = t.cod_tiempo
		FROM [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta v
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].Venta_Pasaje ve
		on v.id_venta = ve.id_venta
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Pasajes bip
		on ve.id_pasaje = bip.cod_pasaje
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Tiempo t
		on t.cod_anio = YEAR(v.venta_fecha) AND t.cod_mes = MONTH(v.venta_fecha)
		JOIN [SELECT_BEST_TEAM_FROM_CUARENTENA].BI_Clientes bic
		on bic.cod_cliente = v.id_cliente
		WHERE v.id_tipo_operacion = 2 AND bip.cod_pasaje = ve.id_pasaje
