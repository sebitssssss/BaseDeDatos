# Assets de Code Breaker

## Qué trae el zip

En `src/Content/Sprites/` hay 9 PNG de 128×128 con fondo transparente. `config.conf` ya apunta a todos.

| Archivo | Uso en el juego |
|---|---|
| `rojo.png`, `azul.png`, `verde.png`, `amarillo.png`, `naranja.png`, `morado.png` | Las 6 fichas de la paleta |
| `aro_verde.png` | Aro de una ficha en el lugar correcto |
| `aro_amarillo.png` | Aro de una ficha cuyo color está en el código, en otro lugar |
| `aro_rojo.png` | Aro de una ficha cuyo color no está en el código |

## Origen y licencia

| Dato | Valor |
|---|---|
| Pack | **Input Prompts**, de Kenney |
| URL | https://kenney.nl/assets/input-prompts |
| Licencia | Kenney publica sus packs como **CC0 1.0** (dominio público). Confirmalo en el `License.txt` que viene dentro del zip del pack. |
| Ediciones | El grupo descargó los PNG de esa página y les hizo **ediciones mínimas**: el color de cada ficha y de cada aro. |

> **Nota para la defensa:** la consigna dice "uso exclusivo de spritesheets descargados" y "queda descartada la edición o creación gráfica propia". Los PNG son descargados de Kenney, pero tienen ediciones mínimas de color hechas por el grupo. Queda documentado acá para que se pueda justificar.

## Cómo los usa el juego

`Content/Sprites/` acepta dos formatos:

- **PNG suelto:** cada archivo es un sprite entero y se nombra por el archivo, por ejemplo `sprite_red=rojo.png`. No hace falta XML, porque se usa la imagen completa.
- **Spritesheet PNG + XML** (como los de Kenney): el recorte de cada sprite sale del XML. En ningún caso hay coordenadas inventadas.

En `src/config.conf`:

```
sprite_red=rojo.png
sprite_blue=azul.png
sprite_green=verde.png
sprite_yellow=amarillo.png
sprite_orange=naranja.png
sprite_purple=morado.png
sprite_frame_exact=aro_verde.png       (lugar correcto)
sprite_frame_present=aro_amarillo.png  (está en otro lugar)
sprite_frame_absent=aro_rojo.png       (no está)
sprite_cursor=                         (opcional; vacío = se dibuja "^" y ">")
sprite_empty=                          (opcional; vacío = se dibuja "--")
```

- Si un nombre no aparece en `Content/Sprites`, el menú lo avisa. En lugar de la ficha se dibuja su abreviatura ("Ro", "Az"…) y en lugar del aro, corchetes `[ ]` de color. El juego no se cierra.
- Para cambiar un sprite, copiá el PNG nuevo a `src/Content/Sprites/` y cambiá el nombre en `config.conf`.

## Usar un spritesheet de Kenney (opcional)

1. Descargá el pack desde kenney.nl y descomprimilo.
2. En la carpeta de spritesheets, copiá **el PNG y su XML, sin cambiarles el nombre**, a `src/Content/Sprites/`.
3. Abrí el XML con el Bloc de notas. Cada sprite es una línea así:
   ```xml
   <SubTexture name="NOMBRE.png" x="..." y="..." width="..." height="..."/>
   ```
4. Copiá el `name` del sprite que quieras a la clave que corresponda en `config.conf`.

## Por qué los sprites no van en Content.mgcb

Para no tener que editar `Content.mgcb` cada vez que cambia un sprite:

- el juego carga cada PNG con `Texture2D.FromFile`, que lee el archivo tal cual y no genera texturas;
- el `.csproj` copia `Content/Sprites/*.png` y `*.xml` a la carpeta del ejecutable;
- en `Content.mgcb` solo están las fuentes (SpriteFont).
