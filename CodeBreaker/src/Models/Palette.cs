using Microsoft.Xna.Framework;

namespace CodeBreaker.Models
{
    // Datos fijos de la paleta: cantidad de colores, nombres en español y color para los textos.
    public static class Palette
    {
        public const int ColorCount = 6;

        // Nombre completo que se muestra en la paleta.
        public static string GetName(PegColor color)
        {
            switch (color)
            {
                case PegColor.Red: return "Rojo";
                case PegColor.Blue: return "Azul";
                case PegColor.Green: return "Verde";
                case PegColor.Yellow: return "Amarillo";
                case PegColor.Orange: return "Naranja";
                case PegColor.Purple: return "Morado";
                default: return "?";
            }
        }

        // Abreviatura de 2 letras. Se dibuja solo si falta el sprite de ese color.
        public static string GetShortName(PegColor color)
        {
            switch (color)
            {
                case PegColor.Red: return "Ro";
                case PegColor.Blue: return "Az";
                case PegColor.Green: return "Ve";
                case PegColor.Yellow: return "Am";
                case PegColor.Orange: return "Na";
                case PegColor.Purple: return "Mo";
                default: return "?";
            }
        }

        // Color con el que se escribe la abreviatura (tonos claros para que se lean sobre el fondo).
        public static Color GetTextColor(PegColor color)
        {
            switch (color)
            {
                case PegColor.Red: return new Color(240, 80, 80);
                case PegColor.Blue: return new Color(90, 150, 255);
                case PegColor.Green: return new Color(90, 210, 100);
                case PegColor.Yellow: return new Color(245, 225, 70);
                case PegColor.Orange: return new Color(255, 155, 45);
                case PegColor.Purple: return new Color(195, 120, 240);
                default: return Color.White;
            }
        }
    }
}
