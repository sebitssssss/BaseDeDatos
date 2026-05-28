INSERT INTO Pasajeros(Nombre, DNI)
values
("Juan", "56098345"),
("Ernesto ", "24858494"),
("Antonio", "39584037"),
("Adriel", "28574038"),
("Sebastian", "26496549");

INSERT INTO Aviones(Modelo, Capacidad)
values
("Boeing", "100"),
("Airbus ", "80"),
("F-16", "70"),
("Embraer", "60"),
("Bombardier", "50");

INSERT INTO Vuelos(ID_Avion, Origen, Destino, Fecha, Abordantes)
values
("1", "Buenos Aires", "Madrid", "25-4-2009", "90"),
("2", "Sao Pablo", "Buenos Aires", "25-5-2022", "79"),
("3", "El Cairo", "Sao Pablo", "6-3-2000", "67"),
("4", "Chicago", "El Cairo", "20-3-2010", "50"),
("5", "Madrid", "Chicago", "31-3-2011", "47");

INSERT INTO Tickets(ID_Avion, ID_Pasajero, Precio)
values
("1", "1", "150000"),
("2", "2", "80000"),
("3", "3", "70000"),
("4", "4", "90000"),
("5", "5", "120000");