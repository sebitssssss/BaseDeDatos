namespace CodeBreaker.Models
{
    // Todos los valores que se leen de config.conf.
    // Si una clave falta o es inválida, queda el valor por defecto.
    public class GameConfig
    {
        // ----- Valores por defecto (constantes: sin números mágicos en el código) -----
        public const string DefaultDbServer = "localhost";
        public const int DefaultDbPort = 3306;
        public const string DefaultDbName = "codigo_secreto_db";
        public const string DefaultDbUser = "root";
        public const string DefaultDbPassword = "";

        public const int DefaultCodeLength = 4;
        public const int DefaultLives = 8;
        public const int DefaultPointsPerLife = 100;
        public const int DefaultTimeBonusMax = 300;

        // ----- Límites aceptados (la pantalla está pensada para estos rangos) -----
        public const int MinCodeLength = 2;
        public const int MaxCodeLength = 6;
        public const int MinLives = 1;
        public const int MaxLives = 12;
        public const int MinPort = 1;
        public const int MaxPort = 65535;

        // ----- Sprites por defecto: los PNG de Content/Sprites -----
        // Mismo orden que el enum PegColor: rojo, azul, verde, amarillo, naranja, morado.
        public static readonly string[] DefaultColorSprites = { "rojo.png", "azul.png", "verde.png", "amarillo.png", "naranja.png", "morado.png" };
        public const string DefaultFrameExactSprite = "aro_verde.png";     // lugar correcto
        public const string DefaultFramePresentSprite = "aro_amarillo.png"; // está en otro lugar
        public const string DefaultFrameAbsentSprite = "aro_rojo.png";      // no está
        public const string DefaultCursorSprite = "";
        public const string DefaultEmptySprite = "";

        // ----- Conexión a MySQL -----
        public string DbServer { get; set; }
        public int DbPort { get; set; }
        public string DbName { get; set; }
        public string DbUser { get; set; }
        public string DbPassword { get; set; }

        // ----- Reglas del juego -----
        public int CodeLength { get; set; }
        public int Lives { get; set; }
        public int PointsPerLife { get; set; }
        public int TimeBonusMax { get; set; }
        public bool DebugShowSecret { get; set; }

        // ----- Sprites -----
        public string[] ColorSprites { get; private set; } // uno por color de la paleta
        public string FrameExactSprite { get; set; }       // aro verde: lugar correcto
        public string FramePresentSprite { get; set; }     // aro amarillo: está en otro lugar
        public string FrameAbsentSprite { get; set; }      // aro rojo: no está
        public string CursorSprite { get; set; }
        public string EmptySprite { get; set; }

        // Crea una configuración con todos los valores por defecto.
        public GameConfig()
        {
            DbServer = DefaultDbServer;
            DbPort = DefaultDbPort;
            DbName = DefaultDbName;
            DbUser = DefaultDbUser;
            DbPassword = DefaultDbPassword;

            CodeLength = DefaultCodeLength;
            Lives = DefaultLives;
            PointsPerLife = DefaultPointsPerLife;
            TimeBonusMax = DefaultTimeBonusMax;
            DebugShowSecret = false;

            ColorSprites = new string[Palette.ColorCount];
            for (int i = 0; i < Palette.ColorCount; i++)
            {
                ColorSprites[i] = DefaultColorSprites[i];
            }
            FrameExactSprite = DefaultFrameExactSprite;
            FramePresentSprite = DefaultFramePresentSprite;
            FrameAbsentSprite = DefaultFrameAbsentSprite;
            CursorSprite = DefaultCursorSprite;
            EmptySprite = DefaultEmptySprite;
        }
    }
}
