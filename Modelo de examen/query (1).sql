DROP DATABASE IF EXISTS fg;
CREATE DATABASE fg;
USE fg;

CREATE TABLE Productos(
IDProducto int primary key not null,
Nombre varchar(30),
Descripcion varchar(50),
Precio int(8),
Stock int(8)
);

CREATE TABLE Clientes(
IDCliente int primary key not null,
Nombre varchar(30),
Apellido varchar(30),
Email varchar(30),
Direccion varchar(30)
);

CREATE TABLE Pedidos(
IDPedido int primary key not null,
IDCliente int not null,
Fecha date,
Estado enum("Pendiente", "En proceso", "Enviado", "Entregado"),
FOREIGN KEY (IDCliente) REFERENCES Clientes(IDCliente)
);