create database Artistas;
use Artistas;

create table artistas
(idartista int primary key auto_increment,
nombre varchar(25),
zona varchar(25)
);

create table albumes
(idalbum int primary key auto_increment,
nombre varchar(25),
idartista int,
foreign key (idartista ) references artistas(idartista));

create table reproducciones
(idreproduccion int primary key auto_increment,
idalbum int,
foreign key (idalbum)references albumes(idalbum),
cantrep int(10)
);

insert into artistas (nombre, zona) values
('Duki', 'Argentina'),
('Bizarrap', 'Argentina'),
('Bad Bunny', 'Puerto Rico'),
('Rosalia', 'España'),
('Quevedo', 'España');

insert into albumes (nombre, idartista) values
('Desde el Fin', 1),
('Temporada Reggaeton', 1),
('Super Sangre Joven', 1),
('Ameri', 1),
('BZRP Sessions', 2);

insert into reproducciones (idalbum, cantrep) values
(1, 300000),
(2, 250000),
(3, 280000),
(4, 350000),
(5, 40000);

select artistas.nombre, sum(reproducciones.cantrep) as CantidadReproducciones, count(albumes.idalbum) as CantidadAlbunes
from artistas
inner join albumes on albumes.idartista = artistas.idartista
inner join reproducciones on reproducciones.idalbum = albumes.idalbum
group by artistas.idartista, artistas.nombre
having sum(reproducciones.cantrep) > 1000000 and count(albumes.idalbum) > 3;

select albumes.nombre as nombreAlbum,
artistas.nombre as nombreArtista,
avg(reproducciones.cantrep) as promedioReproducciones
from albumes
inner join artistas on artistas.idartista = albumes.idartista
inner join reproducciones on reproducciones.idalbum = albumes.idalbum
group by albumes.idalbum, albumes.nombre, artistas.nombre
having avg(reproducciones.cantrep) > 50000;

select 
sum(reproducciones.cantrep) as ReporduccionesTotales, artistas.nombre as ArtistaConmenosReproducciones
from albumes
inner join artistas on artistas.idartista = albumes.idartista
inner join reproducciones on reproducciones.idalbum = albumes.idalbum
group by albumes.idalbum, albumes.nombre, artistas.nombre
having count(albumes.idalbum) >= 1
order by sum(reproducciones.cantrep) desc
limit 1;


