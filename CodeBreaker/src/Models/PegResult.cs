namespace CodeBreaker.Models
{
    // Resultado de cada ficha de un intento. Define el color del aro que la rodea.
    public enum PegResult
    {
        Absent = 0,  // aro rojo: ese color no está en el código (o ya se contaron todas sus apariciones)
        Present = 1, // aro amarillo: el color está en el código, pero en otra posición
        Exact = 2    // aro verde: color correcto en la posición correcta
    }
}
