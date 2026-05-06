drop database if exists tr;
create database tr;
use tr;

create table clientes(
id_cliente int primary key not null auto_increment,
DNI varchar(20) not null,
nombre varchar(20) not null,
apellido varchar(20) not null,
direccion varchar(20) not null,
telefono varchar(20) not null
);
create table compras(
id_compra int primary key not null auto_increment,
id_cliente int not null,
id_coche int not null
);
create table consesionarios(
id_consesionario int primary key not null auto_increment,
nombre varchar(20) not null,
direccion varchar(20) not null
);
create table coches(
id_coche int primary key not null auto_increment,
id_consesionario int not null,
matricula varchar(15) not null,
modelo varchar(15) not null,
marca varchar(15) not null,
color varchar(15) not null
);
create table autos_nuevos(
id_auto_nuevo int primary key not null auto_increment,
unidades int(8) not null
);
create table autos_usados(
id_auto_usado int primary key not null auto_increment,
kilometraje varchar(8) not null
);
create table mecanicos_coches(
id_mecanico_coche int primary key not null auto_increment,
id_mecanico int not null,
id_coche int not null,
tiempo_reparacion varchar(10) not null,
fecha_reparacion date not null
);
create table mecanicos(
id_mecanico int primary key not null auto_increment,
DNI int(15) not null,
nombre varchar(20) not null,
apellido varchar(20) not null,
salario int(10) not null,
fecha_contratacion date not null
);
