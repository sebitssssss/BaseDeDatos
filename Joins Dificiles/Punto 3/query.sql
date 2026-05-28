DROP DATABASE IF EXISTS fg;
CREATE DATABASE fg;
USE fg;

CREATE TABLE Categorias(
	ID_Categoria int primary key auto_increment not null,
    Nombre varchar(20)
);

CREATE TABLE Productos(
	ID_Producto int primary key auto_increment not null,
    ID_Categoria int not null,
    Nombre varchar(20),
    Precio int(10),
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria)
);

CREATE TABLE Ventas(
	ID_Venta int primary key auto_increment not null,
    ID_Producto int not null,
    Cantidad int(5),
    Detalle varchar(50),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);