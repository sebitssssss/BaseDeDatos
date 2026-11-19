# Code Breaker

Juego de escritorio de lógica y deducción, estilo Mastermind, hecho para el proyecto interdisciplinario de 4.º año (Algoritmos y Estructuras de Datos + Base de Datos).

Al empezar, el juego genera un **código secreto de 4 colores** al azar entre 6 posibles (se pueden repetir).
El jugador arma combinaciones moviendo un selector y recibe pistas después de cada intento. Cada intento que no acierta **cuesta 1 vida** (hay 8).
Gana al descifrar el código y pierde (**Game Over**) al quedarse sin vidas.

## Stack

| Parte | Tecnología |
|---|---|
| Lenguaje | C# sobre .NET 8 (corre también con versiones más nuevas: `RollForward=Major`) |
| Motor | MonoGame 3.8.4.1, plataforma DesktopGL |
| Base de datos | MySQL, solo con la librería **MySqlConnector 2.6.2** |
| Estructura manual | Cola circular sobre array (`Logic/CircularQueue.cs`) |
| Algoritmo manual | Ordenamiento por burbuja (`Logic/BubbleSorter.cs`) |
| Persistencia local | `config.conf` (texto) y `puntajes.dat` (binario) |
| Gráficos | 9 PNG en `src/Content/Sprites/`: 6 fichas y 3 aros, del pack Input Prompts de Kenney.nl con ediciones mínimas de color. También acepta spritesheets PNG + XML. Ver `assets/README.md` |

**No se usa:** `List<>`, `Stack<>`, `Queue<>`, `Dictionary<>` ni ninguna otra colección de .NET; tampoco LINQ, `Array.Sort`, recursividad ni texturas generadas por código.

## Equivalencia de las mecánicas del MVP

El MVP está pensado para juegos de acción. En Code Breaker cada mecánica se cumple así:

| Mecánica del MVP | En Code Breaker | Dónde está |
|---|---|---|
| Movimiento del personaje | Un **selector** (cursor con sprite) que se mueve con las flechas: Izquierda/Derecha entre las posiciones del intento, Arriba/Abajo por la paleta. Espacio pone la ficha, Enter confirma y Retroceso borra la última. | `Screens/PlayingScreen.cs` |
| Generación de elementos/obstáculos | Generación **aleatoria del código secreto** al comenzar cada partida. | `Logic/CodeGenerator.cs` |
| Sistema de vidas | Cada intento que no acierta **resta 1 vida** (8 por defecto). | `Logic/GameSession.cs` |
| Puntaje | Al ganar: `vidasRestantes × 100 + max(0, 300 − segundos)`. Al perder: 0. | `Logic/ScoreService.cs` |
| Pantalla de Game Over | Al quedarse sin vidas muestra el código secreto, el resultado, el puntaje y la repetición de la partida. | `Screens/GameOverScreen.cs` |

## Controles

| Pantalla | Teclas |
|---|---|
| Menú | Escribir el nombre (hasta 12 letras) · Delete (o Retroceso) borra una letra · Arriba/Abajo elige · Enter acepta · F5 reintenta MySQL (no figura en pantalla) |
| Juego | Izquierda/Derecha: posición · Arriba/Abajo: color · **Espacio: poner ficha** · Retroceso: borrar la última · Enter: confirmar · Esc: volver al menú |
| Game Over | Arriba/Abajo elige "Volver a jugar" o "Menú" · Enter acepta |
| Ranking | Enter o Esc vuelven al menú |

El mouse no se usa: es opcional en el MVP.

## Reglas

Después de cada intento, cada ficha del historial queda rodeada por un aro de color:

- **Aro verde:** color correcto en la posición correcta.
- **Aro amarillo:** el color está en el código, pero en otra posición.
- **Aro rojo:** el color no está en el código, o ya se contaron todas las veces que aparece.

Ningún color se cuenta dos veces (`Logic/FeedbackEvaluator.cs`):

1. Primero se marcan los verdes.
2. Después, de izquierda a derecha, cada ficha toma como amarillo un color del código que todavía no se usó. Si no queda ninguno de ese color, queda en rojo.

Por ejemplo, si el código es Rojo Azul Verde Verde y el intento es Verde Verde Verde Rojo, el resultado es amarillo, rojo, verde, amarillo.

