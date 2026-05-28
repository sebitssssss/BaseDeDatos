DROP DATABASE IF EXISTS fg;
CREATE DATABASE fg;
USE fg;

CREATE TABLE Edificios(
    ID_Edificio int primary key auto_increment not null,
    Direccion varchar(25),
    Nombre varchar(20)
);

CREATE TABLE Departamentos(
    ID_Departamento int primary key auto_increment not null,
    ID_Edificio int not null,
    Piso int(2),
    FOREIGN KEY (ID_Edificio) REFERENCES Edificios(ID_Edificio)
);

CREATE TABLE Expensas(
    ID_Expensa int primary key auto_increment not null,
    ID_Departamento int not null,
    Monto int(10),
    Estado enum("Pago", "Impago"),
    FOREIGN KEY (ID_Departamento) REFERENCES Departamentos(ID_Departamento)
);