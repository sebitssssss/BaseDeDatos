drop database if exists Carniceria;

create database Carniceria;

use Carniceria;

create table MediosPagos(
ID_MedioPago int primary key auto_increment not null,
Descripcion varchar(10)
);

create table Carniceros(
ID_Carnicero int primary key auto_increment not null,
Nombre varchar(10),
Apellido varchar(10),
DNI int(8)
);

create table Clientes(
ID_Cliente int primary key auto_increment not null,
Nombre varchar(10),
Telefono int(11),
ID_MedioPago int,
foreign key (ID_MedioPago) references MediosPagos(ID_MedioPago)
);

create table CortesCarnes(
ID_CorteCarne int primary key auto_increment not null,
Nombre varchar(10),
Precio_KG int(10)
);

create table Pedidos(
ID_Pedido int primary key auto_increment not null,
ID_Carnicero int,
foreign key (ID_Carnicero) references Carniceros(ID_Carnicero),
ID_Cliente int,
foreign key (ID_Cliente) references Clientes(ID_Cliente),
PrecioTotal int(10)
);

create table Pedidos_CorteCarne(
ID_Pedidos_CorteCarne int primary key auto_increment not null,
ID_Pedido int,
foreign key (ID_Pedido) references Pedidos(ID_Pedido),
ID_CorteCarne int,
foreign key (ID_CorteCarne) references CortesCarnes(ID_CorteCarne),
Cantidad_kg int(7)
);

use Carniceria;

insert into MediosPagos(Descripcion)
values
("Mercado pago"),
("Clarence Dolla"),
("Cuenta DNI");

insert into Carniceros(Nombre, Apellido, DNI)
values
("Carlos", "Latour", 50347600),
("Clarence", "Shop", 83574902),
("Pablo", "Dos", 628364826);
 
insert into Clientes(Nombre, Telefono, ID_MedioPago)
values
("KleiverSon", 90607345 , 1 ),
("Brayian Johanson", 24538991 , 3),
("Usnavi Yokleiver", 65748896 , 2);

insert into CortesCarnes(Nombre, Precio_KG)
values
("Cuadril", 100),
("Vacio", 10),
("Lomo", 156);

insert into Pedidos(ID_Carnicero, ID_Cliente, PrecioTotal)
values
(1,2,1000),
(2,3,90074),
(3,1,32423); 

insert into Pedidos_CorteCarne(ID_Pedido,ID_CorteCarne,Cantidad_kg)
values
(1, 1, 90),
(2, 2, 20),
(3, 3, 50);

select CortesCarnes.Nombre from CortesCarnes
group by Pedidos_CorteCarne
having ID_CorteCarne