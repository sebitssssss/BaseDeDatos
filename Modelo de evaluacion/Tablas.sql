DROP DATABASE IF EXISTS eval;
CREATE DATABASE eval;
USE eval;

CREATE TABLE Organizaciones(
IDOrganizacion int primary key auto_increment not null,
Nombre varchar(30),
Duenio varchar(20)
);

CREATE TABLE Tecnicos(
IDTecnico int primary key auto_increment not null,
Nombre varchar(30),
Apellido varchar(30)
);

CREATE TABLE Marcas(
IDMarca int primary key auto_increment not null,
Nombre varchar(20),
Duenio varchar(20)
);

CREATE TABLE Modelos(
IDModelo int primary key auto_increment not null,
IDMarca int not null,
Anio int(4),
NumSerie int(8),
FOREIGN KEY (IDMarca) REFERENCES Marcas(IDMarca)
);

CREATE TABLE Vehiculos(
IDVehiculo int primary key auto_increment not null,
IDOrganizacion int not null,
Modelo varchar(30),
Marca varchar(20),
FOREIGN KEY (IDOrganizacion) REFERENCES Organizaciones(IDOrganizacion)
);

CREATE TABLE Revisiones(
IDRevision int primary key auto_increment not null,
IDTecnico int not null,
IDVehiculo int not null,
CosteReparacion int(5),
NivelBateria int(3),
EstadoGeneral varchar(40),
Fecha date,
TipoServicio enum("Preventivo","Correctivo"),
FOREIGN KEY (IDTecnico) REFERENCES Tecnicos(IDTecnico),
FOREIGN KEY (IDVehiculo) REFERENCES Vehiculos(IDVehiculo)
);

CREATE TABLE Piezas(
IDPieza int primary key auto_increment not null,
IDRevision int not null,
Marca varchar(20),
NumSerie int(8),
Modelo varchar(30),
FOREIGN KEY (IDRevision) REFERENCES Revisiones(IDRevision)
);