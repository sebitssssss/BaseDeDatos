use biblioteca;

create table usuarios
(
idusuario int auto_increment primary key not null,
telefono varchar(25),
nombre varchar(25),
direccion varchar(25)
);

create table autores
(
idautor int auto_increment primary key not null,
nombre varchar(25)
);

create table libros
(
idlibro int auto_increment primary key not null,
titulo varchar(50),
isbn int(13),
editorial varchar(25),
paginas int(3)
);

create table ejemplares 
(
idejemplar int auto_increment primary key not null,
idlibro int,
localizacion varchar(25),
foreign key (idlibro) references libros(idlibro)
);

create table  autoreslibros
(
idautorlibro int auto_increment primary key,
idlibro int,
idautor int,
foreign key (idlibro)references libros(idlibro),
foreign key (idautor) references autores(idautor)
);

create table prestamos
(
idprestamo int primary key auto_increment,
fechaentrega date,
fechavuelta date,
idejemplar int,
idusuario int, 
foreign key (idejemplar) references ejemplares(idejemplar),
foreign key (idusuario) references usuarios(idusuario)
 );

INSERT INTO autores VALUES
(1, 'Gabriel Garcia Marquez'),
(2, 'Julio Cortazar'),
(3, 'Jorge Luis Borges'),
(4, 'Isabel Allende'),
(5, 'Mario Vargas Llosa');

INSERT INTO libros VALUES
(1, 'Cien anos de soledad', '97803', 'Sudamericana', 471),
(2, 'Rayuela', '97884', 'Sudamericana', 736),
(3, 'Ficciones', '97808', 'Sur', 224),
(4, 'La casa de los espiritus', '97805', 'Plaza & Janes', 448),
(5, 'La ciudad y los perros', '978846', 'Seix Barral', 408);

INSERT INTO autoreslibros VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO ejemplares VALUES
(1, 'Estante A1', 1),
(2, 'Estante A2', 2),
(3, 'Estante B1', 3),
(4, 'Estante B2', 4),
(5, 'Estante C1', 5);

INSERT INTO usuarios VALUES
(1, 'Ana Lopez', 'Av. San Martin 123', '1122334455'),
(2, 'Carlos Perez', 'Belgrano 456', '1133445566'),
(3, 'Lucia Gomez', 'Mitre 789', '1144556677'),
(4, 'Martin Rodriguez', 'Rivadavia 321', '1155667788'),
(5, 'Sofia Fernandez', 'Sarmiento 654', '1166778899');

INSERT INTO prestamos VALUES
(1, '2026-04-01', '2026-04-10', 1, 1),
(2, '2026-04-03', '2026-04-12', 2, 2),
(3, '2026-04-05', '2026-04-15', 3, 3),
(4, '2026-04-07', 4, 4),
(5, '2026-04-09',  5, 5);

