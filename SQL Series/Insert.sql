INSERT INTO Directores(IDDirector, NombreDirector, EdadDirector, SueldoDirector) VALUES
(1, 'Duffer Brothers', 40, 500000),
(2, 'Christopher Storer', 43, 350000),
(3, 'Craig Mazin', 53, 900000),
(4, 'Mark Mylod', 59, 750000),
(5, 'Eric Kripke', 50, 400000),
(6, 'Charlie Brooker', 53, 300000),
(7, 'Declan Lowney', 63, 450000),
(8, 'Ben Stiller', 58, 800000),
(9, 'Jonathan Nolan', 47, 1200000),
(10, 'Baran bo Odar', 46, 280000);

INSERT INTO Series(IDSerie, Nombre, Genero, AnioLanzamiento, Presupuesto, Plataforma, IDDirector) VALUES
(1, 'Stranger Things', 'Sci-Fi', 2016, 30000000, 'Netflix', 1),
(2, 'The Bear', 'Drama', 2022, 12000000, 'Disney+', 2),
(3, 'The Last of Us', 'Post-apoc', 2023, 100000000, 'Max', 3),
(4, 'Succession', 'Drama', 2018, 90000000, 'Max', 4),
(5, 'The Boys', 'Acción', 2019, 11000000, 'Prime Video', 5),
(6, 'Black Mirror', 'Antología', 2011, 5000000, 'Netflix', 6),
(7, 'Ted Lasso', 'Comedia', 2020, 15000000, 'Apple TV', 7),
(8, 'Severance', 'Suspenso', 2022, 40000000, 'Apple TV', 8),
(9, 'Fallout', 'Sci-Fi', 2024, 15000000, 'Prime Video', 9),
(10, 'Dark', 'Intriga', 2017, 18000000, 'Netflix', 10);

INSERT INTO Temporadas(IDTemporada, NumeroTemporada, NombreTemporada, DescripcionTemporada, IDSerie) VALUES
(NULL, 1, 'Stranger Things 1', 'Desaparición de Will', 1),
(NULL, 4, 'Stranger Things 4', 'El regreso de Vecna', 1),
(NULL, 1, 'The Bear S1', 'El caos en la cocina', 2),
(NULL, 1, 'The Last of Us S1', 'El viaje de Joel y Ellie', 3),
(NULL, 4, 'Succession S4', 'La guerra final', 4),
(NULL, 1, 'The Boys S1', 'Los héroes son malos', 5),
(NULL, 1, 'Black Mirror S1', 'Tecnología y pesadillas', 6),
(NULL, 1, 'Ted Lasso S1', 'Un DT de fútbol americano en UK', 7),
(NULL, 1, 'Severance S1', 'Separación cerebral laboral', 8),
(NULL, 1, 'Fallout S1', 'Salida del refugio 33', 9);

INSERT INTO Personajes(IDPersonaje, Nombre, Edad, Genero, IDSerie) VALUES
(1, 'Eleven', 14, 'Femenino', 1),
(2, 'Carmy Berzatto', 28, 'Masculino', 2),
(3, 'Joel Miller', 52, 'Masculino', 3),
(4, 'Ellie Williams', 14, 'Femenino', 3),
(5, 'Kendall Roy', 40, 'Masculino', 4),
(6, 'Homelander', 38, 'Masculino', 5),
(7, 'Ted Lasso', 45, 'Masculino', 7),
(8, 'Mark Scout', 42, 'Masculino', 8),
(9, 'Lucy MacLean', 22, 'Femenino', 9),
(10, 'Jonas Kahnwald', 17, 'Masculino', 10);

INSERT INTO Episodios(IDEpisodio, NumeroEpisodio, NombreEpisodio, DescripcionEpisodio, Puntuacion, IDTemporada) VALUES
(1, 101, 'El mundo del revés', 'El inicio de todo', 9.2, 1),
(2, 102, 'Dear Billy', 'El escape de Max', 9.8, 2),
(3, 103, 'Sistema', 'El servicio más intenso', 9.5, 3),
(4, 104, 'Mucho tiempo', 'La historia de Bill y Frank', 9.9, 4),
(5, 105, 'Connor''s Wedding', 'Un giro inesperado', 10.0, 5),
(6, 106, 'El nombre del juego', 'Hughie se une a los Boys', 8.8, 6),
(7, 107, 'Himno Nacional', 'El episodio del primer ministro', 8.1, 7),
(8, 108, 'Piloto', 'Ted llega a Richmond', 8.5, 8),
(9, 109, 'Lo que somos', 'El final de temporada', 9.7, 9),
(10, 110, 'El fin', 'Descubrimientos en el yermo', 9.4, 10);