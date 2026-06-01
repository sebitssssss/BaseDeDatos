create database restaurantes;
use restaurantes;

create table restaurantes
(
idrestaurante int primary key auto_increment,
nombre varchar(25),
zona varchar(25)
);

create table platos
(
idplato int primary key auto_increment,
nombreplato varchar(25),
precio int,
idrestaurante int,
foreign key (idrestaurante) references restaurantes(idrestaurante)
);

create table pedidos
(
idpedido int primary key auto_increment,
idplato int,
foreign key (idplato) references platos(idplato),
cantidad int
);

insert into restaurantes (nombre, zona) values
('Pizza Roma', 'Centro'),
('Burger House', 'Norte'),
('Sushi Zen', 'Sur'),
('Pizza Napoli', 'Oeste'),
('La Parrilla', 'Centro');

insert into platos (nombreplato, precio, idrestaurante) values
('Muzzarella', 2500, 1),
('Napolitana', 3000, 1),
('Hamburguesa', 1800, 2),
('Sushi Roll', 4000, 3),
('Pizza Especial', 3500, 4);

insert into pedidos (idplato, cantidad) values
(1, 120),
(2, 100),
(3, 80),
(4, 60),
(5, 150);


select restaurantes.nombre,
sum(pedidos.cantidad) as pedidosTotales,
count( platos.idplato) as cantidadPlatos
from restaurantes
inner join platos on platos.idrestaurante = restaurantes.idrestaurante
inner join pedidos on pedidos.idplato = platos.idplato
group by restaurantes.idrestaurante, restaurantes.nombre
having count( platos.idplato) > 1 ##La query esta bien planteada pero dado los registros ingresados, tuve que cambiar la misma.
and sum(pedidos.cantidad) > 200;

select restaurantes.nombre,
avg(pedidos.cantidad * platos.precio) as promedioIngresos
from restaurantes
inner join platos on platos.idrestaurante = restaurantes.idrestaurante
inner join pedidos on pedidos.idplato = platos.idplato
where platos.precio > 1500
group by restaurantes.idrestaurante, restaurantes.nombre;

select platos.nombreplato,
restaurantes.nombre as nombreRestaurante,
sum(pedidos.cantidad) as ventasTotales
from restaurantes
inner join platos on platos.idrestaurante = restaurantes.idrestaurante
inner join pedidos on pedidos.idplato = platos.idplato
where restaurantes.nombre like '%Pizza%'  ##Tuve que usar la IA para hacer que busque los platos que tengan la palabra pizza por que si uso = mostraria solo los que se llamen explicitamente Pizza
group by platos.idplato, platos.nombreplato, restaurantes.nombre
order by ventasTotales desc
limit 10;
