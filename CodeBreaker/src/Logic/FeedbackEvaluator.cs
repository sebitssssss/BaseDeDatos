using CodeBreaker.Models;

namespace CodeBreaker.Logic
{
    // Calcula el resultado de cada ficha de un intento (el color de su aro):
    //   Exact   (verde):    color correcto en la posición correcta.
    //   Present (amarillo): el color está en el código, pero en otra posición.
    //   Absent  (rojo):     el color no está, o ya se contaron todas las veces que aparece.
    // Ningún color del código se cuenta dos veces.
    //
    // Ejemplo: secreto = Rojo Azul Verde Verde, intento = Verde Verde Verde Rojo
    //   Paso 1: la posición 3 coincide (Verde = Verde) -> verde.
    //           Quedan sin usar del secreto: Rojo 1, Azul 1, Verde 1.
    //   Paso 2: posición 1, Verde: queda 1 Verde   -> amarillo (ya no quedan Verdes)
    //           posición 2, Verde: no quedan Verdes -> rojo
    //           posición 4, Rojo:  queda 1 Rojo    -> amarillo
    //   Resultado: amarillo, rojo, verde, amarillo.
    public static class FeedbackEvaluator
    {
        public static PegResult[] Evaluate(PegColor[] secret, PegColor[] guess, int length)
        {
            PegResult[] results = new PegResult[length];
            int[] unusedSecretColors = new int[Palette.ColorCount]; // colores del secreto todavía sin usar

            // Paso 1: marcar las posiciones exactas (verde).
            // Los colores del secreto que no coincidieron quedan disponibles para el paso 2.
            for (int i = 0; i < length; i++)
            {
                if (guess[i] == secret[i])
                {
                    results[i] = PegResult.Exact;
                }
                else
                {
                    results[i] = PegResult.Absent;
                    unusedSecretColors[(int)secret[i]]++;
                }
            }

            // Paso 2: de izquierda a derecha, cada ficha que no fue exacta usa un color
            // disponible (amarillo). Si no queda ninguno de ese color, sigue en rojo (no está).
            for (int i = 0; i < length; i++)
            {
                if (results[i] == PegResult.Exact)
                {
                    continue;
                }
                int color = (int)guess[i];
                if (unusedSecretColors[color] > 0)
                {
                    results[i] = PegResult.Present;
                    unusedSecretColors[color]--;
                }
            }

            return results;
        }
    }
}
