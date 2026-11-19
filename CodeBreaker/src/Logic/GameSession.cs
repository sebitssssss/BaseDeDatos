using CodeBreaker.Models;

namespace CodeBreaker.Logic
{
    // La partida en curso: código secreto, intento actual, historial, vidas, tiempo y resultado.
    public class GameSession
    {
        private readonly CodeGenerator codeGenerator;
        private readonly ScoreService scoreService;

        private PegColor[] secretCode;
        private readonly PegColor[] currentGuess; // intento en curso: un array simple...
        private int currentCount;                 // ...y su índice (cuántas fichas tiene puestas)
        private double elapsedSeconds;

        public string PlayerName { get; private set; }
        public int CodeLength { get; private set; }
        public int MaxLives { get; private set; }
        public int Lives { get; private set; }
        public bool IsFinished { get; private set; }
        public bool IsWon { get; private set; }
        public int FinalScore { get; private set; }
        public CircularQueue History { get; private set; } // historial en orden (FIFO)
        public string Warning { get; private set; }

        public GameSession(GameConfig config, CodeGenerator codeGenerator, ScoreService scoreService)
        {
            this.codeGenerator = codeGenerator;
            this.scoreService = scoreService;
            CodeLength = config.CodeLength;
            MaxLives = config.Lives;
            currentGuess = new PegColor[CodeLength];
            secretCode = new PegColor[CodeLength];
            History = new CircularQueue(MaxLives); // capacidad = cantidad de vidas
            PlayerName = "";
            Warning = "";
        }

        // Empieza una partida nueva: código nuevo, vidas completas e historial vacío.
        public void StartNew(string playerName)
        {
            PlayerName = playerName;
            secretCode = codeGenerator.Generate(CodeLength);
            History.Clear();
            currentCount = 0;
            Lives = MaxLives;
            elapsedSeconds = 0;
            IsFinished = false;
            IsWon = false;
            FinalScore = 0;
            Warning = "";
        }

        public int CurrentCount
        {
            get { return currentCount; }
        }

        public int SecondsPlayed
        {
            get { return (int)elapsedSeconds; }
        }

        public PegColor GetGuessAt(int position)
        {
            return currentGuess[position];
        }

        public PegColor GetSecretAt(int position)
        {
            return secretCode[position];
        }

        public bool IsGuessComplete()
        {
            return currentCount == CodeLength;
        }

        // Suma tiempo solo mientras la partida no terminó.
        public void AddTime(double seconds)
        {
            if (!IsFinished)
            {
                elapsedSeconds += seconds;
            }
        }

        // Puntaje que se obtendría si se ganara en este momento (se muestra durante la partida).
        public int PotentialScore()
        {
            return scoreService.Calculate(Lives, SecondsPlayed, true);
        }

        // Pone un color en una posición. Las fichas se cargan de izquierda a derecha:
        //  - si la posición ya tiene ficha, se reemplaza;
        //  - si es la primera posición vacía, se agrega y el índice avanza;
        //  - si está más a la derecha, no se puede (devuelve false).
        public bool PlaceColor(int position, PegColor color)
        {
            if (IsFinished || position < 0)
            {
                return false;
            }
            if (position < currentCount)
            {
                currentGuess[position] = color;
                return true;
            }
            if (position == currentCount && currentCount < CodeLength)
            {
                currentGuess[currentCount] = color;
                currentCount++;
                return true;
            }
            return false;
        }

        // Borra la última ficha puesta (tecla Retroceso). Devuelve false si no había fichas.
        public bool RemoveLast()
        {
            if (currentCount == 0)
            {
                return false;
            }
            currentCount--;
            return true;
        }

        // Confirma el intento: calcula el resultado de cada ficha, lo guarda en la cola
        // y actualiza vidas o victoria. Devuelve null si el intento no estaba completo.
        public Attempt SubmitGuess()
        {
            if (IsFinished || !IsGuessComplete())
            {
                return null;
            }

            PegResult[] results = FeedbackEvaluator.Evaluate(secretCode, currentGuess, CodeLength);
            Attempt attempt = new Attempt(History.Count() + 1, currentGuess, results, CodeLength);
            if (!History.Enqueue(attempt))
            {
                // No debería pasar (hay tantos casilleros como vidas), pero se controla igual.
                Warning = "El historial está lleno: este intento no se guardó en la cola.";
            }
            currentCount = 0; // el intento en curso queda vacío para la próxima jugada

            if (attempt.ExactCount == CodeLength) // todas las fichas con borde verde
            {
                IsWon = true;
                IsFinished = true;
                FinalScore = scoreService.Calculate(Lives, SecondsPlayed, true);
            }
            else
            {
                Lives--; // cada intento que no acierta resta una vida
                if (Lives <= 0)
                {
                    Lives = 0;
                    IsWon = false;
                    IsFinished = true;
                    FinalScore = scoreService.Calculate(Lives, SecondsPlayed, false); // al perder es 0
                }
            }
            return attempt;
        }
    }
}
