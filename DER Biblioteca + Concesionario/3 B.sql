drop database if exists bfghvc;
create database bfghvc;
use bfghvc;

create table partidos(
id_partido int primary key not null auto_increment,
id_estadio int not null,
fecha date not null
);
create table estadios(
id_estadio int primary key not null auto_increment,
nombre varchar(20) not null,
aforo int(8) not null
);
create table equipos(
id_equipo int primary key not null auto_increment,
id_estadio int not null,
nombre varchar(20) not null,
anio_fundacion int(5), 
ciudad_equipo varchar(20)
);
create table jugadores(
id_jugador int primary key not null auto_increment,
id_equipo int not null,
nombre varchar(20) not null,
fecha_nacimiento date not null,
posicion varchar(20)
);
create table goles(
id_gol int primary key not null auto_increment,
id_partido int not null,
id_jugador int not null,
gol_equipo enum("Local", "Visitante") not null,
minuto int(10) not null,
descripcion varchar(30) not null
);
create table presidentes(
id_presidente int primary key not null auto_increment,
id_equipo int not null,
dni int(10) not null,
nombre varchar(20) not null,
apellido varchar(20) not null,
fecha_nacimiento date not null,
anio_electo int(5)
);
