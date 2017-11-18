/*
  Autores: Greisy Dariana Largo Pescador - Yesid Hernández Hoyos.
  Fecha: Noviembre 18 de 2017.
  Taller: Assignment 2 (Views, Explain plan, Triggers, Functions, Procedures).
*/

-- Se rediseña el modelo de base de datos con las respectivas modificaciones que dan solución a los puntos 1 y 2 del taller

-- Se crea la tabla "Clientes". 
CREATE TABLE CLIENTES (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, Cedula VARCHAR2(20), Nombres VARCHAR2(255), 
Apellidos VARCHAR2(255), Direccion VARCHAR2(255), Telefono VARCHAR2(30));

-- Se crea la tabla "Vendedores". 
CREATE TABLE Vendedores (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, Codigo_vendedor VARCHAR2(20), Cedula VARCHAR2(20), Nombres VARCHAR2(255), 
Apellidos VARCHAR2(255), Direccion VARCHAR2(255), Telefono VARCHAR2(30), Estado VARCHAR2(10));

-- Se crea la tabla "Fabricantes"
CREATE TABLE FABRICANTES (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, Codigo_fabricante VARCHAR2(20), nombre_fabricante VARCHAR2(255), 
pais VARCHAR2(255), ciudad VARCHAR2(255), direccion VARCHAR2(255) , Telefono VARCHAR2(30), Estado VARCHAR2(10));

-- Se crea la tabla "Accesorios".
CREATE TABLE ACCESORIOS (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, Codigo_accesorio VARCHAR2(20), Descripcion VARCHAR2(255), id_fabricante NUMBER,
Valor_compra DECIMAL(10,2), Valor_venta DECIMAL(10,2), Unidades_Disponibles int);

-- Se crea la tabla "Vehículos". 
CREATE TABLE Vehiculos (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, Placa VARCHAR2(10), VIN VARCHAR2(255), Marca VARCHAR2(255), Modelo VARCHAR2(255), 
Numero_serie VARCHAR2(255), id_Fabricante NUMBER, Valor_compra DECIMAL(10,2));

-- Se crea la tabla "Histórico_Vehículos"
CREATE TABLE Historico_Vehiculos (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, id_vehiculo NUMBER, id_factura NUMBER NULL, Fecha_novedad DATE, 
Estado VARCHAR(255));

-- Se crea la tabla "Facturas".
CREATE TABLE Facturas (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, id_cliente NUMBER NOT NULL, id_vehiculo NUMBER NOT NULL, id_vendedor NUMBER NOT NULL, 
Fecha_factura DATE, Derecho_licencia VARCHAR2(255), Impuesto_aplicable DECIMAL(10,2), id_vehiculo_intercambio NUMBER NULL, 
Descuento_vehiculo_intercambio DECIMAL(10,2), Monto_maximo_permitido DECIMAL(10,2), Total_venta DECIMAL(10,2)); 

-- Se crea la tabla "Factura_Detalle".
CREATE TABLE Factura_Detalle (id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, id_factura NUMBER, id_accesorio NUMBER, 
Valor_venta DECIMAL(10,2), Cantidad_producto int);


-- Se crean las relaciones entre las tablas.
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

ALTER TABLE Factura_Detalle
ADD CONSTRAINT FK_ID_FACTURA
FOREIGN KEY (id_factura) REFERENCES FACTURAS (id);

ALTER TABLE Factura_Detalle
ADD CONSTRAINT FK_ID_ACCESORIO
FOREIGN KEY (id_accesorio) REFERENCES ACCESORIOS (id); 

ALTER TABLE Historico_Vehiculos
ADD CONSTRAINT FK_ID_HISTORICO_FACTURA
FOREIGN KEY (id_factura) REFERENCES FACTURAS (id);

ALTER TABLE Historico_Vehiculos
ADD CONSTRAINT FK_ID_HISTORICO_VEHICULO
FOREIGN KEY (id_vehiculo) REFERENCES VEHICULOS (id);

ALTER TABLE Vehiculos
ADD CONSTRAINT FK_ID_VEHICULO_FABRICANTE
FOREIGN KEY (id_fabricante) REFERENCES FABRICANTES (id);

