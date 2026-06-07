insert into Laboratorios(Nombre, Pais, Telefono)
values
("Roemmers", "Argentina", "+54 9 381 587 4659"),
("Gador", "Brasil", "+54 9 381 586 4659"),
("Pfizer", "Turquia", "+54 9 381 585 4659"),
("J&J", "Rusia", "+54 9 381 586 4659"),
("Roche", "Alemania", "+54 9 381 585 4659");

insert into Medicamentos(IDLaboratorio, Nombre, Monodroga, Precio)
values
(1, "Aspirina", "Ácido acetilsalicílico", 45800),
(2, "Dolex", "Paracetamol", 30700),
(3, "Ribax", "Ibuprofeno", 25000),
(4, "Buscapan", "Hioscina butilbromuro", 30700),
(5, "Glucophage", "Metformina", 25000);

insert into Lotes(IDMedicamento, Stock, Precio, Vencimiento, Ubicacion)
values
(1, 150, 150000, "25-4-2011", "Buenos Aires"),
(2, 100, 150000, "15-5-2012", "Sao Pablo"),
(3, 80, 150000, "5-6-2013", "Rio de Janeiro"),
(4, 110, 150000, "24-7-2014", "Frankfurt"),
(5, 120, 150000, "14-8-2015", "Madrid");