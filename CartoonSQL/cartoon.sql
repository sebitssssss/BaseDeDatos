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

create table habilidadesespeciaes(
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

insert into episodios (id_episodio, titulo_episodio, id_serie, duracion_minutos, rating_audiencia) values
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

insert into habilidadesespeciales(idpersonaje,nombrehabilidad,tipohabilidad) values
(1,"Humano","Humano"),
(2,"Estiramiento", "Natural"),
(3,"Manejar el hielo","Magica"),
(4,"Omnitrix","Extraterrestre"),
(5,"Energy Projection", "Extraterrestre"),
(6,"Es un esquelto con vida","Magica")
(7,"Animal 	antropomorfico")


