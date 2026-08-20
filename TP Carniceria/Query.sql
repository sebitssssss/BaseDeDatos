DROP DATABASE IF EXISTS FG;
CREATE DATABASE FG;
USE FG;

CREATE TABLE Carniceros(
IDCarnicero int primary key auto_increment not null,
Nombre varchar(20) not null,
Apellido varchar(20) not null,
DNI int(9) not null
);

CREATE TABLE Clientes(
IDCliente int primary key auto_increment not null,
Nombre varchar(20) not null,
Apellido varchar(20) not null,
Telefono varchar(15) not null,
MedioDePago varchar(20)
);

CREATE TABLE Pedidos(
IDPedido int primary key auto_increment not null,
IDCarnicero int not null,
IDCliente int not null,
CorteDeCarne varchar(20) not null,
Precio int(20) not null,
FOREIGN KEY (IDCarnicero) REFERENCES Carniceros(IDCarnicero),
FOREIGN KEY (IDCliente) REFERENCES Clientes(IDCliente)
);