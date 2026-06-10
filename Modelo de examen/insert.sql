INSERT INTO Productos (IDProducto, Nombre, Descripcion, Precio, Stock) VALUES
(1, 'Cofre', '27 slots', 3500, 8),
(2, 'Espada de diamante', '7 de daño base', 12500, 1),
(3, 'Poción de curación', '3.5 de curación instantánea', 450, 64),
(4, 'Armadura de hierro', '17 puntos de armadura', 9800, 4),
(5, 'Bloque de piedra', 'Piedra cocinada', 120, 128);

INSERT INTO Clientes (IDCliente, Nombre, Apellido, Email, Direccion) VALUES
(1, 'Martín', 'García', 'martin.garcia@gmail.com', 'Av. Corrientes 1234'),
(2, 'Lucía', 'Pérez', 'lucia.perez@outlook.com', 'Coronel Díaz 45'),
(3, 'Javier', 'Rodríguez', 'javier.rodriguez@hotmail.com', 'Calle Falsa 123'),
(4, 'Sofía', 'López', 'sofia.lopez@yahoo.com', 'San Martín 210'),
(5, 'Diego', 'Fernández', 'diego.fernandez@gmail.com', 'Belgrano 88');

INSERT INTO Pedidos (IDPedido, IDCliente, Fecha, Estado) VALUES
(1001, 1, '2026-05-28', 'Entregado'),
(1002, 3, '2026-06-02', 'Enviado'),
(1003, 2, '2026-06-05', 'En proceso'),
(1004, 5, '2026-06-08', 'Pendiente'),
(1005, 4, '2026-06-09', 'Enviado');