> **Cambio respecto de la consigna:** la consigna pedía pines negros y blancos "sin revelar qué posición es la correcta". Este juego muestra con un aro el resultado de cada ficha, al estilo Wordle, por decisión del grupo, para que las pistas sean más claras. El juego queda más fácil que el Mastermind original.

- **Color de "Vidas":** blanco con todas (8), verde con 7 y 6, amarillo con 5 y 4, naranja con 3 y 2, y rojo en la última.
- **Color de cada # del historial:** según las fichas con borde verde de ese intento. Con 0 es rojo, con 1 naranja, con 2 amarillo y con 3 o 4 verde.
- Solo se guardan en `puntajes.dat` las partidas **ganadas**, porque al perder el puntaje es 0.

## Configuración y ejecución

### Requisitos

- **.NET 8 SDK** o más nuevo.
- Visual Studio 2022, VS Code con C# Dev Kit, o solo la consola.
- Opcional: un servidor MySQL con la base `codigo_secreto_db` creada con `db/BD.sql`. **El juego funciona completo sin MySQL.**

### Pasos

1. Descomprimí `CodeBreaker.zip`.
2. Descargá el spritesheet y copialo a `src/Content/Sprites/`, siguiendo `assets/README.md`. Sin sprites el juego igual anda: dibuja las abreviaturas de los colores ("Ro", "Az"…).
3. Revisá `src/config.conf`: usuario y contraseña de MySQL, y los nombres de los sprites.
4. Abrí una consola en `src/` y ejecutá:
   ```
   dotnet run
   ```
   La primera vez, `dotnet` descarga MonoGame, MySqlConnector y la herramienta `mgcb`, que arma las fuentes. Tarda un poco.
   En Visual Studio: abrí `src/CodeBreaker.csproj` y apretá F5.
5. Los archivos se leen y se escriben **al lado del ejecutable** (`src/bin/Debug/net8.0/`): `config.conf`, `puntajes.dat` y `Content/Sprites/`.
   Si cambiás `src/config.conf`, volvé a compilar para que se copie, o editá directamente el de `bin`.

### `config.conf`

| Clave | Por defecto | Para qué sirve |
|---|---|---|
| `db_server`, `db_port`, `db_name`, `db_user`, `db_password` | `localhost`, `3306`, `codigo_secreto_db`, `root`, vacío | Conexión a MySQL |
| `code_length` | `4` | Largo del código, de 2 a 6 |
| `lives` | `8` | Vidas y capacidad de la cola, de 1 a 12 |
| `points_per_life` | `100` | Puntos por cada vida que queda |
| `time_bonus_max` | `300` | Bono de tiempo: `max(0, time_bonus_max − segundos)` |
| `debug_show_secret` | `false` | `true` muestra el código durante la partida. Es **solo para las pruebas en clase**. |
| `sprite_red` … `sprite_purple` | `rojo.png`, `azul.png`, `verde.png`, `amarillo.png`, `naranja.png`, `morado.png` | Sprite de cada color: un PNG suelto de `Content/Sprites` o el nombre de una SubTexture de un XML (ver `assets/README.md`) |
| `sprite_frame_exact`, `sprite_frame_present`, `sprite_frame_absent` | `aro_verde.png`, `aro_amarillo.png`, `aro_rojo.png` | Aro de cada ficha del historial según su resultado. Si falta, se dibujan corchetes `[ ]` de ese color. |
| `sprite_cursor`, `sprite_empty` | vacío | Selector y casillero vacío (opcionales) |

Las líneas que empiezan con `#` son comentarios.
Si un valor no es válido, el juego usa el valor por defecto y lo avisa en el menú.
Si el archivo no existe, lo vuelve a crear sin avisar: es una situación normal, no un error.

## Estructura de carpetas

