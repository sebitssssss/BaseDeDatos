using System;
using System.IO;
using CodeBreaker.Models;

namespace CodeBreaker.Data
{
    // Lee y escribe config.conf, un archivo de texto con líneas clave=valor.
    // Lectura con StreamReader y escritura con StreamWriter.
    public class ConfigManager
    {
        public const string FileName = "config.conf";
        private const string CommentMark = "#";
        private const char Separator = '=';

        // Claves de los sprites de cada color, en el mismo orden que el enum PegColor.
        private static readonly string[] ColorSpriteKeys =
        {
            "sprite_red", "sprite_blue", "sprite_green", "sprite_yellow", "sprite_orange", "sprite_purple"
        };

        private readonly string filePath;

        public GameConfig Config { get; private set; }
        public string Warning { get; private set; } // "" si no hubo problemas

        public ConfigManager(string folder)
        {
            filePath = Path.Combine(folder, FileName);
            Config = new GameConfig();
            Warning = "";
        }

        // Carga la configuración. Si el archivo no existe, lo crea con valores por defecto.
        public void Load()
        {
            Config = new GameConfig();
            Warning = "";

            if (!File.Exists(filePath))
            {
                Save(); // se crea con los valores por defecto; solo avisa si no puede escribirlo
                return;
            }

            try
            {
                using (StreamReader reader = new StreamReader(filePath))
                {
                    int lineNumber = 1;
                    string line = reader.ReadLine();
                    while (line != null) // ReadLine devuelve null al llegar al final
                    {
                        ProcessLine(line, lineNumber);
                        line = reader.ReadLine();
                        lineNumber++;
                    }
                }
            }
            catch (Exception ex)
            {
                Config = new GameConfig();
                AddWarning("No se pudo leer config.conf (" + ex.Message + "): se usan valores por defecto.");
                return;
            }

            Validate();
        }

        // Escribe config.conf con los valores actuales. Devuelve false si no pudo.
        public bool Save()
        {
            try
            {
                using (StreamWriter writer = new StreamWriter(filePath))
                {
                    writer.WriteLine("# Code Breaker - archivo de configuracion (formato clave=valor)");
                    writer.WriteLine("# Las lineas que empiezan con # son comentarios.");
                    writer.WriteLine("# Si este archivo se borra, el juego lo vuelve a crear con estos valores.");
                    writer.WriteLine();
                    writer.WriteLine("# --- Conexion a MySQL (base de la materia Base de Datos) ---");
                    writer.WriteLine("db_server=" + Config.DbServer);
                    writer.WriteLine("db_port=" + Config.DbPort);
                    writer.WriteLine("db_name=" + Config.DbName);
                    writer.WriteLine("db_user=" + Config.DbUser);
                    writer.WriteLine("db_password=" + Config.DbPassword);
                    writer.WriteLine();
                    writer.WriteLine("# --- Reglas del juego ---");
                    writer.WriteLine("# Longitud del codigo secreto (de " + GameConfig.MinCodeLength + " a " + GameConfig.MaxCodeLength + ")");
                    writer.WriteLine("code_length=" + Config.CodeLength);
                    writer.WriteLine("# Vidas (de " + GameConfig.MinLives + " a " + GameConfig.MaxLives + "): cada intento que no acierta resta una");
                    writer.WriteLine("lives=" + Config.Lives);
                    writer.WriteLine("# Puntaje al ganar = vidas * points_per_life + max(0, time_bonus_max - segundos)");
                    writer.WriteLine("points_per_life=" + Config.PointsPerLife);
                    writer.WriteLine("time_bonus_max=" + Config.TimeBonusMax);
                    writer.WriteLine("# true muestra el codigo secreto durante la partida (solo para las pruebas en clase)");
                    writer.WriteLine("debug_show_secret=" + (Config.DebugShowSecret ? "true" : "false"));
                    writer.WriteLine();
                    writer.WriteLine("# --- Sprites de Content/Sprites: nombre de un PNG suelto o de una SubTexture de un XML ---");
                    writer.WriteLine("# Primero se busca el nombre exacto; si no aparece, el primer nombre que contenga el texto.");
                    writer.WriteLine("# Ver assets/README.md para poner los nombres exactos del pack descargado.");
                    for (int i = 0; i < Palette.ColorCount; i++)
                    {
                        writer.WriteLine(ColorSpriteKeys[i] + "=" + Config.ColorSprites[i]);
                    }
                    writer.WriteLine("# Aro de cada ficha del historial: verde = lugar correcto, amarillo = otro lugar, rojo = no esta");
                    writer.WriteLine("sprite_frame_exact=" + Config.FrameExactSprite);
                    writer.WriteLine("sprite_frame_present=" + Config.FramePresentSprite);
                    writer.WriteLine("sprite_frame_absent=" + Config.FrameAbsentSprite);
                    writer.WriteLine("sprite_cursor=" + Config.CursorSprite);
                    writer.WriteLine("sprite_empty=" + Config.EmptySprite);
                }
                return true;
            }
            catch (Exception ex)
            {
                AddWarning("No se pudo escribir config.conf (" + ex.Message + ").");
                return false;
            }
        }

