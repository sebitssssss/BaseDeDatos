SELECT Genero, Nombre FROM Personajes ORDER BY Genero, Nombre;

SELECT DISTINCT Directores.IDDirector, Directores.NombreDirector FROM Directores JOIN Series ON Directores.IDDirector = Series.IDDirector WHERE Series.Plataforma = 'Amazon';

SELECT * FROM Personajes JOIN Series ON Series.IDSerie = Personajes.IDSerie WHERE Series.Nombre = 'Disney' ORDER BY Personajes.Edad DESC;

SELECT Series.IDSerie, Series.Nombre, COUNT(Temporadas.IDTemporada) AS CantidadTemporadas FROM Series JOIN Temporadas ON Series.IDSerie = Temporadas.IDSerie GROUP BY Series.IDSerie, Series.Nombre ORDER BY CantidadTemporadas DESC LIMIT 1;

SELECT * FROM Personajes JOIN Series ON Series.IDSerie = Personajes.IDSerie WHERE Series.Nombre = 'Hora de Aventura';

SELECT * FROM Series WHERE Presupuesto = (SELECT MAX(Presupuesto) FROM Series);

SELECT * FROM Series JOIN Temporadas ON Series.IDSerie = Temporadas.IDSerie JOIN Episodios ON Temporadas.IDTemporada = Episodios.IDTemporada WHERE Series.AnioLanzamiento <= 2020 AND Episodios.Puntuacion = (SELECT MAX(E2.Puntuacion) FROM Series AS S2 JOIN Temporadas AS T2 ON S2.IDSerie = T2.IDSerie JOIN Episodios AS E2 ON T2.IDTemporada = E2.IDTemporada WHERE S2.AnioLanzamiento <= 2020);