```
CodeBreaker/
├── README.md                 este archivo
├── assets/
│   └── README.md             qué pack bajar, qué copiar y dónde
├── db/                       (no incluida) BD.sql, DER.drawio, DiccionarioDeDatos.txt
├── docs/                     (no incluida) documentación de la materia Base de Datos
└── src/
    ├── CodeBreaker.csproj    proyecto (.NET 8, MonoGame DesktopGL, MySqlConnector)
    ├── .config/dotnet-tools.json   herramienta mgcb de MonoGame
    ├── app.manifest
    ├── config.conf           configuración de ejemplo
    ├── Program.cs            punto de entrada
    ├── Game1.cs              máquina de estados y carga de recursos
    ├── GameState.cs          enum Menu, Playing, GameOver, Ranking
    ├── Content/
    │   ├── Content.mgcb      fuentes del juego
    │   ├── Fonts/            Title, Regular, Medium y Small (.spritefont)
    │   └── Sprites/          6 fichas (rojo, azul…) y 3 aros (aro_verde, aro_amarillo, aro_rojo)
    ├── Models/               PegColor, Palette, Attempt, ScoreRecord, GameConfig
    ├── Data/                 ConfigManager, ScoreFile, DatabaseService, SpriteAtlas
    ├── Logic/                CodeGenerator, FeedbackEvaluator, ScoreService,
    │                         CircularQueue, BubbleSorter, GameSession
    └── Screens/              MenuScreen, PlayingScreen, GameOverScreen,
                              RankingScreen, Renderer, InputHelper
```

Las carpetas **`/db` y `/docs` no van en este zip.** Ahí se ubican `BD.sql`, `DER.drawio` y `DiccionarioDeDatos.txt`, que ya están en el repositorio de la materia Base de Datos:
https://github.com/sebitssssss/BaseDeDatos/tree/proyecto-interdisciplinario

## Assets usados

| Pack | URL | Licencia |
|---|---|---|
| Input Prompts (Kenney): 6 fichas (`rojo.png`, `azul.png`, `verde.png`, `amarillo.png`, `naranja.png`, `morado.png`) y 3 aros (`aro_verde.png`, `aro_amarillo.png`, `aro_rojo.png`), 128×128. Descargados de esa página, con **ediciones mínimas de color** hechas por el grupo. | https://kenney.nl/assets/input-prompts | CC0 1.0 (confirmar en el `License.txt` del pack) |

- Un PNG suelto se usa entero como un sprite. En un spritesheet, el recorte de cada sprite sale de su XML (`Data/SpriteAtlas.cs`). En ningún caso hay coordenadas inventadas.
- No se generan texturas por código: no hay `SetData` ni un píxel de 1×1 para dibujar formas.
- El juego no edita gráficos. Las únicas ediciones son las de color que el grupo hizo a los PNG antes de agregarlos (ver `assets/README.md`).
- Los textos usan SpriteFont con la fuente Arial, que viene instalada en Windows.

## Estructura de datos: cola circular (`Logic/CircularQueue.cs`)

**Para qué:** guarda el historial de intentos en **orden cronológico** (FIFO: el primero que entra es el primero que sale).

**Cómo está hecha:**

- `items`: un array de tamaño fijo. Su **capacidad es igual a la cantidad de vidas** (8).
- `front` (frente): dónde está el intento más viejo.
- `rear` (final): dónde está el último intento que entró. Empieza en −1.
- `count` (cantidad): cuántos intentos hay guardados.

**La idea "circular":** al avanzar un índice se usa `(indice + 1) % capacidad`. Cuando llega al último casillero, el siguiente es el 0.
Así se reutilizan los casilleros que libera `Dequeue` sin correr ningún elemento.

```
capacidad 4, después de Enqueue(A,B,C), Dequeue() y Enqueue(D,E):

 índice:   0    1    2    3
 items:  [ E ][ B ][ C ][ D ]      front = 1 (B es el más viejo)
                                   rear  = 0 (E dio la vuelta al casillero 0)
                                   count = 4 → IsFull() = true
```

| Método | Qué hace | Costo |
|---|---|---|
| `Enqueue(item)` | Agrega al final. Devuelve `false` si está llena. | O(1) |
| `Dequeue(out item)` | Saca el del frente. Devuelve `false` si está vacía. | O(1) |
| `Peek(out item)` | Mira el del frente sin sacarlo. | O(1) |
| `IsEmpty()`, `IsFull()`, `Count()` | Estado de la cola. | O(1) |
| `GetAt(i)` | Devuelve el i-ésimo desde el frente: `items[(front + i) % capacidad]`. Devuelve `null` si `i` no es válido. | O(1) |
| `Clear()` | La vacía para una partida nueva. | O(n) |

