create database EMPRESA;
use EMPRESA;

Create table EMPLEADOS(
	IDEmpleado Int Auto_increment primary key not null,
    Nombre varchar(18),
    Apellido varchar(20) not null,
    Sector enum('RRHH','Adm','Ventas','Compras'),
    Edad int(2) DEFAULT '35' not null,
    Sexo enum('F','M') not null,
    Barrio_vivienda varchar(25) DEFAULT 'Belgrano',
    CodPostal int(4),
    Ingreso int(4) not null,
    Sueldo float not null,
    Antiguedad float not null DEFAULT 25,
    Celular varchar(20) not null
);
