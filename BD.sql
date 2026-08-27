DROP TABLE IF EXISTS AchievementLogs;
DROP TABLE IF EXISTS Leaderboard;
DROP TABLE IF EXISTS SessionStats;
DROP TABLE IF EXISTS FeedbackRules;
DROP TABLE IF EXISTS Attempts;
DROP TABLE IF EXISTS Sessions;
DROP TABLE IF EXISTS CodeConfigs;
DROP TABLE IF EXISTS Players;

CREATE DATABASE IF NOT EXISTS codigo_secreto_db;
USE codigo_secreto_db;

CREATE TABLE Players (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre_usuario VARCHAR(25) NOT NULL UNIQUE,
email VARCHAR(50) NOT NULL UNIQUE,
password_hash VARCHAR(50) NOT NULL,
fecha_registro DATE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE CodeConfigs (
id INT AUTO_INCREMENT PRIMARY KEY,
longitud INT NOT NULL CHECK (longitud BETWEEN 2 AND 10),
colores_disponibles VARCHAR(255) NOT NULL,
permitir_repeticiones BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE Sessions (
id INT AUTO_INCREMENT PRIMARY KEY,
player_id INT NOT NULL,
config_id INT NOT NULL,
fecha_inicio DATETIME NOT NULL,
fecha_fin DATETIME NULL,
dificultad enum("Facil", "Medio", "Dificil") NOT NULL,
codigo_secreto VARCHAR(50) NOT NULL,
resultado enum("en_curso", "victoria", "derrota") NOT NULL DEFAULT "en_curso",
FOREIGN KEY (player_id) REFERENCES Players(id),
FOREIGN KEY (config_id) REFERENCES CodeConfigs(id)
);

CREATE TABLE Attempts (
id INT AUTO_INCREMENT PRIMARY KEY,
session_id INT NOT NULL,
intento_num INT NOT NULL CHECK (intento_num > 0),
fecha_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
combinacion_intentada VARCHAR(50) NOT NULL,
aciertos_posicion INT NOT NULL DEFAULT 0,
aciertos_color INT NOT NULL DEFAULT 0,
FOREIGN KEY (session_id) REFERENCES Sessions(id),
UNIQUE (session_id, intento_num)
);

CREATE TABLE FeedbackRules (
id INT AUTO_INCREMENT PRIMARY KEY,
tipo_feedback VARCHAR(30) NOT NULL UNIQUE,
valor_puntos INT NOT NULL
);

CREATE TABLE SessionStats (
id INT AUTO_INCREMENT PRIMARY KEY,
session_id INT NOT NULL UNIQUE,
intentos_totales INT NOT NULL DEFAULT 0,
tiempo_total INT NULL,
eficiencia DECIMAL(5,2) NULL,
FOREIGN KEY (session_id) REFERENCES Sessions(id)
);

CREATE TABLE Leaderboard (
id INT AUTO_INCREMENT PRIMARY KEY,
session_id INT NOT NULL UNIQUE,
puntaje INT NOT NULL DEFAULT 0,
intentos_mejor INT NOT NULL,
FOREIGN KEY (session_id) REFERENCES Sessions(id)
);

CREATE TABLE AchievementLogs (
id INT AUTO_INCREMENT PRIMARY KEY,
session_id INT NOT NULL,
tipo_logro VARCHAR(60) NOT NULL,
fecha_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (session_id) REFERENCES Sessions(id)
);

INSERT INTO Players (nombre_usuario, email, password_hash) VALUES
('ana_gamer', 'ana@example.com', 'hash_ana_123'),
('carlos_dev', 'carlos@example.com', 'hash_carlos_456');

INSERT INTO CodeConfigs (longitud, colores_disponibles, permitir_repeticiones) VALUES
(4, 'Rojo,Azul,Verde,Amarillo', FALSE),
(4, 'Rojo,Azul,Verde,Amarillo,Naranja,Morado', TRUE);

INSERT INTO Sessions (
player_id,
config_id,
fecha_inicio,
fecha_fin,
dificultad,
codigo_secreto,
resultado
) VALUES
(1, 1, '2026-08-20 10:00:00', '2026-08-20 10:05:00', 'Facil', 'Azul,Amarillo,Rojo,Verde', 'victoria'),
(2, 2, '2026-08-21 18:30:00', NULL, 'Dificil', 'Naranja,Morado,Rojo,Azul', 'en_curso');

INSERT INTO Attempts (
session_id,
intento_num,
fecha_hora,
combinacion_intentada,
aciertos_posicion,
aciertos_color
) VALUES
(1, 1, '2026-08-20 10:01:00', 'Rojo,Azul,Verde,Amarillo', 0, 4),
(1, 2, '2026-08-20 10:03:00', 'Azul,Rojo,Amarillo,Verde', 2, 2),
(1, 3, '2026-08-20 10:05:00', 'Azul,Amarillo,Rojo,Verde', 4, 0);

INSERT INTO FeedbackRules (tipo_feedback, valor_puntos) VALUES
('acierto_posicion', 10),
('acierto_color', 5),
('intento_fallido', -1);

INSERT INTO SessionStats (
session_id,
intentos_totales,
tiempo_total,
eficiencia
) VALUES
(1, 3, 300, 50.00);

INSERT INTO Leaderboard (
session_id,
puntaje,
intentos_mejor
) VALUES
(1, 90, 3);

INSERT INTO AchievementLogs (
session_id,
tipo_logro,
fecha_hora
) VALUES
(1, 'Primera Victoria', '2026-08-20 10:05:00'),
(1, 'Ojo de Aguila', '2026-08-20 10:05:00');

-- Leaderboard
SELECT
s.dificultad,
p.nombre_usuario,
l.puntaje,
l.intentos_mejor,
RANK() OVER (PARTITION BY s.dificultad ORDER BY l.puntaje DESC, l.intentos_mejor ASC) AS posicion
FROM Leaderboard l
JOIN Sessions s ON s.id = l.session_id
JOIN Players p ON p.id = s.player_id
ORDER BY s.dificultad, posicion;

-- Jugadores con mas victorias
SELECT
p.nombre_usuario,
COUNT(*) AS victorias
FROM Sessions s
JOIN Players p ON p.id = s.player_id
WHERE s.resultado = 'victoria'
GROUP BY p.id, p.nombre_usuario
ORDER BY victorias DESC;

-- Tiempo promedio por dificultad
SELECT
s.dificultad,
COUNT(ss.id) AS partidas_terminadas,
ROUND(AVG(ss.eficiencia), 2) AS eficiencia_promedio,
ROUND(AVG(ss.tiempo_total), 0) AS tiempo_promedio_segundos
FROM SessionStats ss
JOIN Sessions s ON s.id = ss.session_id
GROUP BY s.dificultad
ORDER BY s.dificultad;

-- Repetición de los intentos de una partida
SELECT
a.intento_num,
a.combinacion_intentada,
a.aciertos_posicion,
a.aciertos_color,
a.fecha_hora
FROM Attempts a
WHERE a.session_id = 1
ORDER BY a.intento_num;

-- Logros desbloqueados por jugador
SELECT
p.nombre_usuario,
al.tipo_logro,
al.fecha_hora
FROM AchievementLogs al
JOIN Sessions s ON s.id = al.session_id
JOIN Players p ON p.id = s.player_id
ORDER BY p.nombre_usuario, al.fecha_hora;