**Cola llena y cola vacía** se controlan con el **retorno booleano**: nunca hay un error sin manejar.

**Dónde se usa:**

1. Al confirmar un intento: `Enqueue`.
2. Al dibujar el historial: `GetAt(i)`, desde el más viejo al más nuevo.
3. En **Game Over**: se hace un `Dequeue` **por segundo** para repetir la partida en orden, hasta que `IsEmpty()` da `true`.
4. Al volver a jugar: `Clear()`.

Como en una partida hay como máximo tantos intentos como vidas, la cola nunca se llena de más.
Igual se controla: si `Enqueue` devuelve `false`, se muestra un aviso.

El **intento en curso** no usa la cola: es un array simple (`currentGuess`) con un índice (`currentCount`).

## Algoritmo: ordenamiento por burbuja (`Logic/BubbleSorter.cs`)

**Para qué:** ordenar los registros de `puntajes.dat` en la tabla de posiciones.
El criterio es **puntaje descendente** y, si hay empate, **tiempo ascendente**.

**Pasos:**

1. Se hacen hasta `n − 1` pasadas sobre el array.
2. En cada pasada se comparan vecinos `(i, i+1)`. Los últimos `pasada` casilleros ya quedaron en su lugar y no se recorren.
3. Si el de la derecha tiene que ir antes (`IsBetter`), se intercambian con una variable auxiliar.
4. Si en una pasada no hubo intercambios (bandera `swapped`), el array ya está ordenado y se corta.

**Complejidad:**

- **O(n²)** en el peor caso y en el caso promedio.
- **O(n)** en el mejor caso, cuando ya está ordenado, gracias a la bandera.
- Memoria extra **O(1)**.

Es **estable**: dos registros con el mismo puntaje y el mismo tiempo mantienen su orden, porque solo se intercambian si uno es estrictamente mejor.

Se ordena al entrar al Ranking y cuando el array de 100 registros está lleno: ahí se ordena y el registro nuevo reemplaza al peor, solo si lo supera.

## Persistencia

### `config.conf` (AED)

- Es texto `clave=valor`. Se lee con `StreamReader` y se escribe con `StreamWriter` (`Data/ConfigManager.cs`).
- Si no existe, se crea con valores por defecto.

### `puntajes.dat` (AED)

- Es binario, con `BinaryWriter` y `BinaryReader` (`Data/ScoreFile.cs`).
- Formato: `int cantidad`, y por cada registro `string nombre`, `int puntaje`, `int vidas`, `int segundos` y `long fecha` (`DateTime.Ticks`).
- Se carga en un array fijo de **100** registros como máximo.
- Si no existe, el ranking empieza vacío y la pantalla de Ranking dice "Todavía no hay partidas ganadas".
- Si está dañado (cantidad imposible, datos inválidos o archivo cortado), avisa en el menú y en el Ranking, y el ranking empieza vacío.
- Si no se puede guardar, avisa en la pantalla de fin de partida.

### MySQL (Base de Datos)

`Data/DatabaseService.cs`:

- arma la cadena de conexión con los datos de `config.conf`, con `Connection Timeout=3`;
- abre y cierra la conexión con `using` y `try-catch`;
- expone el estado ("conectada" o "sin conexión") que se ve en el menú.

**No hay SQL en el código C#:** las consultas y los procedimientos los define la materia Base de Datos en `BD.sql`, con sus 8 tablas.
El chequeo se hace después de mostrar la ventana, y con F5 en el menú se reintenta.

## Casos de prueba manuales

Para las pruebas de ganar y de empates conviene poner `debug_show_secret=true` en el `config.conf` de `bin/Debug/net8.0/`: el código se ve arriba, en rojo.

