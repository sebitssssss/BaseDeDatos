using System;

namespace CodeBreaker
{
    // Punto de entrada del programa: crea el juego y lo ejecuta.
    public static class Program
    {
        [STAThread]
        public static void Main()
        {
            // "using" libera los recursos del juego (ventana, texturas) al cerrarlo.
            using (Game1 game = new Game1())
            {
                game.Run();
            }
        }
    }
}
