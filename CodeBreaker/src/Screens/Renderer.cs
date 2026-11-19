using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using CodeBreaker.Data;
using CodeBreaker.Models;

namespace CodeBreaker.Screens
{
    // Dibujo compartido por todas las pantallas: textos, fichas, pines y cursores.
    // Si falta un sprite, escribe una letra de reemplazo con la SpriteFont
    // (no se generan texturas por código).
    public class Renderer
    {
        public const int ScreenWidth = 1280;
        public const int ScreenHeight = 720;

        // Colores de la interfaz (fondo con GraphicsDevice.Clear y tinte de los textos).
        public static readonly Color BackgroundColor = new Color(58, 74, 92);
        public static readonly Color DefeatBackgroundColor = new Color(84, 38, 46); // fondo de la derrota
        public static readonly Color TextColor = Color.White;
        public static readonly Color DimTextColor = new Color(175, 185, 200);
        public static readonly Color HighlightColor = new Color(255, 215, 80);  // amarillo
        public static readonly Color GoodColor = new Color(120, 225, 120);      // verde
        public static readonly Color OrangeColor = new Color(255, 160, 60);     // naranja
        public static readonly Color RedColor = new Color(255, 85, 85);         // rojo
        public static readonly Color BadColor = new Color(255, 125, 115);

        // Colores de los aros de las fichas del historial (los mismos de los PNG de los aros).
        // Se usan en la leyenda y en los corchetes de reemplazo si falta un aro.
        public static readonly Color ExactBorderColor = new Color(115, 181, 2);   // verde: lugar correcto
        public static readonly Color PresentBorderColor = new Color(253, 185, 1); // amarillo: está en otro lugar
        public static readonly Color AbsentBorderColor = new Color(238, 39, 47);  // rojo: no está

        private const int BigSlotSize = 60;       // desde este tamaño, las letras de reemplazo usan la fuente normal
        private const int BorderInsetDivisor = 7; // la ficha queda 1/7 del tamaño hacia adentro del aro

        private readonly SpriteBatch spriteBatch;
        private readonly SpriteAtlas atlas;

        // Índice en el atlas de cada sprite que pide config.conf (SpriteAtlas.NotFound si no está).
        private readonly int[] colorSprites = new int[Palette.ColorCount];
        private int frameExactSprite = SpriteAtlas.NotFound;   // aro verde
        private int framePresentSprite = SpriteAtlas.NotFound; // aro amarillo
        private int frameAbsentSprite = SpriteAtlas.NotFound;  // aro rojo
        private int cursorSprite = SpriteAtlas.NotFound;
        private int emptySprite = SpriteAtlas.NotFound;

        public SpriteFont TitleFont { get; private set; }
        public SpriteFont RegularFont { get; private set; }
        public SpriteFont MediumFont { get; private set; }
        public SpriteFont SmallFont { get; private set; }
        public string Warning { get; private set; } // sprites pedidos que no se encontraron

        public Renderer(SpriteBatch spriteBatch, SpriteAtlas atlas, SpriteFont titleFont, SpriteFont regularFont, SpriteFont mediumFont, SpriteFont smallFont)
        {
            this.spriteBatch = spriteBatch;
            this.atlas = atlas;
            TitleFont = titleFont;
            RegularFont = regularFont;
            MediumFont = mediumFont;
            SmallFont = smallFont;
            Warning = "";
            for (int i = 0; i < Palette.ColorCount; i++)
            {
                colorSprites[i] = SpriteAtlas.NotFound;
            }
        }

        // Busca en el atlas los sprites indicados en config.conf y guarda sus índices.
        public void ResolveSprites(GameConfig config)
        {
            string missing = "";
            for (int i = 0; i < Palette.ColorCount; i++)
            {
                colorSprites[i] = FindSprite(config.ColorSprites[i], ref missing);
            }
            frameExactSprite = FindSprite(config.FrameExactSprite, ref missing);
            framePresentSprite = FindSprite(config.FramePresentSprite, ref missing);
            frameAbsentSprite = FindSprite(config.FrameAbsentSprite, ref missing);
            cursorSprite = FindSprite(config.CursorSprite, ref missing);
            emptySprite = FindSprite(config.EmptySprite, ref missing);

            // Si no hay ninguna hoja cargada, el aviso ya lo da SpriteAtlas.
            Warning = "";
            if (missing.Length > 0 && atlas.SpriteCount > 0)
            {
                Warning = "Sprites que no se encontraron en Content/Sprites: " + missing + ". Se dibujan letras (revisá config.conf).";
            }
        }

        // Busca un sprite; si se pidió uno (texto no vacío) y no aparece, lo anota en "missing".
        private int FindSprite(string name, ref string missing)
        {
            int index = atlas.Find(name);
            if (index == SpriteAtlas.NotFound && !string.IsNullOrEmpty(name))
            {
                missing = missing.Length == 0 ? name : missing + ", " + name;
            }
            return index;
        }

        // ---------------------------------------------------------------- textos

        public void DrawText(SpriteFont font, string text, float x, float y, Color color)
        {
            spriteBatch.DrawString(font, text, new Vector2(x, y), color);
        }

        // Escribe un texto centrado horizontalmente en la pantalla.
        public void DrawCentered(SpriteFont font, string text, float y, Color color)
        {
            Vector2 size = font.MeasureString(text);
            DrawText(font, text, (ScreenWidth - size.X) / 2f, y, color);
        }

