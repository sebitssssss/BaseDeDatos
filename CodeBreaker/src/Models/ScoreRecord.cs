using System;

namespace CodeBreaker.Models
{
    // Un registro de puntajes.dat: una partida ganada.
    public class ScoreRecord
    {
        public string PlayerName { get; private set; }
        public int Score { get; private set; }
        public int LivesLeft { get; private set; }
        public int Seconds { get; private set; }
        public DateTime Date { get; private set; }

        public ScoreRecord(string playerName, int score, int livesLeft, int seconds, DateTime date)
        {
            PlayerName = playerName;
            Score = score;
            LivesLeft = livesLeft;
            Seconds = seconds;
            Date = date;
        }
    }
}
