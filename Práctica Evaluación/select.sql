SELECT Nombre, Creador FROM Series ORDER BY Nombre ASC;

SELECT Nombre, Rol FROM Personajes WHERE Nombre LIKE 'B%' OR Nombre LIKE 'F%';

SELECT * FROM Episodios WHERE DuracionMinutos > 11 AND Rating > 8.5;

SELECT * FROM Objetos WHERE Nombre LIKE '%Espada%' OR Nombre LIKE '%Anillo%';

SELECT MIN(NivelEnergia) AS EnergiaMinima, MAX(NivelEnergia) AS EnergiaMaxima FROM Personajes WHERE Rol = 'Antagonista';

SELECT Tipo, COUNT(*) AS CantidadHabilidades FROM Habilidades GROUP BY Tipo;

SELECT Nombre, NivelEnergia FROM Personajes ORDER BY NivelEnergia DESC, Nombre ASC;

SELECT IDPersonajeDuenio, SUM(ValorSubasta) AS TotalRecaudado FROM Objetos WHERE ValorSubasta > 5000 GROUP BY IDPersonajeDuenio ORDER BY TotalRecaudado DESC;

SELECT IDSerie, AVG(Rating) AS PromedioRating FROM Episodios GROUP BY IDSerie HAVING AVG(Rating) > 7.5;

SELECT IDSerie, COUNT(*) AS CantidadPersonajes FROM Personajes WHERE NivelEnergia > 50 GROUP BY IDSerie;

SELECT AVG(Episodios.DuracionMinutos) AS DuracionPromedio FROM Episodios INNER JOIN Series ON Episodios.IDSerie = Series.IDSerie WHERE Series.AnioEstreno > 2010;

SELECT IDPersonaje, COUNT(*) AS CantidadHabilidades FROM Habilidades GROUP BY IDPersonaje HAVING COUNT(*) > 3;

SELECT * FROM Enemigos WHERE EncuentrosTotales > 15 ORDER BY EncuentrosTotales DESC;

SELECT IDPersonajeDuenio, MAX(ValorSubasta) AS ValorMaximo FROM Objetos GROUP BY IDPersonajeDuenio HAVING MAX(ValorSubasta) > 100000;

SELECT IDSerie, COUNT(*) AS CantidadEpisodios FROM Episodios GROUP BY IDSerie ORDER BY CantidadEpisodios DESC;