        // Escribe un texto centrado dentro de un rectángulo.
        public void DrawTextInBox(SpriteFont font, string text, Rectangle box, Color color)
        {
            Vector2 size = font.MeasureString(text);
            DrawText(font, text, box.X + (box.Width - size.X) / 2f, box.Y + (box.Height - size.Y) / 2f, color);
        }

        // Escribe un texto largo partiéndolo en renglones de hasta maxWidth píxeles.
        // Devuelve la Y donde terminó, para seguir escribiendo debajo.
        public float DrawWrapped(SpriteFont font, string text, float x, float y, float maxWidth, int maxLines, Color color)
        {
            string[] words = text.Split(' ');
            string line = "";
            int lines = 0;
            for (int i = 0; i < words.Length; i++)
            {
                string candidate = line.Length == 0 ? words[i] : line + " " + words[i];
                if (font.MeasureString(candidate).X > maxWidth && line.Length > 0)
                {
                    DrawText(font, line, x, y, color);
                    y += font.LineSpacing;
                    lines++;
                    if (lines == maxLines)
                    {
                        return y; // no hay más lugar: el resto no se muestra
                    }
                    line = words[i];
                }
                else
                {
                    line = candidate;
                }
            }
            if (line.Length > 0)
            {
                DrawText(font, line, x, y, color);
                y += font.LineSpacing;
            }
            return y;
        }

        // Convierte segundos a "mm:ss".
        public static string FormatTime(int totalSeconds)
        {
            int minutes = totalSeconds / 60;
            int seconds = totalSeconds % 60;
            return minutes.ToString("00") + ":" + seconds.ToString("00");
        }

        // ---------------------------------------------------------------- piezas

        // Ficha de un color. Sin sprite: la abreviatura del color ("Ro", "Az"...).
        public void DrawPeg(PegColor color, Rectangle area)
        {
            int sprite = colorSprites[(int)color];
            if (sprite != SpriteAtlas.NotFound)
            {
                atlas.Draw(spriteBatch, sprite, area);
            }
            else
            {
                DrawTextInBox(FontFor(area), Palette.GetShortName(color), area, Palette.GetTextColor(color));
            }
        }

        // Casillero vacío del intento en curso. Sin sprite: "--".
        public void DrawEmptySlot(Rectangle area)
        {
            if (emptySprite != SpriteAtlas.NotFound)
            {
                atlas.Draw(spriteBatch, emptySprite, area);
            }
            else
            {
                DrawTextInBox(FontFor(area), "--", area, DimTextColor);
            }
        }

        // Color del aro según el resultado de la ficha.
        public static Color GetBorderColor(PegResult result)
        {
            switch (result)
            {
                case PegResult.Exact: return ExactBorderColor;
                case PegResult.Present: return PresentBorderColor;
                default: return AbsentBorderColor;
            }
        }

        // Sprite del aro según el resultado de la ficha.
        private int GetFrameSprite(PegResult result)
        {
            switch (result)
            {
                case PegResult.Exact: return frameExactSprite;
                case PegResult.Present: return framePresentSprite;
                default: return frameAbsentSprite;
            }
        }

        // Ficha de un intento ya confirmado, rodeada por su aro: verde, amarillo o rojo.
        // Si falta el PNG del aro, se dibujan corchetes "[ ]" de ese color con la SpriteFont.
        public void DrawPegWithBorder(PegColor color, PegResult result, Rectangle area)
        {
            int frame = GetFrameSprite(result);
            if (frame != SpriteAtlas.NotFound)
            {
                atlas.Draw(spriteBatch, frame, area);
            }
            else
            {
                Color borderColor = GetBorderColor(result);
                Vector2 bracketSize = RegularFont.MeasureString("[");
                float bracketY = area.Y + (area.Height - bracketSize.Y) / 2f;
                DrawText(RegularFont, "[", area.X, bracketY, borderColor);
                DrawText(RegularFont, "]", area.Right - bracketSize.X, bracketY, borderColor);
            }

            // La ficha va adentro del aro, un poco más chica.
            int inset = area.Width / BorderInsetDivisor;
            DrawPeg(color, new Rectangle(area.X + inset, area.Y + inset, area.Width - 2 * inset, area.Height - 2 * inset));
        }

        // Cursor (selector). Sin sprite: el texto indicado ("^" o ">").
        public void DrawCursor(Rectangle area, string fallbackText)
        {
            if (cursorSprite != SpriteAtlas.NotFound)
            {
                atlas.Draw(spriteBatch, cursorSprite, area);
            }
            else
            {
                DrawTextInBox(RegularFont, fallbackText, area, HighlightColor);
            }
        }

        // Dibuja una fila de fichas (por ejemplo, el código secreto) empezando en (x, y).
        public void DrawPegRow(PegColor[] pegs, int length, int x, int y, int size, int gap)
        {
            for (int i = 0; i < length; i++)
            {
                DrawPeg(pegs[i], new Rectangle(x + i * (size + gap), y, size, size));
            }
        }

        // Ancho total de una fila de fichas (sirve para centrarla).
        public static int RowWidth(int length, int size, int gap)
        {
            return length * size + (length - 1) * gap;
        }

        // Letras de reemplazo: fuente normal en casilleros grandes, chica en los demás.
        private SpriteFont FontFor(Rectangle area)
        {
            return area.Height >= BigSlotSize ? RegularFont : SmallFont;
        }
    }
}
