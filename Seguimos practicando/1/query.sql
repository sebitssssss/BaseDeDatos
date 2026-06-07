DROP DATABASE IF EXISTS fg;
CREATE DATABASE fg;
USE fg;

create table Laboratorios(
	IDLaboratorio int primary key not null auto_increment,
    Nombre varchar(25),
    Pais varchar(25),
    Telefono varchar(15)
);

create table Medicamentos(
	IDMedicamento int primary key not null auto_increment,
    IDLaboratorio int not null,
    Nombre varchar(25),
    Monodroga Varchar(25),
    Precio int(6),
    foreign key (IDLaboratorio) references Laboratorios(IDLaboratorio)
);

create table Lotes(
	IDLote int primary key not null auto_increment,
    IDMedicamento int not null,
    Stock int(6), 
    Precio int(6),
    Vencimiento date,
    Ubicacion varchar(20),
    foreign key (IDMedicamento) references Medicamentos(IDMedicamento)
);