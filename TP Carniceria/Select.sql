SELECT CorteDeCarne, COUNT(*) AS CantidadVendida FROM Pedidos GROUP BY CorteDeCarne ORDER BY CantidadVendida DESC LIMIT 1;

SELECT c.IDCliente, c.Nombre, c.Apellido, COUNT(p.IDPedido) AS CantidadDeCompras FROM Clientes c INNER JOIN Pedidos p ON c.IDCliente = p.IDCliente GROUP BY c.IDCliente, c.Nombre, c.Apellido ORDER BY CantidadDeCompras DESC LIMIT 1;

SELECT ca.IDCarnicero, ca.Nombre, ca.Apellido, COUNT(DISTINCT p.IDCliente) AS CantidadDeClientes FROM Carniceros ca INNER JOIN Pedidos p ON ca.IDCarnicero = p.IDCarnicero GROUP BY ca.IDCarnicero, ca.Nombre, ca.Apellido ORDER BY CantidadDeClientes DESC LIMIT 1;

SELECT p.IDPedido, CONCAT(cl.Nombre, ' ', cl.Apellido) AS Cliente, p.CorteDeCarne AS ContenidoDelPedido, p.Precio, CONCAT(ca.Nombre, ' ', ca.Apellido) AS Carnicero FROM Pedidos p INNER JOIN Clientes cl ON p.IDCliente = cl.IDCliente INNER JOIN Carniceros ca ON p.IDCarnicero = ca.IDCarnicero ORDER BY p.Precio DESC LIMIT 1; 

SELECT CorteDeCarne, COUNT(*) AS CantidadDeVentas FROM Pedidos GROUP BY CorteDeCarne ORDER BY CantidadDeVentas DESC;