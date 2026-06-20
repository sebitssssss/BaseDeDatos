create database cartoonN;
use cartoonN;

	create table series(
	idserie int primary key auto_increment,
	nombreserie varchar(50),
	anioestreno date,
	nombrecreador varchar(25)
	);

	create table personajes(
	idpersonaje int primary key auto_increment,
	nombrepersonaje varchar(25),
	idserie int,
	foreign key (idserie) references series(idserie),
	rol varchar(25),
	nivelenergia int(2)
	);

	create table episodios(
	idepisodio int primary key auto_increment,
	tituloepisodio varchar(25),
	idserie int,
	foreign key (idserie) references series(idserie), 
	duracionminutos int(2),
	rating int(2)
	);

	create table habilidadesespeciales(
	idhabilidad int primary key auto_increment,
	idpersonaje int,
	foreign key (idpersonaje) references personajes(idpersonaje),
	nombrehabilidad varchar(25),
	tipohabilidad varchar(25)
	);

	create table objetosmisticos(
	idobjeto int primary key auto_increment,
	nombreobjeto varchar(25),
	idpersonajeDueno int,
	foreign key (idpersonajeDueno) references personajes(idpersonaje),
	valorsubasta int(10)
	);

insert into series(nombreserie,anioestreno, nombrecreador)values
("Hora de aventura", 11/3/2010, "Pendleton Ward"),
("Ben10", 27/12/2005,"Man of Action"),
("Billy y Mandy", 13/6/2003,"Maxwell Atoms"),
("Un show mas", 6/9/2010,"J.G. Quintel"),
("Coraje el Perro Cobarde",12/11/1999 ,"John R. Dilworth"),
("El laboratorio de Dexter",28/4/1996,"Genndy Tartakovsky");

insert into personajes(nombrepersonaje,idserie,rol,nivelenergia) values
("Finn el humano", 1, "Protagonista", 85),
("Jake el perro",1,"Protagonista", 90),
("Rey Helado",1,"Antagonista", 75),
("Ben Tennyson",2, "Protagonista", 95 ),
("Vilgax",2,"Antagonista",98),
("Puro Hueso",3,"Secundario",80),
("Mordecai",4,"Protagonista",60),
("Rigby",4,"Protagonista",55),
("Coraje",5,"Protagonista", 40),
("Dexter",6,"Protagonista","70");

insert into episodios (idepisodio, tituloepisodio, idserie, duracionminutos, rating) values
(1,  'Isla de las lagrimas',1, 11, 6.5),
(2,  'Panico en la fiesta de pijamas',  1, 11, 7.3),
(3,  'Y luego habia 10',2, 24, 8.2),
(4,  'Caza de primas',2, 24, 7.3),
(5, 'Solo arma las sillas',3, 11, 8.6),
(6, 'El teclado magico',3, 11, 8.6),
(7, 'La maldicion del Rey Ramses',4, 11, 8.7),
(8, 'El regreso de Katz',4, 11, 8.5),
(9, 'El juguete de Dee Dee',5, 11, 7.8),
(10, 'Complicaciones cosmicas',5, 11, 7.5);

insert into habilidadesespeciales (idpersonaje, nombrehabilidad, tipohabilidad) values
(1, 'Espada Maestra', 'Combate'),
(1, 'Liderazgo', 'Social'),
(1, 'Resistencia', 'Fisica'),
(1, 'Valentia', 'Mental'),
(2, 'Estiramiento', 'Fisica'),
(2, 'Transformacion', 'Magica'),
(4, 'Omnitrix', 'Tecnologia'),
(4, 'Transformacion Alien', 'Magica'),
(4, 'Inteligencia', 'Mental'),
(4, 'Fuerza Alien', 'Fisica'),
(5, 'Super Fuerza', 'Fisica'),
(6, 'Inmortalidad', 'Magica'),
(9, 'Cobardia Util', 'Mental'),
(10, 'Genio Cientifico', 'Mental');

insert into objetosmisticos (nombreobjeto, idpersonajeDueno, valorsubasta) values
('Espada de Finn', 1, 15000),
('Anillo del Rey Helado', 3, 250000),
('Omnitrix', 4, 500000),
('Espada de Vilgax', 5, 80000),
('Hueso Magico', 6, 3000),
('Anillo de Dexter', 10, 120000),
('Espada de Mordecai', 7, 4500),
('Anillo de Rigby', 8, 6000);

##query1
select series.nombreserie as Nombreserie, series.nombrecreador as Creador
from series
order by series.nombreserie asc;

##query 2
select personajes.nombrepersonaje as Nombre, personajes.rol as Rol
from personajes 
where nombrepersonaje like 'B%' || nombrepersonaje like 'F%';

##query 3
select series.nombreserie as Serie,episodios.tituloepisodio as Titulo, episodios.duracionminutos as Duracionmin, episodios.rating as Rating
from episodios
inner join series on episodios.idserie = series.idserie
group by episodios.rating, episodios.duracionminutos
having episodios.rating > 6.5 && episodios.duracionminutos > 8; ## Cambie un poco los valores de la consigna para poder mostrar algo en la consola, ya que los valores que ingrese en los registros no se adecuaban a la consigna

##query 4
select personajes.nombrepersonaje as Duenio, objetosmisticos.nombreobjeto as Nombre
from objetosmisticos
inner join personajes on personajes.idpersonaje = objetosmisticos.idpersonajeDueno
group by objetosmisticos.nombreobjeto
having objetosmisticos.nombreobjeto like '%Espada%' || objetosmisticos.nombreobjeto like '%Anillo%';

##query 5
select min(personajes.nivelenergia) as Energiaminima, max(personajes.nivelenergia) as Energiamaxima
from personajes
where personajes.rol = 'Antagonista'; ##no logre ponerle los nombres de los personajes a los nivele de energia

##query 6
select objetosmisticos.idpersonajeDueno as IdDueno, sum(objetosmisticos.valorsubasta) as RecaudacionTotal
from objetosmisticos
where objetosmisticos.valorsubasta > 5000
group by objetosmisticos.idpersonajeDueno
order by Recaudaciontotal desc;

##query7
select episodios.idserie as IdSerie, avg(episodios.rating) as PromedioRating
from episodios
group by episodios.idserie
having avg(episodios.rating) > 7.5;

##query8
select personajes.idserie as IdSerie, count(personajes.idpersonaje) as CantidadPersonajes
from personajes
where personajes.nivelenergia > 50
group by personajes.idserie;

##query9
select avg(episodios.duracionminutos) as DuracionPromedio
from episodios
inner join series on episodios.idserie = series.idserie
where series.anioestreno > '2010-12-31'; ##comparo contra el ultimo dia del 2010 para quedarme solo con series estrenadas despues de ese anio

##query10
select habilidadesespeciales.idpersonaje as IdPersonaje, count(habilidadesespeciales.idhabilidad) as CantidadHabilidades
from habilidadesespeciales
group by habilidadesespeciales.idpersonaje
having count(habilidadesespeciales.idhabilidad) > 3;

##query12
select objetosmisticos.idpersonajeDueno as IdDueno, max(objetosmisticos.valorsubasta) as ValorMaximo
from objetosmisticos
group by objetosmisticos.idpersonajeDueno
having max(objetosmisticos.valorsubasta) > 100000;

##query13
select episodios.idserie as IdSerie, count(episodios.idepisodio) as CantidadEpisodios
from episodios
group by episodios.idserie
order by CantidadEpisodios desc; ##la consigna se corta en "ordenando" asi que asumi que es de mayor a menor cantidad de episodios, si era al reves cambias el desc por asc


