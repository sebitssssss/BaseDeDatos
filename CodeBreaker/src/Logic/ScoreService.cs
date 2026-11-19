namespace CodeBreaker.Logic
{
    // Calcula el puntaje. Solo hay puntaje al ganar:
    //   puntaje = vidasRestantes * puntosPorVida + max(0, bonoMaximo - segundosJugados)
    // Con los valores por defecto: vidas * 100 + max(0, 300 - segundos). Al perder, 0.
    public class ScoreService
    {
        private readonly int pointsPerLife; // points_per_life de config.conf
        private readonly int timeBonusMax;  // time_bonus_max de config.conf

        public ScoreService(int pointsPerLife, int timeBonusMax)
        {
            this.pointsPerLife = pointsPerLife;
            this.timeBonusMax = timeBonusMax;
        }

        public int Calculate(int livesLeft, int secondsPlayed, bool won)
        {
            if (!won)
            {
                return 0;
            }
            int timeBonus = timeBonusMax - secondsPlayed;
            if (timeBonus < 0)
            {
                timeBonus = 0; // max(0, ...)
            }
            return livesLeft * pointsPerLife + timeBonus;
        }
    }
}
