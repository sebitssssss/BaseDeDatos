using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Input;
using CodeBreaker.Logic;
using CodeBreaker.Models;

namespace CodeBreaker.Screens
{
    // Pantalla de juego: historial con pistas, intento en curso, paleta, selector, vidas, tiempo y puntaje.
    // Controles: Izquierda/Derecha = posición, Arriba/Abajo = color, Espacio = poner ficha,
    //            Retroceso = borrar la última ficha, Enter = confirmar, Esc = volver al menú.
    public class PlayingScreen
    {
        // Barra superior: vidas a la izquierda, puntaje sobre el intento actual, tiempo a la derecha
        private const int TopBarY = 18;
        private const int LivesX = 40;
        private const int RightMargin = 40;

        // Proporciones para los colores (de vidas y de resultados)
        private const float GreenRatio = 0.75f;  // desde 3/4 para arriba: verde
        private const float YellowRatio = 0.5f;  // desde la mitad: amarillo; menos: naranja

        // Historial (columna izquierda)
        private const int HistoryX = 40;
        private const int HistoryTitleY = 100;
        private const int HistoryTop = 135;
        private const int HistoryBottom = 655;  // termina antes de la línea de teclas
        private const int MaxRowHeight = 64;
        private const int RowPadding = 8;
        private const int NumberWidth = 60;
        private const int PegGap = 8;
        private const int LegendY = 650;
        private const int DebugX = 260;

        // Intento en curso y paleta (columna derecha)
        private const int RightX = 700;
        private const int RightTitleY = 70;
        private const int CurrentY = 110;
        private const int CurrentSlotSize = 80;
        private const int CurrentSlotGap = 16;
        private const int CursorSize = 36;
        private const int CursorGap = 4;
        private const int PaletteTitleY = 255;
        private const int PaletteY = 295;
        private const int PaletteRowHeight = 54;
        private const int PaletteSlotX = 760;
        private const int PaletteSlotSize = 46;
        private const int PaletteNameGap = 16;
        private const int MessageY = 625;
        private const int MessageWidth = 560;
        private const int HintY = 690;

        private readonly GameSession session;
        private readonly bool showSecret; // debug_show_secret de config.conf
        private int cursorSlot;           // posición del intento donde está el selector
        private int selectedColor;        // color elegido en la paleta (índice del enum)
        private string message;

        public PlayingScreen(GameSession session, bool showSecret)
        {
            this.session = session;
            this.showSecret = showSecret;
            message = "";
        }

        public GameSession Session
        {
            get { return session; }
        }

        public void StartNewGame(string playerName)
        {
            session.StartNew(playerName);
            cursorSlot = 0;
            selectedColor = 0;
            message = "";
        }

        // Devuelve el estado al que hay que pasar (Playing para seguir jugando).
        public GameState Update(GameTime gameTime, InputHelper input)
        {
            session.AddTime(gameTime.ElapsedGameTime.TotalSeconds);

            if (input.WasPressed(Keys.Escape))
            {
                return GameState.Menu; // abandona la partida
            }

            // Izquierda/Derecha: el selector no puede pasar de la primera posición vacía.
            if (input.WasPressed(Keys.Left) && cursorSlot > 0)
            {
                cursorSlot--;
            }
            if (input.WasPressed(Keys.Right) && cursorSlot < session.CurrentCount && cursorSlot < session.CodeLength - 1)
            {
                cursorSlot++;
            }

            // Arriba/Abajo: recorre la paleta dando la vuelta.
            if (input.WasPressed(Keys.Up))
            {
                selectedColor = (selectedColor + Palette.ColorCount - 1) % Palette.ColorCount;
            }
            if (input.WasPressed(Keys.Down))
            {
                selectedColor = (selectedColor + 1) % Palette.ColorCount;
            }

            if (input.WasPressed(Keys.Space))
            {
                PlaceSelectedColor();
            }
            if (input.WasPressed(Keys.Back))
            {
                RemoveLastPeg();
            }
            if (input.WasPressed(Keys.Enter))
            {
                return ConfirmGuess();
            }
            return GameState.Playing;
        }

        private void PlaceSelectedColor()
        {
            bool isNewPeg = cursorSlot == session.CurrentCount;
            if (session.PlaceColor(cursorSlot, (PegColor)selectedColor))
            {
                message = "";
                // Si se agregó una ficha nueva, el selector pasa solo a la posición siguiente.
                if (isNewPeg && cursorSlot < session.CodeLength - 1)
                {
                    cursorSlot++;
                }
            }
        }

