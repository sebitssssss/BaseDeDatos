drop database if exists fg;
create database fg;
use fg;
create table Series(
	IDSerie int primary key auto_increment not null,
    Nombre varchar(40),
    AnioEstreno int,
    Creador varchar(30)
);
create table Personajes(
	IDPersonaje int primary key auto_increment not null,
    Nombre varchar(30),
    NivelEnergia int,
    Rol enum("Protagonista", "Antagonista", "Secundario"),
    IDSerie int not null,
    foreign key (IDSerie) references Series(IDSerie)
);
create table Episodios(
	IDEpisodio int primary key auto_increment not null,
    Titulo varchar(50),
    Rating int (3),
    DuracionMinutos int,
    IDSerie int not null,
    foreign key (IDSerie) references Series(IDSerie)
);
create table Habilidades(
	IDHabilidad int primary key auto_increment not null,
    Nombre varchar(40),
    Tipo varchar(20),
    IDPersonaje int not null,
    foreign key (IDPersonaje) references Personajes(IDPersonaje)
);
create table Enemigos(
	IDRivalidad int primary key auto_increment not null,
    EncuentrosTotales int,
    IDHeroe int not null,
    IDVillano int not null,
    foreign key (IDHeroe) references Personajes(IDPersonaje),
    foreign key (IDVillano) references Personajes(IDPersonaje)
);
create table Objetos(
	IDObjeto int primary key auto_increment not null,
    Nombre varchar(50),
    ValorSubasta int,
    IDPersonajeDuenio int not null,
    foreign key (IDPersonajeDuenio) references Personajes(IDPersonaje)
);