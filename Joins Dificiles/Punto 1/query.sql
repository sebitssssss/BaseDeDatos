DROP DATABASE IF EXISTS fg;
CREATE DATABASE fg;
USE fg;

CREATE TABLE Pasajeros(
ID_Pasajero int primary key not null auto_increment,
Nombre varchar(20) not null,
DNI int(10) not null
);

CREATE TABLE Aviones(
ID_Avion int primary key not null auto_increment,
Modelo varchar(20) not null,
Capacidad int(3) not null
);

CREATE TABLE Vuelos(
ID_Vuelo int primary key not null auto_increment,
ID_Avion int not null,
Origen varchar(20) not null,
Destino varchar(20) not null,
Fecha date not null,
Abordantes int not null,
FOREIGN KEY (ID_Avion) REFERENCES Aviones(ID_Avion)
);

CREATE TABLE Tickets(
ID_Ticket int primary key not null auto_increment,
ID_Avion int not null,
ID_Pasajero int not null,
Precio int(10) not null,
FOREIGN KEY (ID_Avion) REFERENCES Aviones(ID_Avion),
FOREIGN KEY (ID_Pasajero) REFERENCES Pasajeros(ID_Pasajero)
);