ALTER TABLE Accesorios
ADD CONSTRAINT FK_ID_ACCESORIO_FABRICANTE
FOREIGN KEY (id_fabricante) REFERENCES FABRICANTES (id);

-- Agregamos el constraint para que el estado de la tabla "Historico_Vehiculos" sólo acepte los valores "NEW", "TRADE", "SOLD".
ALTER TABLE Historico_Vehiculos
ADD CONSTRAINT RESTRICCION_ESTADO
CHECK (ESTADO IN ('NEW', 'TRADE', 'SOLD'));

-- Colocamos como 30 el valor por defecto en la columna "Unidades_Disponibles" de la tabla "ACCESORIOS".
ALTER TABLE ACCESORIOS MODIFY
Unidades_Disponibles INT
DEFAULT 30;

/* PROCEDEMOS A INSERTAR INFORMACIÓN EN LAS TABLAS */

-- Tabla Accesorios
INSERT INTO ACCESORIOS (Codigo_accesorio,Descripcion,id_fabricante,Valor_compra,Valor_venta,Unidades_Disponibles) VALUES ('0021749018','microondas',4,977107,879043,16);
INSERT INTO ACCESORIOS (Codigo_accesorio,Descripcion,id_fabricante,Valor_compra,Valor_venta,Unidades_Disponibles) VALUES ('3820567430','nevera',2,171005,1423175,14);
INSERT INTO ACCESORIOS (Codigo_accesorio,Descripcion,id_fabricante,Valor_compra,Valor_venta,Unidades_Disponibles) VALUES ('2596250435','Estufa',3,410095,1218109,3);
INSERT INTO ACCESORIOS (Codigo_accesorio,Descripcion,id_fabricante,Valor_compra,Valor_venta,Unidades_Disponibles) VALUES ('4418002701','silla express',10,791487,1271413,7);
INSERT INTO ACCESORIOS (Codigo_accesorio,Descripcion,id_fabricante,Valor_compra,Valor_venta,Unidades_Disponibles) VALUES ('1616348286','iluminación especial',3,328609,941507,14);
INSERT INTO ACCESORIOS (Codigo_accesorio,Descripcion,id_fabricante,Valor_compra,Valor_venta,Unidades_Disponibles) VALUES ('0578745731','Extinguidor de fuego',1,711750,1440937,18);
INSERT INTO ACCESORIOS (Codigo_accesorio,Descripcion,id_fabricante,Valor_compra,Valor_venta,Unidades_Disponibles) VALUES ('6578554867','tapete',10,164895,1346685,17);
INSERT INTO ACCESORIOS (Codigo_accesorio,Descripcion,id_fabricante,Valor_compra,Valor_venta,Unidades_Disponibles) VALUES ('8314860739','lampara de lava',1,254897,848338,18);
INSERT INTO ACCESORIOS (Codigo_accesorio,Descripcion,id_fabricante,Valor_compra,Valor_venta,Unidades_Disponibles) VALUES ('8672551303','manguera',7,510857,948757,12);
INSERT INTO ACCESORIOS (Codigo_accesorio,Descripcion,id_fabricante,Valor_compra,Valor_venta,Unidades_Disponibles) VALUES ('9099269006','cortina',6,354324,1216984,11);
Insert into ACCESORIOS (CODIGO_ACCESORIO,DESCRIPCION,ID_FABRICANTE,VALOR_COMPRA,VALOR_VENTA,UNIDADES_DISPONIBLES) values ('1234567890','Equipo de sonido',5,120000,140000,30);
Insert into ACCESORIOS (CODIGO_ACCESORIO,DESCRIPCION,ID_FABRICANTE,VALOR_COMPRA,VALOR_VENTA,UNIDADES_DISPONIBLES) values ('9099269254','Luces led',6,354324,121698,21);

SELECT * FROM ACCESORIOS;

