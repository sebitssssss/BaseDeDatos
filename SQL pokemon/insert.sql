use liga_pokemon;

insert into ciu (idciu, nombre, region) values
(1, 'Celadon', 'Kanto'),
(2, 'Pewter', 'Kanto'),
(3, 'Cerulean', 'Kanto'),
(4, 'Vermilion', 'Kanto'),
(5, 'Fuchsia', 'Kanto');

insert into lid (idlid, nombre, apellido) values
(1, 'Erika', 'Hanada'),
(2, 'Brock', 'Harrison'),
(3, 'Misty', 'Waterflower'),
(4, 'Surge', 'Matisse'),
(5, 'Koga', 'Yamabuki');

insert into gim (idgim, nombre, idciu, idlid) values
(1, 'Gimnasio Celadon', 1, 1),
(2, 'Gimnasio Pewter', 2, 2),
(3, 'Gimnasio Cerulean', 3, 3),
(4, 'Gimnasio Vermilion', 4, 4),
(5, 'Gimnasio Fuchsia', 5, 5);

insert into ent (ident, nombre, apellido, fecha_nac, idciu, idgim) values
(1, 'Ash', 'Ketchum', '1996-05-22', 1, 1),
(2, 'Gary', 'Oak', '1996-04-01', 1, 1),
(3, 'Ritchie', 'Bolt', '1997-01-15', 3, 3),
(4, 'Serena', 'Yvonne', '1998-09-30', 4, 4),
(5, 'Clemont', 'Meyer', '1995-11-08', 2, 2),
(6, 'Daisy', 'Green', '1994-02-17', 1, 1),
(7, 'Tracey', 'Sketchit', '1993-07-04', 5, 5);

insert into tip (idtip, nombre) values
(1, 'Agua'),
(2, 'Fuego'),
(3, 'Planta'),
(4, 'Electrico'),
(5, 'Roca'),
(6, 'Veneno');

insert into pok (idpok, nombre, nivel, idtip, ident) values
(1, 'Charizard', 78, 2, 1),
(2, 'Pikachu', 65, 4, 1),
(3, 'Bulbasaur', 32, 3, 1),
(4, 'Blastoise', 70, 1, 2),
(5, 'Arcanine', 55, 2, 2),
(6, 'Vileplume', 48, 3, 6),
(7, 'Onix', 44, 5, 5),
(8, 'Geodude', 25, 5, 5),
(9, 'Starmie', 58, 1, 3),
(10, 'Charmander', 15, 2, 3),
(11, 'Raichu', 62, 4, 4),
(12, 'Vulpix', 28, 2, 4),
(13, 'Weezing', 51, 6, 7),
(14, 'Golbat', 39, 6, 7),
(15, 'Magmar', 46, 2, 6),
(16, 'Squirtle', 12, 1, 5);

insert into bat (idbat, fecha, idpok1, idpok2, idganador) values
(1, '2024-03-05', 1, 4, 1),
(2, '2024-03-12', 2, 11, 11),
(3, '2024-04-02', 9, 5, 9),
(4, '2024-04-18', 7, 3, 7),
(5, '2024-05-09', 13, 6, 13),
(6, '2024-05-21', 1, 9, 1),
(7, '2024-06-03', 11, 2, 2),
(8, '2024-06-15', 15, 14, 15);
