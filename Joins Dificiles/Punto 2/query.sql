DROP DATABASE IF EXISTS fg;
CREATE DATABASE fg;
USE fg;

CREATE TABLE Socios(
ID_Socio int primary key not null auto_increment,
Nombre varchar(20) not null,
Fecha_Inscripcion date not null
);

CREATE TABLE Planes(
ID_Plan int primary key not null auto_increment,
Tipo varchar(20) not null,
Costo int(10) not null
);

CREATE TABLE Pagos(
ID_Pago int primary key not null auto_increment,
ID_Socio int not null,
ID_Plan int not null,
Monto int(10) not null,
Fecha date not null,
FOREIGN KEY (ID_Socio) REFERENCES Socios(ID_Socio),
FOREIGN KEY (ID_Plan) REFERENCES Planes(ID_Plan)
);
