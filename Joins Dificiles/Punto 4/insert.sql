INSERT INTO Edificios (Direccion, Nombre)
VALUES
('Av. Corrientes 1234', 'Torre Central'),
('San Juan 456', 'Residencias del Sur'),
('Av. Rivadavia 789', 'Altos del Oeste'),
('Chile 321', 'Edificio Plaza'),
('Bacacay 555', 'Complejo Norte');

INSERT INTO Departamentos (ID_Edificio, Piso)
VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 5),
(4, 7);

INSERT INTO Expensas (ID_Departamento, Monto, Estado)
VALUES
(1, 150000, 'Pago'),
(2, 230000, 'Impago'),
(3, 175000, 'Pago'),
(4, 92000, 'Impago'),
(5, 210000, 'Pago');