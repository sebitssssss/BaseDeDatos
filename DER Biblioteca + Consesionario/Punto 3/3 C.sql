INSERT into partidos(id_estadio, fecha)
values
("1", "26-04-2021"),
("2", "16-02-2012"),
("3", "6-01-2001"),
("4", "29-11-2000"),
("5", "31-11-1999");

INSERT into estadios(nombre, aforo)
values
("Santiago Bernabeu", "100000"),
("Camp Nou", "95000"),
("La Bombonera", "80000"),
("Más Monumental", "40000"),
("El Cilindro", "55000");

INSERT into equipos(id_estadio, nombre, anio_fundacion, ciudad_equipo)
values
("1", "Independiente", "1209", "CABA"),
("2", "Boca Juniors", "2018", "CABA"),
("3", "River Plate", "1998", "CABA"),
("4", "Barcelona", "1504", "Barcelona"),
("5", "Real Madrid", "1945", "Madrid");

INSERT into jugadores(id_equipo, nombre, fecha_nacimiento, posicion)
values
("1", "Ricardo", "25-4-2021", "Delantero"),
("2", "Juan", "15-6-2011", "Volante"),
("3", "Sebastian", "5-7-2001", "Arquero"),
("4", "Adriel", "21-9-1991", "Lateral"),
("5", "Antonio", "24-11-2000", "Defensa");

INSERT into goles(id_partido, id_jugador, gol_equipo, minuto, descripcion)
values
("1", "1", "Local", "90+1", "Gol de cabeza desde el medio de el area"),
("2", "2", "Local", "86", "Volea desde afuera de el area"),
("3", "3", "Visitante", "44", "Penal"),
("4", "4", "Visitante", "45+1", "Penal"),
("5", "5", "Visitante", "40", "Tiro libre a la escuadra derecha");

INSERT into presidentes(id_equipo, dni, nombre, apellido, fecha_nacimiento, anio_electo)
values
("1", "39098456", "Ezequiel", "Besteiro", 25-4-2021, 1897),
("2", "41768345", "Mauricio", "Rodríguez", 20-5-2026, 1987),
("3", "40213789", "Hernan", "Hernández", "10-1-2009", 2007),
("4", "33745609", "Juan", "Gimenez", "9-3-2010", 2017),
("5", "41657342", "Martín", "Gonzalez", "3-9-1999", 2024);