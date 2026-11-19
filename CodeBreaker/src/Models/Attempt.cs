namespace CodeBreaker.Models
{
    // Un intento ya confirmado: los colores que eligió el jugador y el resultado de cada ficha.
    // Es el dato que se guarda en la cola circular del historial.
    public class Attempt
    {
        public int Number { get; private set; }         // 1 = primer intento de la partida
        public PegColor[] Pegs { get; private set; }    // colores elegidos (copia)
        public PegResult[] Results { get; private set; } // resultado de cada ficha: verde, amarillo o rojo
        public int ExactCount { get; private set; }      // cuántas fichas tienen borde verde
        public int PresentCount { get; private set; }    // cuántas fichas tienen borde amarillo

        public Attempt(int number, PegColor[] guess, PegResult[] results, int length)
        {
            Number = number;
            // Se copian los arrays porque el intento en curso se reutiliza en la jugada siguiente.
            Pegs = new PegColor[length];
            Results = new PegResult[length];
            ExactCount = 0;
            PresentCount = 0;
            for (int i = 0; i < length; i++)
            {
                Pegs[i] = guess[i];
                Results[i] = results[i];
                if (results[i] == PegResult.Exact)
                {
                    ExactCount++;
                }
                else if (results[i] == PegResult.Present)
                {
                    PresentCount++;
                }
            }
        }
    }
}
