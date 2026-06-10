SELECT p.Nombre, p.Precio FROM Productos p WHERE p.Precio > 50;
SELECT c.IDCliente FROM Clientes c JOIN Pedidos p ON c.IDCliente = p.IDCliente;
SELECT p.IDPedido, p.Fecha, c.Nombre FROM Pedidos p JOIN Clientes c ON c.IDCliente = p.IDCliente WHERE p.Estado = 'Entregado';
SELECT p.Estado, c.Email FROM Pedidos p JOIN Clientes c ON c.IDCliente = p.IDCliente;
SELECT c.Nombre, p.Fecha FROM Clientes c JOIN Pedidos p ON p.IDCliente = c.IDCliente ORDER BY p.IDPedido DESC LIMIT 1;
SELECT c.Nombre, p.Estado FROM Clientes c JOIN Pedidos p ON p.IDCliente = c.IDCliente WHERE p.Estado = 'Pendiente';
SELECT p.Nombre, p.Precio FROM Productos p ORDER BY p.Nombre DESC LIMIT 1;
