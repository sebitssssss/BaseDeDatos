using System;
using System.IO;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using CodeBreaker.Data;
using CodeBreaker.Logic;
using CodeBreaker.Models;
using CodeBreaker.Screens;

namespace CodeBreaker
{
    // Clase principal de MonoGame. Carga archivos y recursos, maneja la máquina de estados
    // (GameState) y le pasa el Update y el Draw a la pantalla del estado actual.
    public class Game1 : Game
    {
        private const string SpritesFolder = "Sprites"; // dentro de Content

        private readonly GraphicsDeviceManager graphics;
        private SpriteBatch spriteBatch;
        private GameState state = GameState.Menu;

        // Archivos, base de datos y recursos gráficos
        private ConfigManager configManager;
        private ScoreFile scoreFile;
        private DatabaseService database;
        private SpriteAtlas atlas;
        private Renderer renderer;
        private readonly InputHelper input = new InputHelper();

        // La partida (se reutiliza entre partidas) y las pantallas
        private GameSession session;
        private MenuScreen menuScreen;
        private PlayingScreen playingScreen;
        private GameOverScreen gameOverScreen;
        private RankingScreen rankingScreen;

        // MySQL se prueba después de dibujar el primer cuadro, para que la ventana no quede en negro.
        private bool firstFrameDrawn = false;

        public Game1()
        {
            graphics = new GraphicsDeviceManager(this);
            graphics.PreferredBackBufferWidth = Renderer.ScreenWidth;   // 1280
            graphics.PreferredBackBufferHeight = Renderer.ScreenHeight; // 720
            Content.RootDirectory = "Content";
            IsMouseVisible = true;
            Window.Title = "Code Breaker";
        }

        // Lee config.conf y puntajes.dat y crea los servicios y las pantallas.
        protected override void Initialize()
        {
            string folder = AppContext.BaseDirectory; // carpeta del ejecutable

            configManager = new ConfigManager(folder);
            configManager.Load();
            GameConfig config = configManager.Config;

            scoreFile = new ScoreFile(folder);
            scoreFile.Load();

            database = new DatabaseService(config);

            ScoreService scoreService = new ScoreService(config.PointsPerLife, config.TimeBonusMax);
            session = new GameSession(config, new CodeGenerator(), scoreService);

            menuScreen = new MenuScreen();
            playingScreen = new PlayingScreen(session, config.DebugShowSecret);
            gameOverScreen = new GameOverScreen();
            rankingScreen = new RankingScreen();

            // Cada letra que se escribe llega por este evento (sirve para el nombre del jugador).
            Window.TextInput += OnTextInput;

            base.Initialize(); // acá MonoGame llama a LoadContent
        }

        // Carga las fuentes (Content.mgcb) y los spritesheets (Content/Sprites).
        protected override void LoadContent()
        {
            spriteBatch = new SpriteBatch(GraphicsDevice);

            SpriteFont titleFont = Content.Load<SpriteFont>("Fonts/Title");
            SpriteFont regularFont = Content.Load<SpriteFont>("Fonts/Regular");
            SpriteFont mediumFont = Content.Load<SpriteFont>("Fonts/Medium");
            SpriteFont smallFont = Content.Load<SpriteFont>("Fonts/Small");

            atlas = new SpriteAtlas();
            string spritesPath = Path.Combine(AppContext.BaseDirectory, Content.RootDirectory, SpritesFolder);
            atlas.LoadFolder(GraphicsDevice, spritesPath);

            renderer = new Renderer(spriteBatch, atlas, titleFont, regularFont, mediumFont, smallFont);
            renderer.ResolveSprites(configManager.Config);
        }

        private void OnTextInput(object sender, TextInputEventArgs e)
        {
            if (state == GameState.Menu)
            {
                menuScreen.OnCharacterTyped(e.Character);
            }
        }

        protected override void Update(GameTime gameTime)
        {
            input.Update();

            if (firstFrameDrawn && !database.WasChecked)
            {
                database.TestConnection(); // como máximo 3 segundos (Connection Timeout=3)
            }

            GameState next = state;
            switch (state)
            {
                case GameState.Menu:
                    next = menuScreen.Update(input, database);
                    break;
                case GameState.Playing:
                    next = playingScreen.Update(gameTime, input);
                    break;
                case GameState.GameOver:
                    next = gameOverScreen.Update(gameTime, input);
                    break;
                case GameState.Ranking:
                    next = rankingScreen.Update(input);
                    break;
            }

            if (menuScreen.ExitRequested)
            {
                Exit();
            }
            else
            {
                ChangeState(next);
            }

            base.Update(gameTime);
        }

        // Cambia de pantalla y prepara lo que la pantalla nueva necesita.
        private void ChangeState(GameState next)
        {
            if (next == state)
            {
                return;
            }

            if (next == GameState.Playing)
            {
                playingScreen.StartNewGame(menuScreen.PlayerName); // código nuevo y vidas completas
            }
            else if (next == GameState.GameOver)
            {
                gameOverScreen.Show(session, SaveResult());
            }
            else if (next == GameState.Ranking)
            {
                scoreFile.SortRanking(); // burbuja
            }
            state = next;
        }

        // Guarda la partida en puntajes.dat si se ganó (al perder el puntaje es 0 y no se guarda).
        // Devuelve "" si salió bien, o el aviso de error para mostrar en pantalla.
        private string SaveResult()
        {
            if (!session.IsWon)
            {
                return "";
            }
            ScoreRecord record = new ScoreRecord(session.PlayerName, session.FinalScore, session.Lives, session.SecondsPlayed, DateTime.Now);
            return scoreFile.AddAndSave(record);
        }

        protected override void Draw(GameTime gameTime)
        {
            // La derrota tiene otro color de fondo.
            bool isDefeat = state == GameState.GameOver && !session.IsWon;
            GraphicsDevice.Clear(isDefeat ? Renderer.DefeatBackgroundColor : Renderer.BackgroundColor);
            spriteBatch.Begin();

            switch (state)
            {
                case GameState.Menu:
                    menuScreen.Draw(renderer, database, GetWarnings());
                    break;
                case GameState.Playing:
                    playingScreen.Draw(renderer);
                    break;
                case GameState.GameOver:
                    gameOverScreen.Draw(renderer);
                    break;
                case GameState.Ranking:
                    rankingScreen.Draw(renderer, scoreFile);
                    break;
            }

            spriteBatch.End();
            firstFrameDrawn = true;
            base.Draw(gameTime);
        }

        // Junta los avisos de error (config.conf, puntajes.dat y sprites) para mostrarlos en el menú.
        // Solo hay texto si algo falló de verdad: las situaciones normales no generan aviso.
        private string GetWarnings()
        {
            string text = "";
            text = JoinWarning(text, configManager.Warning);
            text = JoinWarning(text, scoreFile.Warning);
            text = JoinWarning(text, atlas.Warning);
            text = JoinWarning(text, renderer.Warning);
            return text;
        }

        private static string JoinWarning(string text, string warning)
        {
            if (warning.Length == 0)
            {
                return text;
            }
            return text.Length == 0 ? warning : text + " " + warning;
        }
    }
}
