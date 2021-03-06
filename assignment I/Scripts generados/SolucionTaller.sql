/* 
   Assignment 1
   Autores: Greisy Dariana Largo Pescador - Yesid Hern�ndez Hoyos
   Asignatura: Administraci�n de bases de datos
   Docente: Andr�s Mart�nez Gutierrez
*/

/*
 2. Create 3 Tablespaces (0.2) :
  a. first one with 1 Gb and 3 datafiles, tablespace should be named "gofar_travel"
  b. second one with 500 Mb and 1 datafile, named "test_purposes".
  c. Undo tablespace with 5Mb of space and 1 datafile
*/

-- a. first one with 1 Gb and 3 datafiles, tablespace should be named "gofar_travel"
CREATE TABLESPACE gofar_travel DATAFILE
'D:/app/us/virtual/oradata/orcl/gofar_travel01.dbf' size 350M, 
'D:/app/us/virtual/oradata/orcl/gofar_travel02.dbf' size 350M,
'D:/app/us/virtual/oradata/orcl/gofar_travel03.dbf' size 324M;

-- b. second one with 500 Mb and 1 datafile, named "test_purposes".
CREATE TABLESPACE test_purposes DATAFILE
'D:/app/us/virtual/oradata/orcl/test_purposes01.dbf' size 500M;

-- c. Undo tablespace with 5Mb of space and 1 datafile
CREATE UNDO TABLESPACE undo_tablespace DATAFILE
'D:/app/us/virtual/oradata/orcl/undo_tablespace01.dbf' size 5M; 

/* 3. Set the undo tablespace to be used in the system (0.2) */
ALTER SYSTEM SET UNDO_TABLESPACE = undo_tablespace;

/* 4. Create a DBA user and assign it to the tablespace called "gofar_travel", this user has unlimited space
on the tablespace (0.2) */

-- En mi caso, siempre debo ejecutar el siguiente comando para poder crear usuarios
alter session set "_ORACLE_SCRIPT"=true;

-- Ahora si procedo a crear el usuario solicitado
CREATE USER USUARIO_DBA IDENTIFIED BY USUARIO_DBA DEFAULT TABLESPACE gofar_travel
QUOTA UNLIMITED ON gofar_travel;

-- Convertir a USUARIO_DBA en DBA
GRANT DBA TO USUARIO_DBA;

/* 5. Assign the dba role and permissions to connect to the user just created (0.2) */

-- Con la soluci�n del punto 4, ya queda resuelta la necesidad expuesta en este punto (5). Por tal motivo no se realiza nada.

/* 6. Create 3 profiles. (0.2) */

-- a. Profile 1: "manager " password life 40 days, one session per user, 15 minutes idle, 4 failed login attempts
CREATE PROFILE MANAGER LIMIT
SESSIONS_PER_USER 1
IDLE_TIME 15
PASSWORD_LIFE_TIME 40
FAILED_LOGIN_ATTEMPTS 4;

-- b. Profile 2: "finance ", , 3 minutes idle, 2 failed login attempts
CREATE PROFILE FINANCE LIMIT
SESSIONS_PER_USER 1 
IDLE_TIME 3 
PASSWORD_LIFE_TIME 15  
FAILED_LOGIN_ATTEMPTS 2; 

-- c. Profile 3: "development " password life 100 days, two session per user, 30 minutes idle, no failed login attempts
CREATE PROFILE DEVELOPMENT LIMIT
SESSIONS_PER_USER 2
IDLE_TIME 30 
PASSWORD_LIFE_TIME 100
FAILED_LOGIN_ATTEMPTS UNLIMITED; 

/* 7. Create 4 users, assign them the tablespace "gofar_travel"; profiles created should be used for the
users, all the users should be allow to connect to the database. (0.2) */

CREATE USER USUARIO1 IDENTIFIED BY USUARIO1 DEFAULT TABLESPACE gofar_travel
PROFILE MANAGER;

-- Se asignan privilegios a USUARIO1 para que pueda conectarse a la base de datos
GRANT CONNECT TO USUARIO1;

CREATE USER USUARIO2 IDENTIFIED BY USUARIO2 DEFAULT TABLESPACE gofar_travel
PROFILE FINANCE;

-- Se asignan privilegios a USUARIO2 para que pueda conectarse a la base de datos
GRANT CONNECT TO USUARIO2;

CREATE USER USUARIO3 IDENTIFIED BY USUARIO3 DEFAULT TABLESPACE gofar_travel
PROFILE FINANCE;

-- Se asignan privilegios a USUARIO3 para que pueda conectarse a la base de datos
GRANT CONNECT TO USUARIO3;

