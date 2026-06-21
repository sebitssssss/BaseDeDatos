INSERT INTO Series (Nombre, AnioEstreno, Creador) 
VALUES
('Hora de Aventura', 2010, 'Pendleton Ward'),
('Ben 10', 2016, 'Man of Action'),
('Billy y Mandy', 2001, 'Maxwell Atoms'),
('Un Show Más', 2010, 'J.G. Quintel'),
('Coraje el Perro Cobarde', 1999, 'John R. Dilworth'),
('El laboratorio de Dexter', 1996, 'Genndy Tartakovsky');

INSERT INTO Personajes (Nombre, NivelEnergia, Rol, IDSerie) 
VALUES
('Finn el Humano', 85, 'Protagonista', 1),
('Jake el Perro', 90, 'Protagonista', 1),
('Rey Helado', 75, 'Antagonista', 1),
('Ben Tennyson', 95, 'Protagonista', 2),
('Vilgax', 98, 'Antagonista', 2),
('Puro Hueso', 80, 'Secundario', 3),
('Mordecai', 60, 'Protagonista', 4),
('Rigby', 55, 'Protagonista', 4),
('Coraje', 40, 'Protagonista', 5),
('Dexter', 70, 'Protagonista', 6);

INSERT INTO Episodios (Titulo, Rating, DuracionMinutos, IDSerie) 
VALUES
('El Enemigo Volvió', 9.2, 11, 1),
('La Princesa Chiclosa', 8.7, 12, 1),
('Tiempos de Hielo', 8.0, 10, 1),
('El Origen del Omnitrix', 9.0, 22, 2),
('El Ataque de Vilgax', 8.9, 23, 2),
('Cuarenta Alienígenas', 7.5, 21, 2),
('El Reino de los Huesos', 7.8, 11, 3),
('La Venganza de Puro Hueso', 8.6, 12, 3),
('El Día Libre', 7.0, 11, 4),
('La Apuesta Final', 7.9, 12, 4),
('El Pantano del Miedo', 8.9, 11, 5),
('La Casa Embrujada', 9.1, 12, 5),
('El Gran Invento', 8.8, 11, 6),
('Dee Dee al Rescate', 7.2, 10, 6);

INSERT INTO Habilidades (Nombre, Tipo, IDPersonaje) 
VALUES
('Manejo de Espada', 'Combate', 1),
('Liderazgo', 'Mental', 1),
('Elasticidad', 'Físico', 2),
('Cambio de Forma', 'Físico', 2),
('Control de Hielo', 'Elemental', 3),
('Vuelo', 'Físico', 3),
('Transformación Alienígena', 'Transformación', 4),
('Super Fuerza', 'Físico', 4),
('Vuelo', 'Físico', 4),
('Control del Omnitrix', 'Tecnológico', 4),
('Super Fuerza', 'Físico', 5),
('Regeneración', 'Biológico', 5),
('Manejo de Armas', 'Combate', 5),
('Magia Oscura', 'Mágico', 6),
('Improvisación', 'Mental', 7),
('Velocidad', 'Físico', 8),
('Percepción Extrasensorial', 'Mental', 9),
('Genio Científico', 'Mental', 10),
('Invención Rápida', 'Tecnológico', 10);

INSERT INTO Enemigos (EncuentrosTotales, IDHeroe, IDVillano) 
VALUES
(25, 1, 3),
(10, 2, 3),
(40, 4, 5),
(18, 7, 5),
(5, 9, 3);

INSERT INTO Objetos (Nombre, ValorSubasta, IDPersonajeDuenio) 
VALUES
('Espada de la Justicia', 12000, 1),
('Mochila de Cuero', 500, 1),
('Collar Mágico', 3000, 2),
('Corona de Hielo', 150000, 3),
('Anillo de Invierno Eterno', 200000, 3),
('Omnitrix', 999999, 4),
('Espada de Vilgax', 80000, 5),
('Anillo de Hueso Maldito', 45000, 6),
('Llave Maestra del Laboratorio', 7000, 10),
('Manta de la Suerte', 1200, 9);