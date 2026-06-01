create database Aviones;
use Aviones;
create table aviones
(idavion int primary key auto_increment,
modelo varchar(25),
capacidad int(4)
);

create table vuelos
(idvuelo int primary key auto_increment,
origen varchar(25),
destino varchar(25),
idavion int,
fecha date,
foreign key (idavion) references Aviones(idavion)
);

create table pasajeros
(idpasajero int primary key auto_increment,
nombre varchar(25),
apellido varchar(25)
);


create table tickets
(idticket int primary key auto_increment,
idvuelo int,
idpasajero int,
foreign key (idvuelo) references vuelos(idvuelo),
foreign key (idpasajero)references pasajeros(idpasajero),
precioticket int (8)
);

insert into aviones (modelo, capacidad) values
('Boeing 737', 180),
('Airbus A320', 160),
('Embraer 190', 100),
('Boeing 787', 250),
('Airbus A330', 280);

insert into vuelos (origen, destino, fecha, idavion) values
('EZEIZA', 'Madrid','2026-05-20', 4),
('EZEIZA', 'Cordoba','2026-05-10', 1),
('Aeroparque', 'Mendoza','2026-05-12', 2),
('EZEIZA', 'Miami','2026-05-25', 5),
('Cordoba', 'Salta','2026-05-15', 3);

insert into pasajeros (nombre, apellido) values
('Juan', 'Perez'),
('Lucia', 'Gomez'),
('Mateo', 'Rodriguez'),
('Sofia', 'Fernandez'),
('Tomas', 'Lopez');

insert into tickets (idvuelo, idpasajero, precioticket) values
(1, 1, 850000),
(1, 2, 900000),
(1, 3, 870000),
(4, 4, 1200000),
(4, 5, 1250000);

select 
aviones.modelo, SUM(tickets.precioticket) as Cantidadrecaudado, COUNT(tickets.idticket) as Cantidadpasanjeros
from aviones
inner join vuelos on aviones.idavion = vuelos.idavion
inner join tickets on vuelos.idvuelo = tickets.idvuelo
group by aviones.modelo
having SUM(tickets.precioticket) > 2000000 and COUNT(tickets.idticket) > 1;

#La query esta bien planteada pero para tener mas de 100 tickets deberia poner por lo menos 100 registros;

select 
vuelos.origen, avg(tickets.precioticket) as promedioticket, vuelos.destino, vuelos.idvuelo
from vuelos
inner join tickets
on vuelos.idvuelo = tickets.idvuelo
where vuelos.origen = 'EZEIZA'
group by vuelos.idvuelo, vuelos.origen, vuelos.destino
having avg(tickets.precioticket) > 500;

select aviones.modelo, count(vuelos.idvuelo) as CantridadVuelos
from aviones
inner join vuelos
on aviones.idavion = vuelos.idavion
where vuelos.fecha >= '2026-05-01'
and vuelos.fecha <= '2026-05-30'
group by aviones.modelo
having count(vuelos.idvuelo) >= 1; ##La tabla da 0 de nuevo pero la query esta bien planteada, otra vez es problema de los registros.