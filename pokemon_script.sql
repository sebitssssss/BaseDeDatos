CREATE DATABASE IF NOT EXISTS liga_pokemon;
USE liga_pokemon;

CREATE TABLE ciudad (
    idciudad INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE entrenador (
    identrenador INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    idciudad INT NOT NULL,
    idgimnasio INT,
    FOREIGN KEY (idciudad) REFERENCES ciudad(idciudad)
);

CREATE TABLE gimnasio (
    idgimnasio INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    idciudad INT NOT NULL,
    idlider INT,
    FOREIGN KEY (idciudad) REFERENCES ciudad(idciudad),
    FOREIGN KEY (idlider) REFERENCES entrenador(identrenador)
);

ALTER TABLE entrenador
    ADD FOREIGN KEY (idgimnasio) REFERENCES gimnasio(idgimnasio);

CREATE TABLE tipo (
    idtipo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL
);

CREATE TABLE pokemon (
    idpokemon INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    nivel INT NOT NULL,
    idtipo INT NOT NULL,
    identrenador INT NOT NULL,
    FOREIGN KEY (idtipo) REFERENCES tipo(idtipo),
    FOREIGN KEY (identrenador) REFERENCES entrenador(identrenador)
);

CREATE TABLE batalla (
    idbatalla INT PRIMARY KEY AUTO_INCREMENT,
    idpokemon1 INT NOT NULL,
    idpokemon2 INT NOT NULL,
    idganador INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (idpokemon1) REFERENCES pokemon(idpokemon),
    FOREIGN KEY (idpokemon2) REFERENCES pokemon(idpokemon),
    FOREIGN KEY (idganador) REFERENCES pokemon(idpokemon)
);

INSERT INTO ciudad (nombre) VALUES
('Celadon'), ('Pewter'), ('Cerulean');

INSERT INTO entrenador (nombre, idciudad, idgimnasio) VALUES
('Ash', 1, NULL),
('Misty', 3, NULL),
('Brock', 2, NULL),
('Erika', 1, NULL);

INSERT INTO gimnasio (nombre, idciudad, idlider) VALUES
('Gimnasio Celadon', 1, 4),
('Gimnasio Pewter', 2, 3),
('Gimnasio Cerulean', 3, 2);

UPDATE entrenador SET idgimnasio = 1 WHERE identrenador = 1;
UPDATE entrenador SET idgimnasio = 3 WHERE identrenador = 2;
UPDATE entrenador SET idgimnasio = 2 WHERE identrenador = 3;
UPDATE entrenador SET idgimnasio = 1 WHERE identrenador = 4;

INSERT INTO tipo (nombre) VALUES
('Fuego'), ('Agua'), ('Planta'), ('Eléctrico'), ('Roca');

INSERT INTO pokemon (nombre, nivel, idtipo, identrenador) VALUES
('Charizard', 55, 1, 1),
('Growlithe', 30, 1, 1),
('Squirtle', 45, 2, 2),
('Staryu', 60, 2, 2),
('Onix', 40, 5, 3),
('Geodude', 20, 5, 3),
('Bellsprout', 65, 3, 4),
('Oddish', 25, 3, 4);

INSERT INTO batalla (idpokemon1, idpokemon2, idganador, fecha) VALUES
(1, 3, 1, '2026-01-10'),
(4, 5, 4, '2026-02-15'),
(7, 6, 7, '2026-03-01');

-- i. Entrenadores con su ciudad y gimnasio
SELECT entrenador.nombre, ciudad.nombre, gimnasio.nombre
FROM entrenador
INNER JOIN ciudad ON entrenador.idciudad = ciudad.idciudad
INNER JOIN gimnasio ON entrenador.idgimnasio = gimnasio.idgimnasio;

-- ii. Pokémon y su tipo
SELECT pokemon.nombre, tipo.nombre
FROM pokemon
INNER JOIN tipo ON pokemon.idtipo = tipo.idtipo;

-- iii. Pokémon con nivel superior a 50
SELECT *
FROM pokemon
WHERE nivel > 50;

-- iv. Pokémon de tipo Fuego, ordenados por poder de menor a mayor, con su entrenador
SELECT pokemon.nombre, pokemon.nivel, entrenador.nombre
FROM pokemon
INNER JOIN tipo ON pokemon.idtipo = tipo.idtipo
INNER JOIN entrenador ON pokemon.identrenador = entrenador.identrenador
WHERE tipo.nombre = 'Fuego'
ORDER BY pokemon.nivel ASC;

-- v. Pokémon de entrenadores de la ciudad Celadon (subconsulta)
SELECT *
FROM pokemon
WHERE identrenador IN (
    SELECT entrenador.identrenador
    FROM entrenador
    INNER JOIN ciudad ON entrenador.idciudad = ciudad.idciudad
    WHERE ciudad.nombre = 'Celadon'
);

-- vi. Pokémon con nivel superior al promedio general (subconsulta escalar)
SELECT *
FROM pokemon
WHERE nivel > (SELECT AVG(nivel) FROM pokemon);

-- vii. Pokémon que ganaron al menos una batalla (subconsulta)
SELECT DISTINCT pokemon.*
FROM pokemon
WHERE pokemon.idpokemon IN (
    SELECT idganador FROM batalla
);

-- viii. Procedimiento: subir de nivel todos los pokémon de un entrenador
DELIMITER $$
CREATE PROCEDURE subir_nivel_entrenador(
    IN p_identrenador INT,
    IN p_incremento INT
)
BEGIN
    UPDATE pokemon
    SET nivel = nivel + p_incremento
    WHERE identrenador = p_identrenador;
END $$
DELIMITER ;

CALL subir_nivel_entrenador(1, 5);

-- ix. Procedimiento: registrar una batalla y guardar el ganador automáticamente
DELIMITER $$
CREATE PROCEDURE registrar_batalla(
    IN p_idpokemon1 INT,
    IN p_idpokemon2 INT,
    IN p_fecha DATE
)
BEGIN
    DECLARE v_nivel1 INT;
    DECLARE v_nivel2 INT;
    DECLARE v_ganador INT;

    SELECT nivel INTO v_nivel1 FROM pokemon WHERE idpokemon = p_idpokemon1;
    SELECT nivel INTO v_nivel2 FROM pokemon WHERE idpokemon = p_idpokemon2;

    IF v_nivel1 >= v_nivel2 THEN
        SET v_ganador = p_idpokemon1;
    ELSE
        SET v_ganador = p_idpokemon2;
    END IF;

    INSERT INTO batalla (idpokemon1, idpokemon2, idganador, fecha)
    VALUES (p_idpokemon1, p_idpokemon2, v_ganador, p_fecha);
END $$
DELIMITER ;

CALL registrar_batalla(2, 6, CURDATE());
