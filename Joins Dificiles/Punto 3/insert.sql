INSERT INTO Categorias(Nombre)
VALUES
('Celulares'),
('Notebooks'),
('Monitores'),
('Teclados'),
('Auriculares');

INSERT INTO Productos(ID_Categoria, Nombre, Precio)
VALUES
("1", 'Samsung A15', 250000),
("2", 'Lenovo IdeaPad', 850000),
("3", 'LG 24" IPS', 180000),
("4", 'Logitech K120', 12000),
("5", 'HyperX Cloud Stinger', 95000);

INSERT INTO Ventas(ID_Producto, Cantidad, Detalle)
VALUES
("1", "3", 'Venta minorista'),
("2", "2", 'Venta empresa'),
("3", "5", 'Venta online'),
("4", "10", 'Promoción'),
("5", "4", 'Venta mostrador');