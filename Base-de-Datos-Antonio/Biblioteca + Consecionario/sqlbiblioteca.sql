use DERBIBLIO;

create table autores(
idautor int primary key auto_increment,
nombre varchar(25) not null,
apellido varchar(25) not null
);

create table libros(
idlibro int primary key auto_increment,
titulo varchar(25) not null,
editorial varchar(25),
ISBN int(13),
numeropaginas int(3)
);

create table autores_libros(
idautor int,
idlibro int,
primary key (idautor, idlibro),
foreign key (idautor) references autores(idautor),
foreign key (idlibro) references libros(idlibro)
);

create table usuarios(
idusuario int primary key auto_increment,
nombre varchar(25),
direccion varchar(25),
telefono varchar(25)
);

create table ejemplares(
idejemplar int primary key auto_increment,
idlibro int,
localizacion varchar(25),
foreign key (idlibro) references libros(idlibro)
);

create table usuarioejemplar(
idusuario int,
idejemplar int,
primary key (idusuario, idejemplar),
foreign key (idusuario) references usuarios(idusuario),
foreign key (idejemplar) references ejemplares(idejemplar)
);

create table prestamos(
idprestamo int primary key auto_increment,
idusuario int,
idejemplar int,
fechaingreso date, 
fechaentrega date,
foreign key (idusuario) references usuarios(idusuario),
foreign key (idejemplar) references ejemplares(idejemplar)
);