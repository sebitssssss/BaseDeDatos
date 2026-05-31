create database consecionario;

use consecionario;

create table clientes
(
idcliente int primary key auto_increment,
dni int(8),
nombre varchar(25),
apellido varchar(25),
direccion varchar(25),
telefono varchar(25)
);

create table coches
(
idcoche int primary key auto_increment,
modelo varchar(25),
marca varchar(25),
color varchar(25),
patente varchar(10)
);

create table cochesnuevos
(
idcochenuevo int primary key auto_increment,
idcoche int,
patente varchar(10),
cantidadunidad int(3),
foreign key (idcoche) references coches(idcoche)
);

create table cochesusados 
(
idcocheusado int primary key auto_increment,
idcoche int,
patente varchar(10),
kilometros int(10),
foreign key (idcoche) references coches(idcoche)
);

create table mecanicos 
(
idmecanico int primary key auto_increment,
dni int(8),
nombre varchar(25),
apellido varchar(25),
fecha_contrato date,
salario int(10)
);

create table reparaciones
(
idreparacion int primary key auto_increment,
dni int(8),
idmecanico int,
foreign key (idmecanico) references mecanicos(idmecanico),
patente varchar(10),
idcoche int,
foreign key (idcoche) references coches(idcoche),
fecha_reparacion date,
horas int(3)
);

create table compras
(
idcompra int primary key auto_increment,
dni int,
idcliente int,
foreign key (idcliente) references clientes(idcliente),
patente varchar(10),
idcoche int,
foreign key (idcoche) references coches(idcoche),
fecha_compra date
);

INSERT INTO clientes VALUES
(1, 12345678, 'Carlos', 'Garcia',    'Calle Mayor 10',   '611111111'),
(2, 23456789, 'Laura',  'Martinez',  'Av. Libertad 45',  '622222222'),
(3, 34567890, 'Pedro',  'Sanchez',   'Calle Luna 3',     '633333333'),
(4, 45678901, 'Ana',    'Gomez',     'Paseo del Rio 21', '644444444'),
(5, 56789012, 'Luis',   'Lopez',     'Calle Sol 8',      '655555555');

INSERT INTO coches VALUES
(1, 'Corolla', 'Toyota',     'Blanco', 'AB123CD'),
(2, 'Golf',    'Volkswagen', 'Negro',  'EF456GH'),
(3, 'Clio',    'Renault',    'Rojo',   'IJ789KL'),
(4, 'Serie 3', 'BMW',        'Gris',   'MN012OP'),
(5, 'Ibiza',   'Seat',       'Azul',   'QR345ST');

INSERT INTO cochesnuevos VALUES
(1, 1, 'AB123CD', 5),
(2, 2, 'EF456GH', 3),
(3, 3, 'IJ789KL', 8),
(4, 4, 'MN012OP', 2),
(5, 5, 'QR345ST', 6);

INSERT INTO cochesusados VALUES
(1, 1, 'AB123CD',  95000),
(2, 2, 'EF456GH', 120000),
(3, 3, 'IJ789KL',  45000),
(4, 4, 'MN012OP',  78000),
(5, 5, 'QR345ST',  63000);

INSERT INTO mecanicos VALUES
(1, 87654321, 'Miguel', 'Perez',   '2020-06-01', 2500),
(2, 76543210, 'Sofia',  'Diaz',    '2019-03-15', 2800),
(3, 65432109, 'Jorge',  'Romero',  '2021-09-10', 2300),
(4, 54321098, 'Marta',  'Vega',    '2018-11-20', 3000),
(5, 43210987, 'Diego',  'Blanco',  '2022-01-05', 2100);

INSERT INTO reparaciones VALUES
(1, 87654321, 1, 'AB123CD', 1, '2024-06-01', 3),
(2, 76543210, 2, 'EF456GH', 2, '2024-06-05', 2),
(3, 65432109, 3, 'IJ789KL', 3, '2024-06-10', 5),
(4, 54321098, 4, 'MN012OP', 4, '2024-06-15', 1),
(5, 43210987, 5, 'QR345ST', 5, '2024-06-20', 4);

INSERT INTO compras VALUES
(1, 12345678, 1, 'AB123CD', 1, '2024-01-15'),
(2, 23456789, 2, 'EF456GH', 2, '2024-02-20'),
(3, 34567890, 3, 'IJ789KL', 3, '2024-03-10'),
(4, 45678901, 4, 'MN012OP', 4, '2024-04-05'),
(5, 56789012, 5, 'QR345ST', 5, '2024-05-18');