-- Tabla Clientes
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('9175176311','Callum','Sweeney','4611 Mauris St.','4783758');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('8543548510','Morgan','Hess','P.O. Box 331, 4938 Ipsum. Av.','6114712');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('9097644537','Clayton','Gentry','Ap #944-7795 Ligula. Street','4144842');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('6946486072','Farrah','Blackwell','431-884 Diam Rd.','7298123');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('4730193821','Kenneth','Harrington','441-7281 Quisque Street','6132786');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('7776921459','Fitzgerald','Orr','602-4740 Elementum St.','7108377');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('4255570925','Finn','Knox','Ap #633-9273 Eleifend Rd.','0538498');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('7926207235','Joshua','Ryan','P.O. Box 569, 6081 Fringilla Rd.','9279314');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('8462398752','Jermaine','Flowers','2572 Suspendisse St.','4825145');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('6344333990','Imelda','Zamora','174-6666 Ultricies Street','8973802');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('4863102706','Dorothy','Soto','Ap #342-1633 Elementum St.','2502431');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('0137447857','Camden','Thompson','9694 Feugiat Av.','5886845');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('6805304230','Iliana','Schultz','569-628 Nec Rd.','0741348');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('3964415502','Ann','Hawkins','Ap #754-8392 Quam. Rd.','8289524');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('5690110698','Kiayada','Rosario','Ap #367-6277 Justo St.','7435314');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('9965098439','Zelda','Rush','901-2745 In Av.','0610090');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('6293169578','Camilla','Simon','Ap #710-2518 Quis Ave','5960588');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('2452862271','Aurora','Mcfarland','P.O. Box 702, 7214 Consequat Rd.','1488310');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('8090087931','Basil','Nolan','Ap #452-9606 Vel Avenue','6200532');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('3992223124','Alfreda','Baldwin','950-2678 Fermentum Av.','5251905');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('7052506840','Acton','Cameron','444-9935 Malesuada Rd.','3362293');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('0087015112','Mason','Chen','P.O. Box 778, 1457 Ultricies Road','9565949');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('6907796467','Armando','Fuller','Ap #324-1889 Consequat Rd.','8118514');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('0001433676','Hedley','Wong','P.O. Box 800, 3613 Sodales Rd.','5330285');
INSERT INTO Clientes (Cedula,Nombres,Apellidos,Direccion,Telefono) VALUES ('4542439753','Norman','Kinney','Ap #201-571 Scelerisque Ave','8100230');

SELECT * FROM CLIENTES;

