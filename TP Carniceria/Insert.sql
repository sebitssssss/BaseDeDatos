USE FG;

INSERT INTO Carniceros(Nombre, Apellido, DNI) 
VALUES
('Finn', "Lopez", '49384274'),
('Jake', 'Gimenez', '24838040'),
('Rey', 'Gomez', '75936695');

INSERT INTO Clientes(Nombre, Apellido, Telefono, MedioDePago) 
VALUES
('Juan', 'Mendez', '+49 5 9384-4274', 'Tarjeta'),
('Hernan', 'Latour', '+24 5 8838-7040', 'Transferencia'),
('Francisco', 'Fux', '+55 4 4936-6695', 'Tarjeta');

INSERT INTO Pedidos(CorteDeCarne, Precio, IDCarnicero, IDCliente) 
VALUES
('Lomo', '474', '1', '1'),
('Cuadril', '2040', '2', '2'),
('Nalga', '7695', '3', '3');