create database pilotos;
use pilotos;
    
    create table paises(
    IDpais int primary key auto_increment,
    nombre varchar(25)
    );
    
    create table escuderias(
    IDescuderia int primary key auto_increment,
    nombre varchar(25),
    presupuesto int(10)
    );
    
    create table pilotos(
    IDpiloto int primary key auto_increment,
    nombre varchar(25),
    apellido varchar(25),
    DNI int(8),
    IDescuderia int,
    fechanacido date,
    foreign key (IDescuderia) references escuderias(IDescuderia)
    );
    
    create table autos(
    IDauto int primary key auto_increment,
    IDescuderia int, 
    foreign key (IDescuderia) references escuderias(IDescuderia),
    marca varchar(25),
    modelo varchar(25),
    precio int(10),
    anofabricacion date,
    patente varchar(25)
    );
    
    create table carreras(
    IDcarrera int primary key auto_increment,
    nombre varchar(25),
    km int(5),
    fecha date,
    IDpais int,
    foreign key (IDpais) references paises(IDpais)
    );
    
    create table carreraspilotos(
    IDcarrerapiloto int primary key auto_increment,
    IDpiloto int,
    foreign key (IDpiloto) references pilotos(IDpiloto),
    IDcarrera int,
    foreign key (IDcarrera) references carreras(IDcarrera),
    puesto int(2)
    );
    
INSERT INTO paises (nombre) VALUES
('Argentina'),
('Italia'),
('Monaco'),
('Brasil'),
('Espana');

INSERT INTO escuderias (nombre, presupuesto) VALUES
('Ferrari', 145000000),
('Mercedes', 140000000),
('Red Bull', 135000000),
('Alpine', 95000000),
('Williams', 80000000);

INSERT INTO pilotos (nombre, apellido, DNI, IDescuderia, fechanacido) VALUES
('Lewis', 'Hamilton', 30111222, 1, '1985-01-07'),
('Charles', 'Leclerc', 32444555, 1, '1997-10-16'),
('George', 'Russell', 33555666, 2, '1998-02-15'),
('Max', 'Verstappen', 34666777, 3, '1997-09-30'),
('Franco', 'Colapinto', 45777888, 4, '2003-05-27'),
('Logan', 'Sargeant', 46888999, 5, '2002-03-10');

INSERT INTO autos (IDescuderia, marca, modelo, precio, anofabricacion, patente) VALUES
(1, 'Ferrari', 'SF-24', 15000000, '2024-01-15', 'FER001'),
(2, 'Mercedes', 'W15', 14500000, '2024-02-10', 'MER001'),
(3, 'Red Bull', 'RB20', 16000000, '2024-01-20', 'RBR001'),
(4, 'Alpine', 'A524', 9000000, '2024-03-05', 'ALP001'),
(5, 'Williams', 'FW46', 8500000, '2024-02-28', 'WIL001');

INSERT INTO carreras (nombre, km, fecha, IDpais) VALUES
('GP de Argentina', 25, '2019-03-17', 1),
('GP de Italia', 22, '2021-09-12', 2),
('GP de Monaco', 18, '2022-05-29', 3),
('GP de Brasil', 30, '2023-11-05', 4),
('GP de Espana', 15, '2024-06-23', 5);

INSERT INTO carreraspilotos (IDpiloto, IDcarrera, puesto) VALUES
(1, 1, 1),
(4, 1, 2),
(2, 1, 3),
(4, 2, 1),
(3, 2, 2),
(1, 2, 3),
(2, 3, 1),
(1, 3, 2),
(5, 3, 3),
(1, 4, 1),
(2, 4, 2),
(6, 4, 3),
(5, 5, 1),
(4, 5, 2),
(3, 5, 3);


select pilotos.nombre as Piloto, escuderias.nombre as Escuderia
from escuderias
inner join pilotos on pilotos.IDescuderia = escuderias.IDescuderia
group by pilotos.IDpiloto, pilotos.nombre;

select escuderias.nombre as Nombre, escuderias.presupuesto as Presupuesto
from escuderias
where escuderias.presupuesto > (select avg(escuderias.presupuesto) from escuderias);

select autos.marca as Marca , autos.modelo as Modelo ,autos.precio as Precio, escuderias.nombre as Escuderia
from escuderias
inner join autos on autos.IDescuderia = escuderias.IDescuderia
WHERE autos.precio = (SELECT MAX(autos.precio) FROM autos);

select carreras.nombre as Carrera, paises.nombre as Pais, carreras.fecha as Fecha, carreras.km as KM
from paises
inner join carreras on carreras.IDpais = paises.IDpais
where carreras.km > 20
order by fecha asc;

select pilotos.nombre as Piloto, carreras.fecha as Fecha
from pilotos
inner join carreraspilotos on pilotos.IDpiloto = carreraspilotos.IDpiloto
inner join carreras on carreras.IDcarrera = carreraspilotos.IDcarrera
where carreraspilotos.puesto = 1
  and carreras.fecha > '2020-12-31'
  and TIMESTAMPDIFF(YEAR, pilotos.fechanacido, CURDATE()) > 25; ##Tuve que usar TIMESTAMPDIFF para calcular la edad cuando mi indice era la fecha y no la edad directamente.





    