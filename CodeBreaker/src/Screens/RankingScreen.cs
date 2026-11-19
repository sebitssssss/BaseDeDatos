using Microsoft.Xna.Framework.Input;
using CodeBreaker.Data;
using CodeBreaker.Models;

namespace CodeBreaker.Screens
{
    // Ranking: top 10 de puntajes.dat, ya ordenado con burbuja al entrar a esta pantalla.
    public class RankingScreen
    {
        public const int TopCount = 10;

        // Posiciones en pantalla (en píxeles)
        private const int TitleY = 35;
        private const int SubtitleY = 85;
        private const int HeaderY = 130;
        private const int FirstRowY = 172;
        private const int RowHeight = 42;
        private const int PositionX = 150;
        private const int NameX = 210;
        private const int ScoreX = 520;
        private const int LivesX = 670;
        private const int TimeX = 790;
        private const int DateX = 920;
        private const int EmptyY = 300;
        private const int WarningY = 610;
        private const int WarningLeft = 140;
        private const int WarningWidth = 1000;
        private const int HintY = 690;

        public GameState Update(InputHelper input)
        {
            if (input.WasPressed(Keys.Enter) || input.WasPressed(Keys.Escape) || input.WasPressed(Keys.Back))
            {
                return GameState.Menu;
            }
            return GameState.Ranking;
        }

        public void Draw(Renderer r, ScoreFile scoreFile)
        {
            r.DrawCentered(r.TitleFont, "RANKING - TOP " + TopCount, TitleY, Renderer.HighlightColor);
            r.DrawCentered(r.SmallFont, "Orden: mayor puntaje primero; si empatan, el de menor tiempo", SubtitleY, Renderer.DimTextColor);

            r.DrawText(r.RegularFont, "#", PositionX, HeaderY, Renderer.DimTextColor);
            r.DrawText(r.RegularFont, "Jugador", NameX, HeaderY, Renderer.DimTextColor);
            r.DrawText(r.RegularFont, "Puntaje", ScoreX, HeaderY, Renderer.DimTextColor);
            r.DrawText(r.RegularFont, "Vidas", LivesX, HeaderY, Renderer.DimTextColor);
            r.DrawText(r.RegularFont, "Tiempo", TimeX, HeaderY, Renderer.DimTextColor);
            r.DrawText(r.RegularFont, "Fecha", DateX, HeaderY, Renderer.DimTextColor);

            int rows = scoreFile.Count < TopCount ? scoreFile.Count : TopCount;
            if (rows == 0)
            {
                r.DrawCentered(r.RegularFont, "Todavía no hay partidas ganadas.", EmptyY, Renderer.TextColor);
            }

            for (int i = 0; i < rows; i++)
            {
                ScoreRecord record = scoreFile.GetAt(i);
                int y = FirstRowY + i * RowHeight;
                r.DrawText(r.RegularFont, (i + 1).ToString(), PositionX, y, Renderer.TextColor);
                r.DrawText(r.RegularFont, record.PlayerName, NameX, y, Renderer.TextColor);
                r.DrawText(r.RegularFont, record.Score.ToString(), ScoreX, y, Renderer.HighlightColor);
                r.DrawText(r.RegularFont, record.LivesLeft.ToString(), LivesX, y, Renderer.TextColor);
                r.DrawText(r.RegularFont, Renderer.FormatTime(record.Seconds), TimeX, y, Renderer.TextColor);
                r.DrawText(r.RegularFont, record.Date.ToString("dd/MM/yyyy HH:mm"), DateX, y, Renderer.TextColor);
            }

            // Solo aparece si puntajes.dat está dañado o no se pudo guardar.
            if (scoreFile.Warning.Length > 0)
            {
                r.DrawWrapped(r.SmallFont, "Aviso: " + scoreFile.Warning, WarningLeft, WarningY, WarningWidth, 2, Renderer.HighlightColor);
            }
            r.DrawCentered(r.SmallFont, "Enter o Esc: volver al menú", HintY, Renderer.DimTextColor);
        }
    }
}
