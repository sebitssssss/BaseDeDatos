using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Input;
using CodeBreaker.Data;

namespace CodeBreaker.Screens
{
    // Menú: nombre del jugador, estado de MySQL y opciones Jugar / Ranking / Salir.
    public class MenuScreen
    {
        public const int MaxNameLength = 12;
        private const int OptionPlay = 0;
        private const int OptionRanking = 1;
        private const int OptionExit = 2;
        private static readonly string[] OptionTexts = { "Jugar", "Ranking", "Salir" };

        // Posiciones en pantalla (en píxeles)
        private const int TitleY = 45;
        private const int NameLabelY = 150;
        private const int NameY = 190;
        private const int OptionsY = 280;
        private const int OptionHeight = 48;
        private const int MessageY = 430;
        private const int DatabaseY = 545;
        private const int TextLeft = 140;
        private const int TextWidth = 1000;
        private const int HintY = 690;

        private string playerName = "";
        private int selectedOption = OptionPlay;
        private string message = "";

        public bool ExitRequested { get; private set; }

        // Nombre sin espacios al principio ni al final.
        public string PlayerName
        {
            get { return playerName.Trim(); }
        }

        // Recibe cada carácter escrito (evento TextInput de la ventana).
        public void OnCharacterTyped(char character)
        {
            bool allowed = char.IsLetterOrDigit(character) || character == ' ' || character == '_' || character == '-';
            if (allowed && playerName.Length < MaxNameLength)
            {
                playerName += character;
                message = "";
            }
        }

        // Devuelve el estado al que hay que pasar (o Menu para quedarse).
        public GameState Update(InputHelper input, DatabaseService database)
        {
            // Delete o Retroceso borran la última letra del nombre.
            bool erase = input.WasPressed(Keys.Delete) || input.WasPressed(Keys.Back);
            if (erase && playerName.Length > 0)
            {
                playerName = playerName.Substring(0, playerName.Length - 1);
            }
            if (input.WasPressed(Keys.Up))
            {
                selectedOption = (selectedOption + OptionTexts.Length - 1) % OptionTexts.Length;
            }
            if (input.WasPressed(Keys.Down))
            {
                selectedOption = (selectedOption + 1) % OptionTexts.Length;
            }
            if (input.WasPressed(Keys.F5))
            {
                database.TestConnection(); // reintentar la conexión a MySQL
            }

            if (input.WasPressed(Keys.Enter))
            {
                if (selectedOption == OptionPlay)
                {
                    if (PlayerName.Length == 0)
                    {
                        message = "Escribí tu nombre antes de jugar.";
                        return GameState.Menu;
                    }
                    message = "";
                    return GameState.Playing;
                }
                if (selectedOption == OptionRanking)
                {
                    return GameState.Ranking;
                }
                if (selectedOption == OptionExit)
                {
                    ExitRequested = true;
                }
            }
            return GameState.Menu;
        }

        public void Draw(Renderer r, DatabaseService database, string warnings)
        {
            r.DrawCentered(r.TitleFont, "CODE BREAKER", TitleY, Renderer.HighlightColor);

            r.DrawCentered(r.RegularFont, "Nombre del jugador (escribilo con el teclado):", NameLabelY, Renderer.TextColor);
            r.DrawCentered(r.TitleFont, playerName, NameY, Renderer.TextColor);

            for (int i = 0; i < OptionTexts.Length; i++)
            {
                bool selected = i == selectedOption;
                string text = selected ? "> " + OptionTexts[i] + " <" : OptionTexts[i];
                r.DrawCentered(r.RegularFont, text, OptionsY + i * OptionHeight, selected ? Renderer.HighlightColor : Renderer.TextColor);
            }

            if (message.Length > 0)
            {
                r.DrawCentered(r.RegularFont, message, MessageY, Renderer.BadColor);
            }

            // Estado de la conexión a MySQL
            Color databaseColor = Renderer.DimTextColor;
            if (database.WasChecked)
            {
                databaseColor = database.IsConnected ? Renderer.GoodColor : Renderer.BadColor;
            }
            r.DrawCentered(r.RegularFont, "MySQL: " + database.StatusText, DatabaseY, databaseColor);

            float y = DatabaseY + r.RegularFont.LineSpacing + 4;
            if (database.WasChecked && !database.IsConnected)
            {
                string reason = "Motivo: " + database.ErrorDetail;
                if (r.SmallFont.MeasureString(reason).X <= TextWidth)
                {
                    r.DrawCentered(r.SmallFont, reason, y, Renderer.DimTextColor); // entra en un renglón: centrado
                    y += r.SmallFont.LineSpacing;
                }
                else
                {
                    y = r.DrawWrapped(r.SmallFont, reason, TextLeft, y, TextWidth, 2, Renderer.DimTextColor);
                }
            }

            // Solo hay avisos si algo falló de verdad (config.conf con errores, puntajes.dat dañado,
            // un spritesheet que no se pudo leer o un sprite que no está en el XML).
            if (warnings.Length > 0)
            {
                r.DrawWrapped(r.SmallFont, "Avisos: " + warnings, TextLeft, y + 6, TextWidth, 3, Renderer.HighlightColor);
            }

            r.DrawCentered(r.SmallFont, "Teclado: escribí tu nombre · Arriba/Abajo: elegir · Enter: aceptar · Delete: borrar letra", HintY, Renderer.DimTextColor);
        }
    }
}
