using System;
using CodeBreaker.Models;

namespace CodeBreaker.Logic
{
    // Genera el código secreto al azar al comenzar cada partida.
    // Equivale a la "generación de elementos/obstáculos" del MVP.
    public class CodeGenerator
    {
        private readonly Random random = new Random();

        // Devuelve un código de "length" colores. Se permiten colores repetidos.
        public PegColor[] Generate(int length)
        {
            PegColor[] code = new PegColor[length];
            for (int i = 0; i < length; i++)
            {
                // Next(6) devuelve un número de 0 a 5, que es el número de un color del enum.
                code[i] = (PegColor)random.Next(Palette.ColorCount);
            }
            return code;
        }
    }
}