        private void RemoveLastPeg()
        {
            if (session.RemoveLast())
            {
                message = "";
                if (cursorSlot > session.CurrentCount)
                {
                    cursorSlot = session.CurrentCount; // no puede quedar después de la primera vacía
                }
            }
            else
            {
                message = "No hay fichas para borrar.";
            }
        }

        private GameState ConfirmGuess()
        {
            if (!session.IsGuessComplete())
            {
                message = "Completá las " + session.CodeLength + " posiciones antes de confirmar con Enter.";
                return GameState.Playing;
            }

            Attempt attempt = session.SubmitGuess();
            cursorSlot = 0;
            if (session.IsFinished)
            {
                return GameState.GameOver;
            }
            message = "Intento " + attempt.Number + ": " + attempt.ExactCount + " en su lugar y " + attempt.PresentCount + " en otro lugar. Perdiste una vida.";
            return GameState.Playing;
        }

        // ---------------------------------------------------------------- colores

        // Color de "Vidas": blanco con todas, después verde, amarillo, naranja y rojo en la última.
        // Con 8 vidas: 8 blanco, 7-6 verde, 5-4 amarillo, 3-2 naranja, 1 rojo.
        private static Color GetLivesColor(int lives, int maxLives)
        {
            if (lives >= maxLives)
            {
                return Renderer.TextColor;
            }
            if (lives <= 1)
            {
                return Renderer.RedColor;
            }
            float ratio = (float)lives / maxLives;
            if (ratio >= GreenRatio)
            {
                return Renderer.GoodColor;
            }
            if (ratio >= YellowRatio)
            {
                return Renderer.HighlightColor;
            }
            return Renderer.OrangeColor;
        }

        // Color del número (#) de un intento según su resultado: cuantas más fichas en su lugar, más verde.
        // Con código de 4: 0 en su lugar rojo, 1 naranja, 2 amarillo, 3 o 4 verde.
        private static Color GetResultColor(int exactCount, int codeLength)
        {
            if (exactCount == 0)
            {
                return Renderer.RedColor;
            }
            float ratio = (float)exactCount / codeLength;
            if (ratio >= GreenRatio)
            {
                return Renderer.GoodColor;
            }
            if (ratio >= YellowRatio)
            {
                return Renderer.HighlightColor;
            }
            return Renderer.OrangeColor;
        }

        // ---------------------------------------------------------------- dibujo

        public void Draw(Renderer r)
        {
            DrawTopBar(r);
            DrawHistory(r);
            DrawCurrentGuess(r);
            DrawPalette(r);

            string text = message;
            if (session.Warning.Length > 0)
            {
                text = session.Warning;
            }
            if (text.Length > 0)
            {
                r.DrawWrapped(r.SmallFont, text, RightX, MessageY, MessageWidth, 2, Renderer.HighlightColor);
            }
            r.DrawCentered(r.SmallFont, "Izquierda/Derecha: posición · Arriba/Abajo: color · Espacio: poner ficha · Retroceso: borrar · Enter: confirmar · Esc: menú", HintY, Renderer.DimTextColor);
        }

        private void DrawTopBar(Renderer r)
        {
            r.DrawText(r.RegularFont, "Vidas: " + session.Lives + " / " + session.MaxLives, LivesX, TopBarY, GetLivesColor(session.Lives, session.MaxLives));
            r.DrawText(r.RegularFont, "Puntaje: " + session.PotentialScore(), RightX, TopBarY, Renderer.HighlightColor);

            // El tiempo va pegado al borde derecho: se mide el texto para saber dónde empieza.
            string time = "Tiempo: " + Renderer.FormatTime(session.SecondsPlayed);
            float timeX = Renderer.ScreenWidth - RightMargin - r.RegularFont.MeasureString(time).X;
            r.DrawText(r.RegularFont, time, timeX, TopBarY, Renderer.TextColor);
        }

