using CodeBreaker.Models;

namespace CodeBreaker.Logic
{
    // Ordenamiento por Burbuja programado a mano para la tabla de posiciones.
    // Criterio: mayor puntaje primero; si empatan, el de menor tiempo primero.
    //
    // Complejidad: O(n²) comparaciones en el peor caso y en el caso promedio
    // (hasta n-1 pasadas de hasta n-1 comparaciones cada una).
    // Mejor caso: O(n), si el array ya está ordenado, gracias a la bandera "swapped".
    // Memoria extra: O(1), porque ordena dentro del mismo array (solo usa una variable auxiliar).
    public static class BubbleSorter
    {
        // Ordena las primeras "count" posiciones de "records".
        public static void Sort(ScoreRecord[] records, int count)
        {
            // Paso 1: se hacen hasta count-1 pasadas.
            for (int pass = 0; pass < count - 1; pass++)
            {
                bool swapped = false;

                // Paso 2: en cada pasada se comparan vecinos (i, i+1).
                // Los últimos "pass" casilleros ya tienen su valor final, por eso no se recorren.
                for (int i = 0; i < count - 1 - pass; i++)
                {
                    // Paso 3: si el de la derecha tiene que ir antes, se intercambian.
                    if (IsBetter(records[i + 1], records[i]))
                    {
                        ScoreRecord temp = records[i];
                        records[i] = records[i + 1];
                        records[i + 1] = temp;
                        swapped = true;
                    }
                }

                // Paso 4: si en toda la pasada no hubo intercambios, ya está ordenado.
                if (!swapped)
                {
                    break;
                }
            }
        }

        // Devuelve true si "a" tiene que aparecer antes que "b" en el ranking.
        // Si empatan en puntaje y tiempo devuelve false: no se intercambian y se respeta el orden (burbuja es estable).
        public static bool IsBetter(ScoreRecord a, ScoreRecord b)
        {
            if (a.Score != b.Score)
            {
                return a.Score > b.Score;   // puntaje descendente
            }
            return a.Seconds < b.Seconds;   // desempate: tiempo ascendente
        }
    }
}
