using Microsoft.Xna.Framework.Input;

namespace CodeBreaker.Screens
{
    // Lee el teclado una vez por cuadro y detecta las teclas recién apretadas.
    // Así, mantener apretada una flecha mueve el selector una sola vez.
    public class InputHelper
    {
        private KeyboardState previous;
        private KeyboardState current;

        // Se llama al principio de cada Update.
        public void Update()
        {
            previous = current;
            current = Keyboard.GetState();
        }

        // true solo en el cuadro en que la tecla pasa de suelta a apretada.
        public bool WasPressed(Keys key)
        {
            return current.IsKeyDown(key) && previous.IsKeyUp(key);
        }
    }
}
