INSERT into clientes(DNI, nombre, apellido,direccion, telefono)
values
("50104119", "Sebastián", "Gómez", "Av. Triunvirato 3527", "+54 9 381 587-4659"),
("50851349", "Oracio", "Rodríguez", "Av. Callao 762", "+54 1 234 567-8910"),
("51234567", "Hernan", "Hernández", "Av. Córdoba 745", "+54 2 345 678-9101"),
("59876543", "Juan", "Gimenez", "Carlos Calvo 2038", "+54 1 234 567-8910"),
("57485674", "Martín", "Gonzalez", "Av. Independencia 938", "+54 8 645-6642");

INSERT into compras(id_cliente, id_coche)
values
("1", "1"),
("2", "2"),
("3", "3"),
("4", "4"),
("5", "5");

INSERT into coches(id_consesionario, color, marca, modelo, matricula)
values
("1", "Rojo", "Peugeot", "208", "TET 062"),
("2", "Verde", "Chevrolet", "Camaro", "BKT 591"),
("3", "Amarillo", "Volkswagen", "Up!", "RDT 091"),
("4", "Blanco", "Toyota", "Hilux", "VTI 531"),
("5", "Negro", "BMW", "335i", "OPJ 002");

INSERT into autos_nuevos(unidades)
values
("174532"),
("275"),
("3346"),
("4753"),
("3645");

INSERT into autos_usados(kilometraje)
values
("15832"),
("27865"),
("33846"),
("47748"),
("36465");

INSERT into mecanicos(DNI, nombre, apellido, fecha_contratacion, salario)
values
("39098456", "Ezequiel", "Besteiro", 25-4-2021, 5000000),
("41768345", "Mauricio", "Rodríguez", 20-5-2026, 1300000),
("40213789", "Hernan", "Hernández", "10-1-2009", 4000000),
("33745609", "Juan", "Gimenez", "9-3-2010", 900000),
("41657342", "Martín", "Gonzalez", "3-9-1999", 1150000);

INSERT into mecanicos_coches(id_mecanico, id_coche)
values
("1", "1"),
("2", "2"),
("3", "3"),
("4", "4"),
("5", "5");
