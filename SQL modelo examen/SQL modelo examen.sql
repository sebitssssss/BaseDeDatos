create database tiendaenlinea;
use tiendaenlinea;

create table productos(
idproducto int primary key auto_increment,
nombre varchar(25),
descripcion varchar(50),
precio int(8),
stock int(3)
);

create table clientes (
idcliente int primary key auto_increment,
nombre varchar(25),
apellido varchar(25),
correo varchar(25),
dirrecion varchar(25)
);

create table pedidos (
idpedidos int primary key auto_increment,
idcliente int,
idproducto int,
foreign key (idcliente)references clientes(idcliente),
foreign key (idproducto)references productos(idproducto),
fecha date, 
estado varchar(25)
);


insert into productos (nombre, descripcion, precio, stock) values
('Teclado Mecánico', 'Teclado RGB switches blue 104 teclas', 75, 50),
('Mouse Gamer', 'Mouse óptico 6400 DPI con 6 botones', 45, 80),
('Monitor 24"', 'Monitor Full HD 144Hz panel IPS', 220, 20),
('Auriculares BT', 'Auriculares inalámbricos cancelación de ruido', 90, 35),
('Webcam HD', 'Cámara web 1080p con micrófono integrado', 60, 45);


insert into clientes (nombre, apellido, correo, dirrecion) values
('Lucas', 'Fernández', 'lucas@gmail.com', 'Av. Corrientes 1234'),
('Valentina', 'Gómez', 'valen@gmail.com', 'San Martín 456'),
('Mateo', 'Rodríguez', 'mateo@gmail.com', 'Belgrano 789'),
('Sofía', 'López', 'sofi@gmail.com', 'Rivadavia 321'),
('Tomás', 'Martínez', 'tomas@gmail.com', 'Mitre 654');


insert into pedidos (idcliente, idproducto, fecha, estado) values
(1, 3, '2024-11-10', 'Entregado'),
(2, 1, '2024-12-05', 'Pendiente'),
(3, 5, '2024-12-18', 'Entregado'),
(4, 2, '2025-01-03', 'Cancelado'),
(5, 4, '2025-01-15', 'Pendiente');


## query1
select nombre, precio
from productos
WHERE precio > 50;

## query 2
select clientes.nombre, clientes.apellido, pedidos.idpedidos as Pedido
from clientes 
inner join pedidos on clientes.idcliente = pedidos.idcliente;

##query 3

select pedidos.estado as Estado, clientes.nombre as Nombrecliente, pedidos.fecha as Fecha
from pedidos
inner join clientes on pedidos.idcliente = clientes.idcliente
group by clientes.nombre, pedidos.fecha, pedidos.estado
having pedidos.estado = 'Entregado';

##query 4

select pedidos.estado as Estado, clientes.correo as Mails
from pedidos
inner join clientes on pedidos.idcliente = clientes.idcliente;

##query 5
select pedidos.fecha as FechaPedido, clientes.nombre as Nombrecliente
from pedidos
inner join clientes on pedidos.idcliente = clientes.idcliente
order by pedidos.fecha desc
limit 1;

##query 6
select pedidos.estado as EstadoPedido, pedidos.fecha as fecha , clientes.nombre
from pedidos
inner join clientes on pedidos.idcliente = clientes.idcliente
group by clientes.nombre, pedidos.estado, pedidos.fecha
having pedidos.estado = 'Pendiente';

##query 7 
select productos.nombre as Nombre, productos.precio as Precio
from productos
order by productos.precio desc
limit 1;