| # | Caso | Pasos | Resultado esperado |
|---|---|---|---|
| 1 | Ganar | Nombre "Ana", Jugar. Con `debug_show_secret=true`, cargar el código que se ve y apretar Enter. | Pantalla "¡GANASTE!", código revelado, puntaje `vidas×100 + max(0, 300−seg)` y repetición de un intento por segundo. El puntaje aparece en el Ranking. |
| 2 | Perder por vidas (Game Over) | Jugar y confirmar 8 intentos incorrectos. | En cada intento: bordes en las fichas, "Vidas" baja 1 y cambia de color (blanco, verde, amarillo, naranja y rojo en la última). Al octavo: "GAME OVER" con fondo rojizo, código revelado, puntaje 0 y repetición de los 8 intentos. |
| 3 | Borrar una ficha | Poner 3 fichas con Espacio y apretar Retroceso. | Se borra la tercera, el selector vuelve a esa posición y no se pierde ninguna vida. |
| 4 | Enter incompleto | Poner 2 fichas y apretar Enter. | "Completá las 4 posiciones…" y las vidas no cambian. |
| 5 | Nombre vacío | Sin escribir nombre, elegir Jugar. | "Escribí tu nombre antes de jugar." |
| 6 | MySQL apagado | Detener MySQL (por ejemplo, Stop en XAMPP) y abrir el juego. | Durante 3 segundos como máximo: "MySQL: sin conexión" en rojo, con el motivo. Se puede jugar igual. Al prender MySQL y apretar F5: "MySQL: conectada". |
| 7 | MySQL encendido | Con la base de `BD.sql` creada y el usuario correcto en `config.conf`. | "MySQL: conectada" en verde. |
| 8 | `config.conf` faltante | Borrar `bin/Debug/net8.0/config.conf` y abrir el juego. | Sin aviso. El archivo se vuelve a crear con los valores por defecto (abrilo para comprobarlo). |
| 9 | `config.conf` con errores | Poner `lives=abc` o `code_length=9`. | Aviso en el menú. Se usan 8 vidas y 4 posiciones. |
| 10 | `puntajes.dat` borrado | Borrar el archivo y abrir el Ranking. | Sin aviso. El Ranking dice "Todavía no hay partidas ganadas". |
| 11 | `puntajes.dat` dañado | Abrir el archivo con el Bloc de notas, escribir cualquier cosa y guardar. | Aviso "puntajes.dat está dañado (…)" en el menú y en el Ranking. El ranking está vacío y el juego no se cierra. Al ganar, el archivo se reemplaza por uno válido. |
| 12 | Ranking con empates | Con `time_bonus_max=0` (el puntaje queda en vidas×100) y `debug_show_secret=true`, ganar dos veces en el primer intento: una rápido y otra esperando unos segundos. | Los dos tienen 800 y aparece primero el de menor tiempo. |
| 13 | Ranking top 10 | Con más de 10 partidas ganadas, abrir el Ranking. | Solo se ven las 10 mejores, ordenadas. |
| 14 | Sprite faltante | En `config.conf` poner un nombre que no exista, por ejemplo `sprite_orange=noexiste`. | Aviso "Sprites que no se encontraron en Content/Sprites: noexiste". Ese color se dibuja como "Na". |
| 15 | Sin sprites | Sacar los PNG de `src/bin/Debug/net8.0/Content/Sprites`. | Sin aviso. Las fichas se dibujan con letras ("Ro", "Az"...) y se juega igual. |
| 16 | Aros de las pistas | Con `debug_show_secret=true`, armar un intento con un color en su lugar, otro que está en el código pero en otro lugar, y otro que no está. | Aro verde, amarillo y rojo en esas fichas. El mensaje dice "1 en su lugar y 1 en otro lugar". |
| 17 | Color repetido | Con código Rojo Azul Verde Verde (ver el código de prueba), intentar Verde Verde Verde Rojo. | Amarillo, rojo, verde, amarillo: el segundo Verde queda en rojo porque ya no quedan Verdes sin usar. |

## Problemas comunes

- **`Could not find "Arial" font file` al compilar en Linux.** Arial viene con Windows. En Linux, cambiá `<FontName>` en los tres `.spritefont` por una fuente instalada, por ejemplo `Liberation Sans` (probado con esa).
- **MySQL 8 con `caching_sha2_password` sin SSL.** Si el motivo menciona "AllowPublicKeyRetrieval", el profesor de Base de Datos puede crear el usuario con `mysql_native_password`, o se agrega esa opción en `DatabaseService.BuildConnectionString()`.
- **La ventana tarda unos segundos en responder al abrir.** Es la prueba de conexión a MySQL cuando el servidor no contesta: como máximo 3 segundos.
