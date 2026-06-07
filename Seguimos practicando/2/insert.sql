USE fg;

INSERT INTO Sucursales (Ciudad, Provincia, Responsable) 
VALUES
('Buenos Aires', 'Buenos Aires', 'Carlos Méndez'),
('Córdoba',      'Córdoba',      'Laura Giménez'),
('Rosario',      'Santa Fe',     'Martín Torres'),
('Mendoza',      'Mendoza',      'Sofía Romero'),
('Tucumán',      'Tucumán',      'Diego Herrera');

INSERT INTO Paquetes(Peso, DescripcionContenido, TipoEnvio, IDSucursalOrigen) 
VALUES
(12.50, 'Caja con electrodomésticos',  'Express', 1),
(5.00,  'Caja con ropa y accesorios',  'Normal',  2),
(30.00, 'Documentos legales urgentes', 'Express', 3),
(8.75,  'Caja con libros escolares',   'Normal',  4),
(45.00, 'Repuestos de maquinaria',     'Express', 5);

INSERT INTO Envios (IDPaquete, CostoEnvio, FechaDespacho, Estado) 
VALUES
(1, 75000.00, '2026-05-03', 'Entregado'),
(2,  4500.00, '2026-05-15', 'En Camino'),
(3, 60000.00, '2026-05-22', 'Entregado'),
(4,  6800.00, '2026-04-10', 'En Camino'),
(5, 95000.00, '2026-05-30', 'Devuelto');