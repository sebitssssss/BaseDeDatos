using CodeBreaker.Models;

namespace CodeBreaker.Logic
{
    // Cola circular sobre un array de tamaño fijo, hecha a mano.
    // FIFO: el primero que entra es el primero que sale.
    // Guarda el historial de intentos en orden. Su capacidad es igual a la cantidad de vidas.
    //
    // Idea clave: cuando un índice llega al último casillero, el siguiente vuelve a ser el 0.
    // Eso se hace con el resto de la división: siguiente = (indice + 1) % capacidad.
    // Ejemplo con capacidad 4: 0 -> 1 -> 2 -> 3 -> 0 -> 1 ...
    public class CircularQueue
    {
        private const int NoRear = -1; // "final" todavía no apunta a ningún casillero

        private readonly Attempt[] items; // casilleros de la cola
        private int front;                // posición del elemento más viejo (el próximo en salir)
        private int rear;                 // posición del último elemento que entró
        private int count;                // cantidad de elementos guardados

        public CircularQueue(int capacity)
        {
            if (capacity < 1)
            {
                capacity = 1; // una cola necesita al menos un casillero
            }
            items = new Attempt[capacity];
            Clear();
        }

        public int Capacity()
        {
            return items.Length;
        }

        public int Count()
        {
            return count;
        }

        public bool IsEmpty()
        {
            return count == 0;
        }

        public bool IsFull()
        {
            return count == items.Length;
        }

        // Agrega un elemento al final. Devuelve false si la cola está llena (no tira error).
        public bool Enqueue(Attempt item)
        {
            if (IsFull())                     // 1) cola llena: no hay lugar
            {
                return false;
            }
            rear = (rear + 1) % items.Length; // 2) "final" avanza un casillero (da la vuelta si hace falta)
            items[rear] = item;               // 3) se guarda el elemento
            count++;                          // 4) hay uno más
            return true;
        }

        // Saca el elemento del frente (el más viejo). Devuelve false si la cola está vacía.
        public bool Dequeue(out Attempt item)
        {
            if (IsEmpty())                      // 1) cola vacía: no hay nada para sacar
            {
                item = null;
                return false;
            }
            item = items[front];                // 2) se lee el más viejo
            items[front] = null;                // 3) se libera el casillero
            front = (front + 1) % items.Length; // 4) "frente" avanza un casillero (da la vuelta si hace falta)
            count--;                            // 5) hay uno menos
            return true;
        }

        // Mira el elemento del frente sin sacarlo. Devuelve false si la cola está vacía.
        public bool Peek(out Attempt item)
        {
            if (IsEmpty())
            {
                item = null;
                return false;
            }
            item = items[front];
            return true;
        }

        // Devuelve el elemento número i contando desde el frente (0 = el más viejo), sin sacarlo.
        // El casillero real es (frente + i) % capacidad. Devuelve null si i está fuera de rango.
        public Attempt GetAt(int i)
        {
            if (i < 0 || i >= count)
            {
                return null;
            }
            return items[(front + i) % items.Length];
        }

        // Vacía la cola y la deja como recién creada.
        public void Clear()
        {
            for (int i = 0; i < items.Length; i++)
            {
                items[i] = null;
            }
            front = 0;
            rear = NoRear; // el primer Enqueue hace (-1 + 1) % capacidad = 0
            count = 0;
        }
    }
}
