using System;
using System.IO;
using CodeBreaker.Logic;
using CodeBreaker.Models;

namespace CodeBreaker.Data
{
    // puntajes.dat: archivo binario con las partidas ganadas.
    // Formato: primero un int con la cantidad de registros; después, por cada registro:
    //   string nombre, int puntaje, int vidas restantes, int segundos, long fecha (DateTime.Ticks)
    // Se escribe con BinaryWriter y se lee con BinaryReader. En memoria vive en un array fijo.
    public class ScoreFile
    {
        public const string FileName = "puntajes.dat";
        public const int MaxRecords = 100;
        private const int MaxNameLength = 50; // un nombre más largo indica un archivo dañado

        private readonly string filePath;
        private readonly ScoreRecord[] records = new ScoreRecord[MaxRecords];
        private int count = 0;

        public string Warning { get; private set; } // "" si no hubo problemas

        public int Count
        {
            get { return count; }
        }

        public ScoreFile(string folder)
        {
            filePath = Path.Combine(folder, FileName);
            Warning = "";
        }

        // Devuelve el registro de la posición indicada, o null si no existe.
        public ScoreRecord GetAt(int index)
        {
            if (index < 0 || index >= count)
            {
                return null;
            }
            return records[index];
        }

        // Carga el archivo. Si no existe, el ranking empieza vacío (es lo normal antes de la
        // primera victoria y la pantalla de Ranking lo indica). Si está dañado, avisa.
        public void Load()
        {
            count = 0;
            Warning = "";

            if (!File.Exists(filePath))
            {
                return;
            }

            try
            {
                using (BinaryReader reader = new BinaryReader(File.Open(filePath, FileMode.Open, FileAccess.Read)))
                {
                    int total = reader.ReadInt32();
                    if (total < 0 || total > MaxRecords)
                    {
                        throw new InvalidDataException("la cantidad de registros (" + total + ") no es válida");
                    }

                    for (int i = 0; i < total; i++)
                    {
                        string name = reader.ReadString();
                        int score = reader.ReadInt32();
                        int livesLeft = reader.ReadInt32();
                        int seconds = reader.ReadInt32();
                        long ticks = reader.ReadInt64();

                        bool invalid = name.Length > MaxNameLength || score < 0 || livesLeft < 0 || seconds < 0
                            || ticks < DateTime.MinValue.Ticks || ticks > DateTime.MaxValue.Ticks;
                        if (invalid)
                        {
                            throw new InvalidDataException("el registro " + (i + 1) + " tiene datos inválidos");
                        }

                        records[i] = new ScoreRecord(name, score, livesLeft, seconds, new DateTime(ticks));
                    }

                    // Recién acá se acepta lo leído: si algo falló antes, el ranking queda vacío.
                    count = total;
                }
            }
            catch (Exception ex)
            {
                count = 0;
                Warning = "puntajes.dat está dañado (" + ex.Message + "): el ranking empieza vacío y se reemplaza al guardar.";
            }
        }

        // Escribe todos los registros en el archivo. Devuelve false si no pudo.
        public bool Save()
        {
            try
            {
                using (BinaryWriter writer = new BinaryWriter(File.Open(filePath, FileMode.Create, FileAccess.Write)))
                {
                    writer.Write(count);
                    for (int i = 0; i < count; i++)
                    {
                        writer.Write(records[i].PlayerName);
                        writer.Write(records[i].Score);
                        writer.Write(records[i].LivesLeft);
                        writer.Write(records[i].Seconds);
                        writer.Write(records[i].Date.Ticks);
                    }
                }
                Warning = "";
                return true;
            }
            catch (Exception ex)
            {
                Warning = "No se pudo guardar puntajes.dat (" + ex.Message + ").";
                return false;
            }
        }

        // Agrega una partida ganada y guarda el archivo.
        // Devuelve "" si salió bien, o el aviso de error para mostrar en pantalla.
        public string AddAndSave(ScoreRecord record)
        {
            if (count < MaxRecords)
            {
                records[count] = record;
                count++;
            }
            else
            {
                // Array lleno: se ordena y el nuevo reemplaza al último (el peor) solo si lo supera.
                SortRanking();
                if (!BubbleSorter.IsBetter(record, records[count - 1]))
                {
                    return ""; // no entra entre las 100 mejores: no es un error
                }
                records[count - 1] = record;
            }

            if (Save())
            {
                return "";
            }
            return Warning; // no se pudo escribir el archivo
        }

        // Ordena los registros con burbuja: mayor puntaje primero y, si empatan, menor tiempo.
        public void SortRanking()
        {
            BubbleSorter.Sort(records, count);
        }
    }
}