        // Recorre la cola desde el frente con GetAt(i): el intento más viejo queda arriba.
        private void DrawHistory(Renderer r)
        {
            r.DrawText(r.MediumFont, "Historial de intentos", HistoryX, HistoryTitleY, Renderer.DimTextColor);
            if (showSecret)
            {
                string secret = "(prueba) Código:";
                for (int i = 0; i < session.CodeLength; i++)
                {
                    secret += " " + Palette.GetShortName(session.GetSecretAt(i));
                }
                r.DrawText(r.SmallFont, secret, DebugX, HistoryTitleY + 2, Renderer.BadColor);
            }

            int rowHeight = (HistoryBottom - HistoryTop) / session.MaxLives;
            if (rowHeight > MaxRowHeight)
            {
                rowHeight = MaxRowHeight;
            }
            int pegSize = rowHeight - RowPadding;
            int pegsX = HistoryX + NumberWidth;

            for (int row = 0; row < session.MaxLives; row++)
            {
                int y = HistoryTop + row * rowHeight;
                float textY = y + (pegSize - r.MediumFont.LineSpacing) / 2f;
                Attempt attempt = session.History.GetAt(row); // null si todavía no hubo ese intento

                if (attempt == null)
                {
                    r.DrawText(r.MediumFont, "#" + (row + 1), HistoryX, textY, Renderer.DimTextColor);
                    continue;
                }

                r.DrawText(r.MediumFont, "#" + attempt.Number, HistoryX, textY, GetResultColor(attempt.ExactCount, session.CodeLength));
                for (int i = 0; i < session.CodeLength; i++)
                {
                    Rectangle slot = new Rectangle(pegsX + i * (pegSize + PegGap), y, pegSize, pegSize);
                    r.DrawPegWithBorder(attempt.Pegs[i], attempt.Results[i], slot);
                }
            }

            DrawLegend(r);
        }

        // Leyenda de los aros, cada parte escrita en su color.
        private void DrawLegend(Renderer r)
        {
            string[] parts = { "Verde: lugar correcto", "Amarillo: otro lugar", "Rojo: no está" };
            Color[] colors = { Renderer.ExactBorderColor, Renderer.PresentBorderColor, Renderer.AbsentBorderColor };
            string separator = "  ·  ";

            float x = HistoryX;
            for (int i = 0; i < parts.Length; i++)
            {
                r.DrawText(r.SmallFont, parts[i], x, LegendY, colors[i]);
                x += r.SmallFont.MeasureString(parts[i]).X;
                if (i < parts.Length - 1)
                {
                    r.DrawText(r.SmallFont, separator, x, LegendY, Renderer.DimTextColor);
                    x += r.SmallFont.MeasureString(separator).X;
                }
            }
        }

        private void DrawCurrentGuess(Renderer r)
        {
            int attemptNumber = session.History.Count() + 1;
            r.DrawText(r.RegularFont, "Intento actual (" + attemptNumber + " de " + session.MaxLives + ")", RightX, RightTitleY, Renderer.DimTextColor);

            for (int i = 0; i < session.CodeLength; i++)
            {
                Rectangle slot = new Rectangle(RightX + i * (CurrentSlotSize + CurrentSlotGap), CurrentY, CurrentSlotSize, CurrentSlotSize);
                if (i < session.CurrentCount)
                {
                    r.DrawPeg(session.GetGuessAt(i), slot);
                }
                else
                {
                    r.DrawEmptySlot(slot);
                }

                if (i == cursorSlot)
                {
                    Rectangle cursor = new Rectangle(slot.X + (slot.Width - CursorSize) / 2, slot.Bottom + CursorGap, CursorSize, CursorSize);
                    r.DrawCursor(cursor, "^");
                }
            }
        }

        private void DrawPalette(Renderer r)
        {
            r.DrawText(r.RegularFont, "Paleta de colores", RightX, PaletteTitleY, Renderer.DimTextColor);
            for (int i = 0; i < Palette.ColorCount; i++)
            {
                int y = PaletteY + i * PaletteRowHeight;
                PegColor color = (PegColor)i;
                bool selected = i == selectedColor;

                r.DrawPeg(color, new Rectangle(PaletteSlotX, y, PaletteSlotSize, PaletteSlotSize));
                float nameY = y + (PaletteSlotSize - r.RegularFont.LineSpacing) / 2f;
                r.DrawText(r.RegularFont, Palette.GetName(color), PaletteSlotX + PaletteSlotSize + PaletteNameGap, nameY, selected ? Renderer.HighlightColor : Renderer.TextColor);

                if (selected)
                {
                    Rectangle cursor = new Rectangle(RightX + CursorGap, y + (PaletteSlotSize - CursorSize) / 2, CursorSize, CursorSize);
                    r.DrawCursor(cursor, ">");
                }
            }
        }
    }
}
