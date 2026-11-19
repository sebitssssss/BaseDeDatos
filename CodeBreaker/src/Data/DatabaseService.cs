using System;
using MySqlConnector;
using CodeBreaker.Models;

namespace CodeBreaker.Data
{
    // Conexión con MySQL usando la librería MySqlConnector.
    // Solo abre y cierra la conexión para saber si la base está disponible.
    // Las consultas SQL las define la materia Base de Datos (BD.sql): acá no se escribe SQL.
    public class DatabaseService
    {
        public const uint ConnectionTimeoutSeconds = 3; // "Connection Timeout=3"

        private readonly GameConfig config;

        public bool WasChecked { get; private set; }  // ¿ya se intentó conectar?
        public bool IsConnected { get; private set; } // resultado del último intento
        public string ErrorDetail { get; private set; } // motivo del error, para mostrar en el menú

        public DatabaseService(GameConfig config)
        {
            this.config = config;
            ErrorDetail = "";
        }

        // Texto corto para el menú.
        public string StatusText
        {
            get
            {
                if (!WasChecked)
                {
                    return "verificando...";
                }
                return IsConnected ? "conectada" : "sin conexión";
            }
        }

        // Arma la cadena de conexión con los datos de config.conf.
        public string BuildConnectionString()
        {
            MySqlConnectionStringBuilder builder = new MySqlConnectionStringBuilder();
            builder.Server = config.DbServer;
            builder.Port = (uint)config.DbPort;
            builder.Database = config.DbName;
            builder.UserID = config.DbUser;
            builder.Password = config.DbPassword;
            builder.ConnectionTimeout = ConnectionTimeoutSeconds;
            return builder.ConnectionString;
        }

        // Intenta abrir la conexión y la cierra enseguida. Nunca deja escapar una excepción.
        public bool TestConnection()
        {
            WasChecked = true;
            try
            {
                using (MySqlConnection connection = new MySqlConnection(BuildConnectionString()))
                {
                    connection.Open(); // si el servidor no responde, falla a los 3 segundos como máximo
                    IsConnected = true;
                    ErrorDetail = "";
                } // al salir del using, la conexión se cierra sola
            }
            catch (MySqlException ex)
            {
                IsConnected = false;
                ErrorDetail = ex.Message;
            }
            catch (Exception ex)
            {
                IsConnected = false;
                ErrorDetail = ex.Message;
            }
            return IsConnected;
        }
    }
}
