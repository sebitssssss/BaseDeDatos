use eval;

insert into Organizaciones(Nombre, Duenio)
values
("Chevrolet","Pablo"),
("Peugeot","Manuel"),
("Ferrari","Enzo");

insert into Tecnicos(Nombre,Apellido)
values
("Raul", "Perez"),
("Manuel","Ruiz"),
("Santino", "Fux");

insert into Marcas(Nombre,Duenio)
values
("Ferrari", "Enzo"),
("Peugeot", "Manuel"),
("Chevrolet", "Pablo");

insert into Modelos(IDMarca, Anio, NumSerie)
values
(1,2000,45674584),
(2,1990,86970343),
(3,1930, 88992233);

insert into Vehiculos(IDOrganizacion,IDModelo)
values
(1,2 ),
(2,3 ),
(3,1 );

insert into Revisiones(IDTecnico,IDVehiculo,CosteReparacion,NivelBateria,EstadoGeneral,
Fecha,TipoServicio)
values
(1,1, 40000, 90, "Bien", "25-04-2011", "Correctivo"),
(2,2, 50000, 70, "Usado", "13-09-2009", "Preventivo"),
(3,3, 80000, 40, "Mala condición", "22-12-2022", "Correctivo");

insert into Piezas(IDRevision, Marca, NumSerie, Modelo)
values
(1, "Chevrolet", "3584319", "A23"),
(2, "Peugeot", "58383753", "B12"),
(3, "Ford", "38593593", "C13");