create database ecommerce;
use ecommerce;

create table categorias
(
idcat int primary key auto_increment,
nombrecat varchar(25)
);

create table productos
(
idprod int primary key auto_increment,
nombre varchar(25),
precio int,
idcat int,
foreign key (idcat) references categorias(idcat)
);

create table detalleventa
(
iddetalle int primary key auto_increment,
idprod int,
cantidad int,
preciounit int,
foreign key (idprod) references productos(idprod)
);

insert into categorias (nombrecat) values
('Notebooks'),
('Celulares'),
('Perifericos'),
('Componentes'),
('Accesorios');

insert into productos (nombre, precio, idcat) values
('Notebook Lenovo', 1200000, 1),
('Iphone 13', 900000, 2),
('Mouse Gamer', 80, 3),
('Placa Video', 1500000, 4),
('Cable USB', 50, 5);

insert into detalleventa (idprod, cantidad, preciounit) values
(1, 300, 1200000),
(1, 250, 1200000),
(2, 20, 900000),
(3, 40, 80),
(5, 30, 50);

select
categorias.nombrecat,
productos.nombre,
sum(detalleventa.cantidad) as CantidadVendida
from categorias
inner join productos
on categorias.idcat = productos.idcat
inner join detalleventa
on productos.idprod = detalleventa.idprod
group by categorias.nombrecat, productos.nombre
having sum(detalleventa.cantidad) > 500
order by CantidadVendida desc
limit 1;

select
categorias.nombrecat,
avg(productos.precio) as PromedioPrecio,
sum(detalleventa.cantidad) as ProductosVendidos
from categorias
inner join productos
on categorias.idcat = productos.idcat
inner join detalleventa
on productos.idprod = detalleventa.idprod
group by categorias.nombrecat
having avg(productos.precio) > 1500
and sum(detalleventa.cantidad) >= 10;

select
categorias.nombrecat,
sum(detalleventa.cantidad * detalleventa.preciounit) as RecaudacionTotal
from categorias
inner join productos
on categorias.idcat = productos.idcat
inner join detalleventa
on productos.idprod = detalleventa.idprod
where productos.precio < 100
group by categorias.nombrecat
having sum(detalleventa.cantidad * detalleventa.preciounit) < 5000;