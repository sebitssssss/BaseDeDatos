INSERT into autores(nombre)
values
("Sebastián"),
("Juan"),
("Enrique"),
("Adriel"),
("Santiago");

INSERT into usuarios(telefono,nombre,direccion)
values
("+54 3 8157-4659", "Sebastián", "Callao 102"),
("+54 11 3132-3122", "Juan", "Cabildo 502"),
("+54 9 8765-4321", "Enrique", "Gurruchaga 605"),
("+54 1 2345-6789", "Adriel", "Acevedo 180"),
("+54 5 5863-6463", "Santiago", "Teodoro García 3899");

INSERT into libros(ISBN, editorial, pagina, titulo)
values
("978-84-12345-67-8", "Las Heras", "256", "El Principito" ),
("978-01-98765-43-2", "Leiva", "432", "Caperucita y el lobo" ),
("979-10-55443-21-0", "Mandioca", "216", "Los 3 cerditos" ),
("978-3-16-148410-0", "Dunken", "152", "El Quijote de La Mancha" ),
("978-92-3-101010-0", "Santillana", "144", "Black Nights" );

INSERT into ejemplares(id_libro, localizacion)
values
("1", "Biblioteca 1, Sección 2"),
("2", "Biblioteca 1, Sección 1"),
("3", "Biblioteca 2, Sección 1"),
("4", "Biblioteca 2, Sección 2"),
("5", "Biblioteca 2, Sección 3");

INSERT into prestamos(id_usuario, id_ejemplar, fecha_de_devolucion, fecha_de_entrega)
values
("1", "1", 26-4-2026, 11-5-2026),
("1", "1", 30-4-2026, 20-1-2020),
("1", "1", 26-6-2004, 3-7-2022),
("1", "1", 55-5-2025, 2-1-2010),
("1", "1", 18-7-2009, 1-6-2013);

INSERT into usuarios_ejemplares(id_usuario, id_ejemplar)
values
("1", "1"),
("2", "2"),
("3", "3"),
("4", "4"),
("5", "5");

INSERT into autores_libros(id_autor, id_libro)
values
("1", "1"),
("2", "2"),
("3", "3"),
("4", "4"),
("5", "5")
