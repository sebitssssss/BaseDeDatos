create database gimnasio;
use gimnasio;

create table socios
(idsocio int primary key auto_increment,
nombre varchar(25),
fechaalta date
);

create table planes
(
idplan int primary key auto_increment,
tipo varchar(25),
costo int(6)
);

create table pagos
(
idpago int primary key auto_increment,
idsocio int,
foreign key (idsocio)references socios(idsocio),
monto int,
fecha date,
idplan int,
foreign key (idplan)references planes(idplan)
);

insert into socios (nombre, fechaalta) values
('Juan Perez', '2026-01-10'),
('Lucia Gomez', '2026-02-15'),
('Mateo Lopez', '2026-03-01'),
('Sofia Diaz', '2026-03-20'),
('Tomas Ruiz', '2026-04-05');

insert into planes (tipo, costo) values
('Basico', 15000),
('Intermedio', 25000),
('Premium', 40000),
('Musculacion', 30000),
('Full', 50000);

insert into pagos (idsocio, monto, fecha, idplan) values
(1, 40000, '2026-05-01', 3),
(1, 40000, '2026-05-10', 3),
(1, 40000, '2026-05-20', 3),
(1, 40000, '2026-05-28', 3),
(2, 15000, '2026-05-15', 1);

select 
socios.nombre, count(pagos.idpago) as Cantidadpagos, sum(pagos.monto) as Montototal
from socios
inner join pagos
on socios.idsocio = pagos.idsocio
group by socios.idsocio, socios.nombre
having sum(pagos.monto) > (
select planes.costo
from planes
where tipo = 'Premium');

select
planes.tipo,
count(pagos.idsocio) as Cantidadsocio,
sum(pagos.monto) as Ingresototal
from planes
inner join pagos
on pagos.idplan = planes.idplan
group by planes.tipo
having count(pagos.idsocio) > 1
and sum(pagos.monto) > 1000;

select
planes.tipo, socios.nombre, count(pagos.idpago) as cantidadpagos
from socios
inner join pagos
on socios.idsocio = pagos.idsocio
inner join planes
on pagos.idplan = planes.idplan
group by socios.nombre, planes.tipo
having count(pagos.idpago) > 3;