USE fg;

INSERT INTO Congresos(Tematica, FechaInicio, PrecioInscripcion) 
VALUES
('Inteligencia Artificial', '2026-03-10', 15000),
('Biotecnologia Avanzada', '2026-04-22', 12000),
('Robotica Avanzada', '2026-05-15', 18000),
('Ciencia de Datos', '2026-06-08', 10000),
('Inteligencia Computacional', '2026-07-19', 20000);

INSERT INTO Expositores(Nombre, Pais, Especialidad) 
VALUES
('Lucas Fernandez', 'Chile', 'Machine Learning'),
('Ana Souza', 'Brasil', 'Bioinformatica'),
('Carlos Ruiz', 'Argentina', 'Robotica'),
('Maria Oliveira', 'Brasil', 'Analisis de Datos'),
('Pablo Moreno', 'Chile', 'Redes Neuronales');

INSERT INTO Charlas(IDCongreso, IDExpositor, TituloCharla, AsistentesEstimados, DuracionMinutos) 
VALUES
(1, 1, 'Redes Neuronales Profundas', 150, 90),
(1, 5, 'Aprendizaje por Refuerzo', 120, 75),
(1, 4, 'Modelos de Lenguaje a Gran Escala', 110, 65),
(2, 2, 'Edicion Genomica con CRISPR', 200, 45),
(3, 3, 'Automatizacion Industrial', 80, 30);