-- Tabla vendedores
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('9440213244','2279326415','Kenneth','Boyle','2127 Fames Rd.','8025159','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('9825248780','7254130512','Haviva','Rowland','632-9701 Eu Road','6787966','Inactivo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('1163337619','1780271768','Cheyenne','Kirk','Ap #988-4579 Non, Ave','3436691','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('6377045810','6118390138','Christian','Padilla','P.O. Box 869, 6224 Sapien. St.','8068996','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('2769360523','5010173562','Quinn','Hoffman','379-5939 Scelerisque Ave','2340196','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('9279451893','7105549535','Abel','Dominguez','Ap #407-4002 Cursus. Ave','2558843','Inactivo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('3116154252','0822260699','Nadine','Newton','Ap #372-9153 Tellus. Rd.','6714193','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('0280889603','2624482939','Logan','Atkinson','P.O. Box 189, 3297 Lorem, St.','1973690','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('3090860033','0609620914','Amena','Trujillo','Ap #792-8174 Vel Av.','8649015','Inactivo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('4832688413','7793821799','Remedios','Burch','Ap #845-3244 Quam. Rd.','5208228','Inactivo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('1488713391','3260323896','Lars','Nieves','Ap #676-4983 Suspendisse Avenue','1836378','Inactivo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('3132517950','8284016281','Graham','Levine','Ap #922-5213 Est. Avenue','3804481','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('2170740368','6703268669','Joan','Roth','P.O. Box 993, 1342 Lacus. Street','3329867','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('3168425240','0615346695','Cole','Hyde','5382 Enim Street','6095159','Inactivo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('5175044866','7833298230','Aubrey','Decker','695 A, Street','2898015','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('2799766971','2548471942','Henry','Carrillo','Ap #518-855 Erat. Street','0672062','Inactivo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('5761743258','0229311036','Rudyard','Mcmillan','941-171 Metus Avenue','0327110','Inactivo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('9876100292','4481085131','Shaine','Green','3889 Lorem Avenue','2185440','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('1035574041','7244116396','Melissa','Cabrera','441-8356 Pede, Av.','7188835','Inactivo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('9510175767','6958616098','Lilah','Johnston','523-8254 Mattis. Street','8138119','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('9164100294','6851022002','Upton','Acevedo','P.O. Box 339, 5356 Rutrum Rd.','1297611','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('5240455372','1480856223','Holmes','Jennings','455-6460 Aliquam St.','8448929','Inactivo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('2132128667','5169067468','Lawrence','Morin','2364 Donec Ave','2818183','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('9783783336','8593410334','Jordan','Murphy','8190 Suscipit, Rd.','1013464','Activo');
INSERT INTO Vendedores (Codigo_vendedor,Cedula,Nombres,Apellidos,Direccion,Telefono,Estado) VALUES ('5304107948','3923056609','Price','Warner','668-6020 Erat Rd.','3139715','Activo');

select * from vendedores;

-- Tabla fabricantes
INSERT INTO Fabricantes (Codigo_fabricante,nombre_fabricante,pais,ciudad,direccion,Telefono,Estado) VALUES ('8104408306','Aliquam Inc.','Afghanistan','Kujawsko-pomorskie','1849 Lorem Rd.','1663113056499','Activo');
INSERT INTO Fabricantes (Codigo_fabricante,nombre_fabricante,pais,ciudad,direccion,Telefono,Estado) VALUES ('0157871813','Euismod Enim Incorporated','Congo (Brazzaville)','E','Ap #533-3972 Elementum Rd.','1635100281799','Activo');
INSERT INTO Fabricantes (Codigo_fabricante,nombre_fabricante,pais,ciudad,direccion,Telefono,Estado) VALUES ('8068388481','Aliquam Associates','French Guiana','A','8888 Aliquam Avenue','1605042493499','Inactivo');
INSERT INTO Fabricantes (Codigo_fabricante,nombre_fabricante,pais,ciudad,direccion,Telefono,Estado) VALUES ('2622287814','Curae; Foundation','Lesotho','Ceará','632-9035 Amet, Rd.','1618011970299','Inactivo');
INSERT INTO Fabricantes (Codigo_fabricante,nombre_fabricante,pais,ciudad,direccion,Telefono,Estado) VALUES ('0508325826','Diam Ltd','Croatia','Uttar Pradesh','P.O. Box 733, 6730 Cras Ave','1623062445599','Activo');
INSERT INTO Fabricantes (Codigo_fabricante,nombre_fabricante,pais,ciudad,direccion,Telefono,Estado) VALUES ('3960608837','Cras Vulputate Velit Industries','Burundi','WP','Ap #624-2197 Interdum. Road','1666090250899','Activo');
INSERT INTO Fabricantes (Codigo_fabricante,nombre_fabricante,pais,ciudad,direccion,Telefono,Estado) VALUES ('4599438749','Est Industries','Côte D''Ivoire (Ivory Coast)','GJ','Ap #284-8886 Hymenaeos. Rd.','1657042278599','Inactivo');
INSERT INTO Fabricantes (Codigo_fabricante,nombre_fabricante,pais,ciudad,direccion,Telefono,Estado) VALUES ('3908355350','Libero Lacus Industries','French Polynesia','Anambra','Ap #485-7687 Molestie Street','1622011122899','Inactivo');
INSERT INTO Fabricantes (Codigo_fabricante,nombre_fabricante,pais,ciudad,direccion,Telefono,Estado) VALUES ('2589936323','Ac Risus Morbi PC','Palestine, State of','ON','Ap #694-1216 Cras Ave','1687060151599','Activo');
INSERT INTO Fabricantes (Codigo_fabricante,nombre_fabricante,pais,ciudad,direccion,Telefono,Estado) VALUES ('5105954982','Non Feugiat Nec Company','Saint Vincent and The Grenadines','BA','930-449 Mollis Road','1693050364999','Activo');

SELECT * FROM FABRICANTES;

-- Tabla Vehículos
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('Zkb472','9160712088','TOYOTA','2199','2837526525',6,4772825);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('pmH511','5782006523','MERCEDES','5361','7531363411',10,8875414);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('qVW007','0530912097','BMW','4974','2065105751',3,4242389);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('WJw533','4640648799','RENAULT','9926','4447889137',6,2938333);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('xSw310','3144168369','CHEVROLET','9674','2179988567',3,3105923);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('ThP521','9055924408','JAGUAR','2853','2002613838',2,6628478);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('BMN716','6027106128','GATO','2757','1727348851',2,3630672);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('rtG216','3962186452','TOYOTA','7781','7713987775',3,7693093);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('nwh482','6172654187','MERCEDES','8648','1586373255',3,6001130);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('pNx604','6097030610','BMW','1157','3179028690',3,7348350);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('YNg616','2137791663','RENAULT','2394','8572555470',7,1658188);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('nfz663','5550025669','CHEVROLET','1671','5308931908',3,6273195);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('rTL153','5699325836','JAGUAR','3848','8587660501',1,7067350);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('hnQ831','4558261832','GATO','3553','0390956093',7,2045481);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('GHD367','0323130345','TOYOTA','7134','6861850846',1,3524430);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('bPv411','2317009669','MERCEDES','2539','6423629963',8,3207826);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('Kbn864','8713255226','BMW','4486','6718293819',10,8910475);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('LHd527','3697519671','RENAULT','2625','6963507324',3,7349117);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('HHS718','8124108540','CHEVROLET','7833','2765593802',3,5457980);
INSERT INTO VEHICULOS (Placa,VIN,Marca,Modelo,Numero_serie,id_Fabricante,Valor_compra) VALUES ('TzH401','5885391580','JAGUAR','4368','1244701313',10,3392052);

SELECT * FROM VEHICULOS;

-- Tabla Facturas
INSERT INTO Facturas (id_cliente,id_vehiculo,id_vendedor,Fecha_factura,Derecho_licencia,Impuesto_aplicable,id_vehiculo_intercambio,Descuento_vehiculo_intercambio,Monto_maximo_permitido,Total_venta) VALUES (11,3,19,'15/12/2017','5240636961',7,null,293443,5654159,1690026);
INSERT INTO Facturas (id_cliente,id_vehiculo,id_vendedor,Fecha_factura,Derecho_licencia,Impuesto_aplicable,id_vehiculo_intercambio,Descuento_vehiculo_intercambio,Monto_maximo_permitido,Total_venta) VALUES (17,5,8,'27/01/2017','6525891197',7,3,703331,5019037,1734833);
INSERT INTO Facturas (id_cliente,id_vehiculo,id_vendedor,Fecha_factura,Derecho_licencia,Impuesto_aplicable,id_vehiculo_intercambio,Descuento_vehiculo_intercambio,Monto_maximo_permitido,Total_venta) VALUES (10,13,8,'07/02/2018','6039530217',7,19,962323,5533053,924651);
INSERT INTO Facturas (id_cliente,id_vehiculo,id_vendedor,Fecha_factura,Derecho_licencia,Impuesto_aplicable,id_vehiculo_intercambio,Descuento_vehiculo_intercambio,Monto_maximo_permitido,Total_venta) VALUES (7,5,7,'20/04/2017','5343818675',7,8,651910,5495319,1726488);
INSERT INTO Facturas (id_cliente,id_vehiculo,id_vendedor,Fecha_factura,Derecho_licencia,Impuesto_aplicable,id_vehiculo_intercambio,Descuento_vehiculo_intercambio,Monto_maximo_permitido,Total_venta) VALUES (12,18,7,'22/04/2017','1667937123',7,14,121284,5853683,1751433);
INSERT INTO Facturas (id_cliente,id_vehiculo,id_vendedor,Fecha_factura,Derecho_licencia,Impuesto_aplicable,id_vehiculo_intercambio,Descuento_vehiculo_intercambio,Monto_maximo_permitido,Total_venta) VALUES (8,19,7,'21/11/2016','1612490309',7,2,821897,5202415,743535);
INSERT INTO Facturas (id_cliente,id_vehiculo,id_vendedor,Fecha_factura,Derecho_licencia,Impuesto_aplicable,id_vehiculo_intercambio,Descuento_vehiculo_intercambio,Monto_maximo_permitido,Total_venta) VALUES (24,3,21,'11/05/2017','1919716115',7,13,492355,5790618,1337498);
INSERT INTO Facturas (id_cliente,id_vehiculo,id_vendedor,Fecha_factura,Derecho_licencia,Impuesto_aplicable,id_vehiculo_intercambio,Descuento_vehiculo_intercambio,Monto_maximo_permitido,Total_venta) VALUES (23,12,18,'05/08/2018','0254573517',7,18,369402,5037167,483628);
INSERT INTO Facturas (id_cliente,id_vehiculo,id_vendedor,Fecha_factura,Derecho_licencia,Impuesto_aplicable,id_vehiculo_intercambio,Descuento_vehiculo_intercambio,Monto_maximo_permitido,Total_venta) VALUES (14,12,21,'08/08/2017','9597016237',7,2,203647,5076648,332641);
INSERT INTO Facturas (id_cliente,id_vehiculo,id_vendedor,Fecha_factura,Derecho_licencia,Impuesto_aplicable,id_vehiculo_intercambio,Descuento_vehiculo_intercambio,Monto_maximo_permitido,Total_venta) VALUES (17,20,1,'17/08/2017','2056465491',7,18,700812,5553940,988886);
INSERT INTO Facturas (id_cliente,id_vehiculo,id_vendedor,Fecha_factura,Derecho_licencia,Impuesto_aplicable,id_vehiculo_intercambio,Descuento_vehiculo_intercambio,Monto_maximo_permitido,Total_venta) VALUES (19,17,6,'13/10/2018','5604542684',7,5,638928,5862367,704834);
INSERT INTO Facturas (id_cliente,id_vehiculo,id_vendedor,Fecha_factura,Derecho_licencia,Impuesto_aplicable,id_vehiculo_intercambio,Descuento_vehiculo_intercambio,Monto_maximo_permitido,Total_venta) VALUES (19,18,25,'25/02/2018','0789042489',7,null,234204,5203734,1479124);
INSERT INTO Facturas (id_cliente,id_vehiculo,id_vendedor,Fecha_factura,Derecho_licencia,Impuesto_aplicable,id_vehiculo_intercambio,Descuento_vehiculo_intercambio,Monto_maximo_permitido,Total_venta) VALUES (4,12,12,'01/05/2018','8166285923',7,12,452936,5649559,1143364);

SELECT * from facturas;

-- Tabla Histórico Vehículos
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (11,8,'06/08/2018','NEW');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (18,13,'09/12/2016','NEW');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (2,6,'08/12/2016','TRADE');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (7,8,'22/11/2018','SOLD');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (7,1,'20/02/2018','NEW');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (15,4,'04/04/2018','TRADE');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (9,5,'11/07/2017','SOLD');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (10,9,'13/03/2018','NEW');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (9,7,'28/09/2018','TRADE');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (12,1,'28/01/2017','SOLD');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (11,4,'25/03/2018','NEW');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (5,8,'21/09/2017','TRADE');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (17,5,'17/07/2018','SOLD');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (13,6,'22/08/2017','NEW');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (6,5,'14/04/2017','TRADE');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (18,6,'15/09/2017','SOLD');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (18,7,'21/12/2017','NEW');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (18,3,'20/04/2017','TRADE');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (3,5,'15/08/2018','SOLD');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (12,10,'14/01/2017','NEW');
INSERT INTO Historico_Vehiculos (id_vehiculo,id_factura,Fecha_novedad,Estado) VALUES (17,2,'02/05/2018','TRADE');

SELECT * from Historico_Vehiculos;

-- Tabla Factura_Detalle
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (1,5,275373,3);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (1,10,920070,12);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (1,8,445826,12);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (1,7,836215,9);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (4,1,468408,1);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (4,9,536494,12);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (5,4,281625,3);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (6,10,662709,10);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (8,9,982246,15);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (10,5,443718,10);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (10,8,802581,2);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (10,7,529678,10);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (10,10,320187,5);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (10,9,889266,5);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (10,6,903457,2);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (3,1,676138,10);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (3,4,115923,2);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (3,9,311859,7);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (11,4,120330,4);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (11,8,255667,7);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (11,3,677534,8);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (11,1,706209,1);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (11,7,885689,8);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (13,8,867166,12);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (13,7,260718,7);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (13,5,761785,10);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (13,6,386836,14);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (13,12,375726,15);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (13,2,682567,9);
INSERT INTO Factura_Detalle (id_factura,id_accesorio,Valor_venta,Cantidad_producto) VALUES (13,1,717940,8);

SELECT * from Factura_Detalle;

/* AHORA SI, SE PROCEDE A RESOLVER EL TALLER DESDE EL PUNTO 3 EN ADELANTE */

/*
  3.	Cree una vista para mostrar los productos que tienen menos de 5 unidades disponibles, la vista debe tener el ID, el nombre del producto, 
      el código y el nombre del fabricante.
*/

CREATE OR REPLACE VIEW ACCESORIOS_CON_MENOS_DE_5_UNIDADES AS
 SELECT A.ID, A.DESCRIPCION, F.CODIGO_FABRICANTE, F.NOMBRE_FABRICANTE, A.UNIDADES_DISPONIBLES
  FROM ACCESORIOS A INNER JOIN FABRICANTES F
   ON A.ID_FABRICANTE = F.ID
    WHERE A.UNIDADES_DISPONIBLES < 5;
  
/*   
  4. Cree un TRIGGER que disminuya la cantidad de unidades disponibles después de que el producto se haya asociado a una factura.
*/

CREATE OR REPLACE TRIGGER DISMINUIR_UNIDADES_DISPONIBLES_X_PRODUCTO BEFORE INSERT ON FACTURA_DETALLE
FOR EACH ROW
 
BEGIN
    UPDATE ACCESORIOS SET UNIDADES_DISPONIBLES = UNIDADES_DISPONIBLES - :new.cantidad_producto
      WHERE ID = :new.id_accesorio;  
END;

/*
  5.	Cree un procedimiento llamado "reorder_units", dentro del procedimiento que debe llamar a la vista creada en el paso # 3, 
      para cada elemento devuelto, el valor de "units_available" debe incrementarse en 20 unidades de forma predeterminada.
*/

CREATE OR REPLACE PROCEDURE reorder_units AS

BEGIN
  UPDATE ACCESORIOS_CON_MENOS_DE_5_UNIDADES SET UNIDADES_DISPONIBLES = UNIDADES_DISPONIBLES + 20;
END;

/*
  6.	Cree una vista con las siguientes columnas (bill_id, sales_person_id, name_of_salesperson, client_id, name_of_client, vehicle_id, 
      brand_of_vehicle, manufacturer_of_vehicle, accesory_id, name_of_accesory). La idea es que puede agregar fuera de la vista 'donde bill_id = xx' 
      y muestra la información asociada a una factura incluyendo sus detalles (accesorios).
*/
           
CREATE OR REPLACE VIEW ACCESORIOS_POR_FACTURA AS
  SELECT F.ID, F.ID_VENDEDOR AS "ID VENDEDOR", V.NOMBRES AS "NOMBRE VENDEDOR", V.APELLIDOS AS "APELLIDOS VENDEDOR", 
    F.ID_CLIENTE AS "ID CLIENTE", C.NOMBRES AS "NOMBRE CLIENTE", C.APELLIDOS AS "APELLIDOS CLIENTE", F.ID_VEHICULO AS "ID VEHÍCULO", 
      VEH.MARCA AS "MARCA VEHÍCULO", FAB.NOMBRE_FABRICANTE AS "NOMBRE FABRICANTE", A.ID AS "ID ACCESORIO", A.DESCRIPCION AS "NOMBRE ACCESORIO"
          FROM FACTURAS F 
          LEFT JOIN FACTURA_DETALLE FD ON F.ID = FD.ID_FACTURA
          LEFT JOIN ACCESORIOS A ON FD.ID_ACCESORIO = A.ID
          INNER JOIN VENDEDORES V ON F.ID_VENDEDOR = V.ID
          INNER JOIN VEHICULOS VEH ON F.ID_VEHICULO = VEH.ID
          INNER JOIN FABRICANTES FAB ON VEH.ID_FABRICANTE = FAB.ID
          INNER JOIN CLIENTES C ON F.ID_CLIENTE = C.ID;

/* 7.	Cree un EXPLAIN PLAN plan para el último paso (agregue una captura de pantalla o copie y pegue la información devuelta). */

-- Procedemos a crear el EXPLAIN PLAN solicitado.
EXPLAIN PLAN SET STATEMENT_ID = 'Explain_Plan_7' FOR SELECT * FROM ACCESORIOS_POR_FACTURA;

-- Se procede a buscar el EXPLAIN PLAN recién creado
SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY('PLAN_TABLE', 'Explain_Plan_7', 'ALL') );