INSERT INTO Socios(Nombre, Fecha_Inscripcion)
VALUES
("Boeing", "25-4-2011"),
("Airbus ", "20-1-2009"),
("F-16", "10-9-1999"),
("Embraer", "31-1-2022"),
("Bombardier", "31-4-2000");

INSERT INTO Planes(Tipo, Costo)
VALUES
("Black", "560345"),
("Smart", "248494"),
("Fit", "395037"),
("Deluxe", "284038"),
("Premium", "26449");

INSERT INTO Pagos(ID_Socio, ID_Plan, Monto, Fecha)
VALUES
("1", "1", "150000", "25-4-2011"),
("2", "2", "80000", "20-1-2009"),
("3", "3", "70000", "10-9-1999"),
("4", "4", "90000", "31-1-2022"),
("5", "5", "120000", "31-4-2000");