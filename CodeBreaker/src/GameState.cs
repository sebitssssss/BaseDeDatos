namespace CodeBreaker
{
    // Pantallas (estados) del juego.
    // Game1 actualiza y dibuja solamente la pantalla del estado actual.
    public enum GameState
    {
        Menu,     // ingreso del nombre, estado de MySQL y opciones Jugar / Ranking / Salir
        Playing,  // la partida en curso
        GameOver, // resultado, código revelado, puntaje y repetición de la partida
        Ranking   // top 10 leído de puntajes.dat
    }
}