CREATE USER USUARIO4 IDENTIFIED BY USUARIO4 DEFAULT TABLESPACE gofar_travel
PROFILE DEVELOPMENT;

-- Se asignan privilegios a USUARIO4 para que pueda conectarse a la base de datos
GRANT CONNECT TO USUARIO4;

/* 8. Lock the users associate with profiles: manager and finance . (0.2) */

ALTER USER USUARIO1 ACCOUNT LOCK;
ALTER USER USUARIO2 ACCOUNT LOCK;
ALTER USER USUARIO3 ACCOUNT LOCK;


/* 9. Delete the tablespace called "test_purposes " (0.2) */

DROP TABLESPACE test_purposes INCLUDING CONTENTS AND DATAFILES;

/* 
10. Create tables with its columns according to your normalization. Create sequences for every primary
    key. Create primary and foreign keys. Insert at least 50 vehicles, 20 customers, 20 invoices (Go to
    http://www.generatedata.com/). This should be a functional single script (.sql) (Better if you generate
    sql through sql developer) (1.0)
*/

-- Se crea la tabla "Clientes". 
CREATE TABLE Clientes (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, Cedula VARCHAR2(20), Nombres VARCHAR2(50), 
Apellidos VARCHAR2(50), Direccion VARCHAR2(255), Telefono VARCHAR2(30));

-- Se crea la tabla "Veh�culos". 
CREATE TABLE Vehiculos (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, Placa VARCHAR2(10), VIN VARCHAR2(100), Marca VARCHAR2(50), Modelo VARCHAR2(10), 
Numero_serie VARCHAR2(100), Nombre_Fabricante VARCHAR2(50), Costo_compra DECIMAL(10,2), Estado_Vehiculo VARCHAR2(10), Cantidad_reingresos int);

-- Se crea la tabla "Vendedores". 
CREATE TABLE Vendedores (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, Codigo_vendedor VARCHAR2(20), Cedula VARCHAR2(20), Nombres VARCHAR2(50), 
Apellidos VARCHAR2(50), Direccion VARCHAR2(255), Telefono VARCHAR2(30), Estado VARCHAR2(10));

-- Se crea la tabla "Productos Adicionales".
CREATE TABLE Productos_Adicionales (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, Codigo_Producto VARCHAR2(20), Descripcion VARCHAR2(255), 
Costo_Fabricante DECIMAL(8,2), Precio_actual DECIMAL(9,2), Cantidad_stock int);

-- Se crea la tabla "Facturas".
CREATE TABLE Facturas (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, id_cliente NUMBER NOT NULL, id_vehiculo NUMBER NOT NULL, id_vendedor NUMBER NOT NULL, 
Fecha_factura VARCHAR2(50), Derecho_licencia VARCHAR2(50), Impuesto_aplicable DECIMAL(2,2), id_vehiculo_intercambio NUMBER NULL, 
Descuento_vehiculo_intercambio DECIMAL(10,2), Monto_maximo_permitido DECIMAL(10,2), Total_venta DECIMAL(10,2)); 

-- Se hacen modificaciones a la tabla "Facturas" para crear las claves for�neas.
ALTER TABLE Facturas
ADD CONSTRAINT FK_ID_CLIENTE
FOREIGN KEY (id_cliente) REFERENCES CLIENTES (id);

ALTER TABLE Facturas
ADD CONSTRAINT FK_ID_VEHICULO
FOREIGN KEY (id_vehiculo) REFERENCES VEHICULOS (id); 

ALTER TABLE Facturas
ADD CONSTRAINT FK_ID_VENDEDOR
FOREIGN KEY (id_vendedor) REFERENCES VENDEDORES (id); 

ALTER TABLE Facturas
ADD CONSTRAINT FK_ID_VEHICULO_INTERCAMBIO
FOREIGN KEY (id_vehiculo_intercambio) REFERENCES VEHICULOS (id); 


-- Se crea la tabla "Factura_Detalle".
CREATE TABLE Factura_Detalle (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, id_factura NUMBER, id_producto_adicional NUMBER, 
Precio_venta DECIMAL(10,2), Cantidad_producto int);

-- Se hacen modificaciones a la tabla "Facturas" para crear las claves for�neas.
ALTER TABLE Factura_Detalle
ADD CONSTRAINT FK_ID_FACTURA
FOREIGN KEY (id_factura) REFERENCES FACTURAS (id);

ALTER TABLE Factura_Detalle
ADD CONSTRAINT FK_ID_PRODUCTO_ADICIONAL
FOREIGN KEY (id_producto_adicional) REFERENCES PRODUCTOS_ADICIONALES (id); 