        // Interpreta una línea "clave=valor". Ignora líneas vacías y comentarios.
        private void ProcessLine(string line, int lineNumber)
        {
            string text = line.Trim();
            if (text.Length == 0 || text.StartsWith(CommentMark))
            {
                return;
            }

            int separatorIndex = text.IndexOf(Separator);
            if (separatorIndex <= 0)
            {
                AddWarning("config.conf, línea " + lineNumber + ": falta el '='.");
                return;
            }

            string key = text.Substring(0, separatorIndex).Trim().ToLowerInvariant();
            string value = text.Substring(separatorIndex + 1).Trim();

            switch (key)
            {
                case "db_server": Config.DbServer = value; break;
                case "db_port": Config.DbPort = ParseInt(key, value, GameConfig.DefaultDbPort); break;
                case "db_name": Config.DbName = value; break;
                case "db_user": Config.DbUser = value; break;
                case "db_password": Config.DbPassword = value; break;
                case "code_length": Config.CodeLength = ParseInt(key, value, GameConfig.DefaultCodeLength); break;
                case "lives": Config.Lives = ParseInt(key, value, GameConfig.DefaultLives); break;
                case "points_per_life": Config.PointsPerLife = ParseInt(key, value, GameConfig.DefaultPointsPerLife); break;
                case "time_bonus_max": Config.TimeBonusMax = ParseInt(key, value, GameConfig.DefaultTimeBonusMax); break;
                case "debug_show_secret": Config.DebugShowSecret = value.ToLowerInvariant() == "true"; break;
                case "sprite_frame_exact": Config.FrameExactSprite = value; break;
                case "sprite_frame_present": Config.FramePresentSprite = value; break;
                case "sprite_frame_absent": Config.FrameAbsentSprite = value; break;
                case "sprite_cursor": Config.CursorSprite = value; break;
                case "sprite_empty": Config.EmptySprite = value; break;
                default:
                    int colorIndex = FindColorKey(key);
                    if (colorIndex >= 0)
                    {
                        Config.ColorSprites[colorIndex] = value;
                    }
                    else
                    {
                        AddWarning("config.conf: la clave '" + key + "' no se conoce y se ignora.");
                    }
                    break;
            }
        }

        // Convierte un texto a número. Si no es un número, avisa y devuelve el valor por defecto.
        private int ParseInt(string key, string value, int defaultValue)
        {
            int number;
            if (int.TryParse(value, out number))
            {
                return number;
            }
            AddWarning("config.conf: '" + key + "' no es un número; se usa " + defaultValue + ".");
            return defaultValue;
        }

        // Busca la clave en la lista de sprites de colores (búsqueda lineal en un array chico).
        private int FindColorKey(string key)
        {
            for (int i = 0; i < ColorSpriteKeys.Length; i++)
            {
                if (ColorSpriteKeys[i] == key)
                {
                    return i;
                }
            }
            return -1;
        }

        // Controla que los números estén dentro de los rangos permitidos.
        private void Validate()
        {
            if (Config.CodeLength < GameConfig.MinCodeLength || Config.CodeLength > GameConfig.MaxCodeLength)
            {
                AddWarning("code_length debe ir de " + GameConfig.MinCodeLength + " a " + GameConfig.MaxCodeLength + "; se usa " + GameConfig.DefaultCodeLength + ".");
                Config.CodeLength = GameConfig.DefaultCodeLength;
            }
            if (Config.Lives < GameConfig.MinLives || Config.Lives > GameConfig.MaxLives)
            {
                AddWarning("lives debe ir de " + GameConfig.MinLives + " a " + GameConfig.MaxLives + "; se usa " + GameConfig.DefaultLives + ".");
                Config.Lives = GameConfig.DefaultLives;
            }
            if (Config.PointsPerLife < 0)
            {
                AddWarning("points_per_life no puede ser negativo; se usa " + GameConfig.DefaultPointsPerLife + ".");
                Config.PointsPerLife = GameConfig.DefaultPointsPerLife;
            }
            if (Config.TimeBonusMax < 0)
            {
                AddWarning("time_bonus_max no puede ser negativo; se usa " + GameConfig.DefaultTimeBonusMax + ".");
                Config.TimeBonusMax = GameConfig.DefaultTimeBonusMax;
            }
            if (Config.DbPort < GameConfig.MinPort || Config.DbPort > GameConfig.MaxPort)
            {
                AddWarning("db_port no es un puerto válido; se usa " + GameConfig.DefaultDbPort + ".");
                Config.DbPort = GameConfig.DefaultDbPort;
            }
        }

        // Junta los avisos en un solo texto para mostrarlo en el menú.
        private void AddWarning(string text)
        {
            if (Warning.Length == 0)
            {
                Warning = text;
            }
            else
            {
                Warning = Warning + " " + text;
            }
        }
    }
}
