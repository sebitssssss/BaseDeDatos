drop database if exists gj;
create database gj;

create table autores(
id_autor int primary key not null auto_increment,
nombre varchar(20) not null
);
create table usuarios(
id_usuario int primary key not null auto_increment,
telefono varchar(15) not null,
nombre varchar(20) not null,
direccion varchar(30) not null
);
create table libros(
id_libro int primary key not null auto_increment,
ISBN int(13) not null,
editorial varchar(30) not null,
pagina int(4) not null,
titulo varchar(30) not null
);
create table ejemplares(
id_ejemplar int primary key not null auto_increment,
id_libro int(3) not null auto_increment,
localizacion varchar(20) not null
);
create table prestamos(
id_prestamo int primary key not null auto_increment,
id_usuario int(3) not null auto_increment,
id_ejemplar int(3) not null auto_increment,
fecha_de_devolucion date not null,
fecha_de_entrega date not null
);
create table usuarios_ejemplares(
id_usuario_ejemplar int primary key not null auto_increment,
id_usuario int(3) not null auto_increment,
id_ejemplar int(3) not null auto_increment
);
create table autores_libros(
id_autor_libro int primary key not null auto_increment,
id_autor int(3) not null auto_increment,
id_libro int(3) not null auto_increment
);
