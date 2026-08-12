**Entidades extraídas del enunciado**

- **Ciudad**: ubicación geográfica, contiene gimnasios y entrenadores.
- **Gimnasio**: instalación oficial, tiene líder, pertenece a una ciudad.
- **Entrenador**: persona registrada, pertenece a una ciudad y entrena en un gimnasio.
- **Tipo**: clasificación elemental de los pokémon (Agua, Fuego, etc).
- **Pokemon**: criatura con nivel de poder, pertenece a un tipo y a un entrenador.
- **Batalla**: enfrentamiento entre dos pokémon, con fecha y ganador.

**Relaciones**
- Ciudad 1—N Gimnasio
- Ciudad 1—N Entrenador
- Gimnasio 1—N Entrenador
- Entrenador 1—N Pokemon
- Tipo 1—N Pokemon
- Pokemon N—M Batalla (participa como pokemon1 o pokemon2, y uno de ellos es ganador)**Diccionario de datos**

| Tabla | Campo | Tipo | Descripción |
|---|---|---|---|
| Ciudad | id_ciudad | INT PK | Identificador único |
| | nombre | VARCHAR(50) | Nombre de la ciudad |
| Gimnasio | id_gimnasio | INT PK | Identificador único |
| | nombre | VARCHAR(50) | Nombre del gimnasio |
| | lider | VARCHAR(50) | Líder del gimnasio |
| | id_ciudad | INT FK | Ciudad donde se ubica |
| Entrenador | id_entrenador | INT PK | Identificador único |
| | nombre | VARCHAR(50) | Nombre del entrenador |
| | id_ciudad | INT FK | Ciudad de origen |
| | id_gimnasio | INT FK | Gimnasio donde entrena |
| Tipo | id_tipo | INT PK | Identificador único |
| | nombre | VARCHAR(30) | Nombre del tipo elemental |
| Pokemon | id_pokemon | INT PK | Identificador único |
| | nombre | VARCHAR(50) | Nombre del pokémon |
| | id_tipo | INT FK | Tipo elemental |
| | nivel | INT | Nivel de poder |
| | id_entrenador | INT FK | Entrenador dueño |
| Batalla | id_batalla | INT PK | Identificador único |
| | id_pokemon1 | INT FK | Pokémon participante 1 |
| | id_pokemon2 | INT FK | Pokémon participante 2 |
| | id_ganador | INT FK | Pokémon ganador |
| | fecha | DATE | Fecha de la batalla |

**Consultas** (mismas que ya generé, sin `DELIMITER`/`PROCEDURE`):

```sql
CREATE TABLE Ciudad (
    id_ciudad INT PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE Gimnasio (
    id_gimnasio INT PRIMARY KEY,
    nombre VARCHAR(50),
    lider VARCHAR(50),
    id_ciudad INT,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad)
);

CREATE TABLE Entrenador (
    id_entrenador INT PRIMARY KEY,
    nombre VARCHAR(50),
    id_ciudad INT,
    id_gimnasio INT,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad),
    FOREIGN KEY (id_gimnasio) REFERENCES Gimnasio(id_gimnasio)
);

CREATE TABLE Tipo (
    id_tipo INT PRIMARY KEY,
    nombre VARCHAR(30)
);

CREATE TABLE Pokemon (
    id_pokemon INT PRIMARY KEY,
    nombre VARCHAR(50),
    id_tipo INT,
    nivel INT,
    id_entrenador INT,
    FOREIGN KEY (id_tipo) REFERENCES Tipo(id_tipo),
    FOREIGN KEY (id_entrenador) REFERENCES Entrenador(id_entrenador)
);

CREATE TABLE Batalla (
    id_batalla INT PRIMARY KEY,
    id_pokemon1 INT,
    id_pokemon2 INT,
    id_ganador INT,
    fecha DATE,
    FOREIGN KEY (id_pokemon1) REFERENCES Pokemon(id_pokemon),
    FOREIGN KEY (id_pokemon2) REFERENCES Pokemon(id_pokemon),
    FOREIGN KEY (id_ganador) REFERENCES Pokemon(id_pokemon)
);

SELECT e.nombre, c.nombre AS ciudad, g.nombre AS gimnasio FROM Entrenador e JOIN Ciudad c ON e.id_ciudad = c.id_ciudad JOIN Gimnasio g ON e.id_gimnasio = g.id_gimnasio;

SELECT p.nombre, t.nombre AS tipo FROM Pokemon p JOIN Tipo t ON p.id_tipo = t.id_tipo;

SELECT * FROM Pokemon WHERE nivel > 50;

SELECT p.nombre, p.nivel, e.nombre AS entrenador FROM Pokemon p JOIN Tipo t ON p.id_tipo = t.id_tipo JOIN Entrenador e ON p.id_entrenador = e.id_entrenador WHERE t.nombre = 'Fuego' ORDER BY p.nivel ASC;

SELECT * FROM Pokemon WHERE id_entrenador IN (SELECT id_entrenador FROM Entrenador WHERE id_ciudad = (SELECT id_ciudad FROM Ciudad WHERE nombre = 'Celadon'));

SELECT * FROM Pokemon WHERE nivel > (SELECT AVG(nivel) FROM Pokemon);

SELECT * FROM Pokemon WHERE id_pokemon IN (SELECT id_ganador FROM Batalla);

UPDATE Pokemon SET nivel = nivel + 5 WHERE id_entrenador = 1;

INSERT INTO Batalla (id_pokemon1, id_pokemon2, id_ganador, fecha) SELECT p1.id_pokemon, p2.id_pokemon, CASE WHEN p1.nivel >= p2.nivel THEN p1.id_pokemon ELSE p2.id_pokemon END, CURDATE() FROM Pokemon p1, Pokemon p2 WHERE p1.id_pokemon = 1 AND p2.id_pokemon = 2;
```
