create database peliculas;
use peliculas;

create table directores
(
iddirector int primary key auto_increment,
nombre varchar(50),
edad int,
sueldo int
);

create table plataformas
(
idplataforma int primary key auto_increment,
nombre varchar(50)
);

create table series
(
idserie int primary key auto_increment,
nombre varchar(50),
genero varchar(25),
aniolanzamiento date,
presupuesto int,
idplataforma int,
iddirector int,
foreign key (idplataforma) references plataformas(idplataforma),
foreign key (iddirector) references directores(iddirector)
);

create table temporadas
(
idetemporada int primary key auto_increment,
idserie int,
nombre varchar(50),
numero int,
descripcion varchar(100),
foreign key (idserie) references series(idserie)
);

create table personajes
(
idpersonaje int primary key auto_increment,
nombre varchar(50),
edad int,
genero varchar(25),
idserie int,
foreign key (idserie) references series(idserie)
);

create table episodios
(
idepisodio int primary key auto_increment,
numero int,
nombre varchar(50),
descripcion varchar(100),
puntuacion decimal(3,1),
fechaestreno date,
idetemporada int,
foreign key (idetemporada) references temporadas(idetemporada)
);

insert into plataformas(nombre) values
('Netflix'),
('Disney+'),
('Max'),
('Amazon'),
('Apple TV');

insert into directores(nombre, edad, sueldo) values
('Duffer Brothers', 40, 500000),
('Christopher Storer', 43, 350000),
('Craig Mazin', 53, 900000),
('Mark Mylod', 59, 750000),
('Eric Kripke', 50, 400000),
('Charlie Brooker', 53, 300000),
('Declan Lowney', 63, 450000),
('Ben Stiller', 58, 800000),
('Jonathan Nolan', 47, 1200000),
('Baran bo Odar', 46, 280000);

insert into series(nombre, genero, aniolanzamiento, presupuesto, idplataforma, iddirector) values
('Stranger Things', 'Sci-Fi', '2016-01-01', 30000000, 1, 1),
('The Bear', 'Drama', '2022-01-01', 12000000, 2, 2),
('The Last of Us', 'Post-apoc', '2023-01-01', 100000000, 3, 3),
('Succession', 'Drama', '2018-01-01', 90000000, 3, 4),
('The Boys', 'Accion', '2019-01-01', 11000000, 4, 5),
('Black Mirror', 'Antologia', '2011-01-01', 5000000, 1, 6),
('Ted Lasso', 'Comedia', '2020-01-01', 15000000, 5, 7),
('Severance', 'Suspenso', '2022-01-01', 40000000, 5, 8),
('Fallout', 'Sci-Fi', '2024-01-01', 150000000, 4, 9),
('Dark', 'Intriga', '2017-01-01', 18000000, 1, 10);

insert into temporadas(idserie, nombre, numero, descripcion) values
(1, 'Stranger Things 1', 1, 'Desaparicion de Will'),
(1, 'Stranger Things 4', 4, 'El regreso de Vecna'),
(2, 'The Bear S1', 1, 'El caos en la cocina'),
(3, 'The Last of Us S1', 1, 'El viaje de Joel y Ellie'),
(4, 'Succession S4', 4, 'La guerra final'),
(5, 'The Boys S1', 1, 'Los heroes son malos'),
(6, 'Black Mirror S1', 1, 'Tecnologia y pesadillas'),
(7, 'Ted Lasso S1', 1, 'Un DT de futbol americano en UK'),
(8, 'Severance S1', 1, 'Separacion cerebral laboral'),
(9, 'Fallout S1', 1, 'Salida del refugio 33');

insert into personajes(nombre, edad, genero, idserie) values
('Eleven', 14, 'Femenino', 1),
('Carmy Berzatto', 28, 'Masculino', 2),
('Joel Miller', 52, 'Masculino', 3),
('Ellie Williams', 14, 'Femenino', 3),
('Kendall Roy', 40, 'Masculino', 4),
('Homelander', 38, 'Masculino', 5),
('Ted Lasso', 45, 'Masculino', 7),
('Mark Scout', 42, 'Masculino', 8),
('Lucy MacLean', 22, 'Femenino', 9),
('Jonas Kahnwald', 17, 'Masculino', 10);

insert into episodios(numero, nombre, descripcion, puntuacion, fechaestreno, idetemporada) values
(101, 'El mundo del reves', 'El inicio de todo', 9.2, '2016-07-15', 1),
(102, 'Dear Billy', 'El escape de Max', 9.8, '2022-05-27', 2),
(103, 'Sistema', 'El servicio mas intenso', 9.5, '2022-06-23', 3),
(104, 'Mucho tiempo', 'La historia de Bill y Frank', 9.9, '2023-01-29', 4),
(105, 'Connors Wedding', 'Un giro inesperado', 10.0, '2023-04-09', 5),
(106, 'El nombre del juego', 'Hughie se une a los Boys', 8.8, '2019-07-26', 6),
(107, 'Himno Nacional', 'El episodio del primer ministro', 8.1, '2011-12-04', 7),
(108, 'Piloto', 'Ted llega a Richmond', 8.5, '2020-08-14', 8),
(109, 'Lo que somos', 'El final de temporada', 9.7, '2022-04-08', 9),
(110, 'El fin', 'Descubrimientos en el yermo', 9.4, '2024-04-10', 10);


