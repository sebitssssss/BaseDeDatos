DROP DATABASE IF EXISTS bjhnm;
CREATE DATABASE bjhnm;
USE bjhnm;

CREATE TABLE Directores(
    IDDirector INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    NombreDirector VARCHAR(50),
    EdadDirector INT(3),
    SueldoDirector INT(8)
);

CREATE TABLE Series(
    IDSerie INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Genero VARCHAR(20),
    AnioLanzamiento INT(4),
    Presupuesto INT(10),
    Plataforma VARCHAR(20),
    IDDirector INT, FOREIGN KEY (IDDirector) REFERENCES Directores(IDDirector)
);

CREATE TABLE Temporadas(
    IDTemporada INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    NumeroTemporada INT,
    NombreTemporada VARCHAR(50),
    DescripcionTemporada VARCHAR(250),
    IDSerie INT, FOREIGN KEY (IDSerie) REFERENCES Series(IDSerie)
);

CREATE TABLE Episodios(
    IDEpisodio INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    NumeroEpisodio INT,
    NombreEpisodio VARCHAR(20),
    DescripcionEpisodio VARCHAR(250),
    Puntuacion INT(3),
    IDTemporada INT, FOREIGN KEY (IDTemporada) REFERENCES Temporadas(IDTemporada)
);

CREATE TABLE Personajes(
    IDPersonaje INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Edad INT(3),
    Genero VARCHAR(10),
    IDSerie INT, FOREIGN KEY (IDSerie) REFERENCES Series(IDSerie)
);