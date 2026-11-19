using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Input;
using CodeBreaker.Logic;
using CodeBreaker.Models;

namespace CodeBreaker.Screens
{
    // Fin de la partida: resultado, código secreto, puntaje y repetición de la partida.
    // La repetición usa Dequeue: cada segundo sale de la cola el intento más viejo y se muestra.
    public class GameOverScreen
    {
        private const double ReplayStepSeconds = 1.0;
        private const int OptionPlayAgain = 0;
        private const int OptionMenu = 1;
        private static readonly string[] OptionTexts = { "Volver a jugar", "Menú" };

        // Posiciones en pantalla (en píxeles)
        private const int TitleY = 30;
        private const int SubtitleY = 85;
        private const int SecretLabelY = 130;
        private const int SecretY = 165;
        private const int SecretSize = 70;
        private const int SecretGap = 14;
        private const int ScoreY = 255;
        private const int DetailY = 290;
        private const int SaveY = 318;
        private const int ReplayTitleY = 365;
        private const int ReplayRowY = 405;
        private const int ReplayPegSize = 60;
        private const int ReplayGap = 10;
        private const int ReplayStatusY = 480;
        private const int OptionsY = 545;
        private const int OptionHeight = 44;
        private const int HintY = 690;

        private GameSession session;
        private Attempt replayAttempt; // último intento que salió de la cola
        private int replayTotal;       // cuántos intentos tenía la cola al empezar
        private double replayTimer;
        private int selectedOption;
        private string saveMessage = ""; // solo tiene texto si no se pudo guardar

        // Se llama al entrar a esta pantalla.
        public void Show(GameSession finishedSession, string saveErrorMessage)
        {
            session = finishedSession;
            replayAttempt = null;
            replayTotal = session.History.Count();
            replayTimer = ReplayStepSeconds; // el primer intento se muestra enseguida
            selectedOption = OptionPlayAgain;
            saveMessage = saveErrorMessage;
        }

        public GameState Update(GameTime gameTime, InputHelper input)
        {
            UpdateReplay(gameTime.ElapsedGameTime.TotalSeconds);

            if (input.WasPressed(Keys.Up) || input.WasPressed(Keys.Down))
            {
                selectedOption = selectedOption == OptionPlayAgain ? OptionMenu : OptionPlayAgain;
            }
            if (input.WasPressed(Keys.Escape))
            {
                return GameState.Menu;
            }
            if (input.WasPressed(Keys.Enter))
            {
                return selectedOption == OptionPlayAgain ? GameState.Playing : GameState.Menu;
            }
            return GameState.GameOver;
        }

        // Cada segundo se desencola un intento (orden cronológico: FIFO).
        private void UpdateReplay(double elapsedSeconds)
        {
            if (session.History.IsEmpty())
            {
                return; // ya salieron todos
            }
            replayTimer += elapsedSeconds;
            if (replayTimer < ReplayStepSeconds)
            {
                return;
            }
            replayTimer = 0;

            Attempt next;
            if (session.History.Dequeue(out next))
            {
                replayAttempt = next;
            }
        }

        public void Draw(Renderer r)
        {
            if (session.IsWon)
            {
                r.DrawCentered(r.TitleFont, "¡GANASTE!", TitleY, Renderer.GoodColor);
                r.DrawCentered(r.RegularFont, "Descifraste el código en " + replayTotal + " intento(s).", SubtitleY, Renderer.TextColor);
            }
            else
            {
                r.DrawCentered(r.TitleFont, "GAME OVER", TitleY, Renderer.BadColor);
                r.DrawCentered(r.RegularFont, "Te quedaste sin vidas.", SubtitleY, Renderer.TextColor);
            }

            // Código secreto revelado
            r.DrawCentered(r.RegularFont, "Código secreto:", SecretLabelY, Renderer.DimTextColor);
            PegColor[] secret = new PegColor[session.CodeLength];
            for (int i = 0; i < session.CodeLength; i++)
            {
                secret[i] = session.GetSecretAt(i);
            }
            int secretX = (Renderer.ScreenWidth - Renderer.RowWidth(session.CodeLength, SecretSize, SecretGap)) / 2;
            r.DrawPegRow(secret, session.CodeLength, secretX, SecretY, SecretSize, SecretGap);

            // Puntaje
            r.DrawCentered(r.RegularFont, "Puntaje: " + session.FinalScore, ScoreY, Renderer.HighlightColor);
            r.DrawCentered(r.SmallFont, "Vidas restantes: " + session.Lives + " · Tiempo: " + Renderer.FormatTime(session.SecondsPlayed) + " · Intentos: " + replayTotal, DetailY, Renderer.DimTextColor);
            if (saveMessage.Length > 0)
            {
                r.DrawCentered(r.SmallFont, saveMessage, SaveY, Renderer.HighlightColor); // solo si falló el guardado
            }

            DrawReplay(r);

            for (int i = 0; i < OptionTexts.Length; i++)
            {
                bool selected = i == selectedOption;
                string text = selected ? "> " + OptionTexts[i] + " <" : OptionTexts[i];
                r.DrawCentered(r.RegularFont, text, OptionsY + i * OptionHeight, selected ? Renderer.HighlightColor : Renderer.TextColor);
            }
            r.DrawCentered(r.SmallFont, "Arriba/Abajo: elegir · Enter: aceptar · Esc: menú", HintY, Renderer.DimTextColor);
        }

        // Muestra el último intento que salió de la cola, centrado, con el borde de cada ficha.
        private void DrawReplay(Renderer r)
        {
            r.DrawCentered(r.RegularFont, "Repetición de la partida", ReplayTitleY, Renderer.TextColor);

            if (replayAttempt != null)
            {
                int rowWidth = Renderer.RowWidth(session.CodeLength, ReplayPegSize, ReplayGap);
                int startX = (Renderer.ScreenWidth - rowWidth) / 2;
                for (int i = 0; i < session.CodeLength; i++)
                {
                    Rectangle slot = new Rectangle(startX + i * (ReplayPegSize + ReplayGap), ReplayRowY, ReplayPegSize, ReplayPegSize);
                    r.DrawPegWithBorder(replayAttempt.Pegs[i], replayAttempt.Results[i], slot);
                }
            }

            // Mientras la cola tiene intentos, se indica cuántos faltan. Al vaciarse no se muestra nada.
            if (!session.History.IsEmpty())
            {
                r.DrawCentered(r.SmallFont, "Quedan " + session.History.Count() + " intento(s) en la cola.", ReplayStatusY, Renderer.DimTextColor);
            }
        }
    }
}
