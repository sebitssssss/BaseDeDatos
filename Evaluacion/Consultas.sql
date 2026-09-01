-- 1
select Vehiculos.IDVehiculo, Organizaciones.Nombre as Org, Tecnicos.Nombre as Tecnico
from Vehiculos 
inner join Organizaciones  on Organizaciones.IDOrganizacion = Vehiculos.IDOrganizacion
inner join Revisiones  on Revisiones.IDVehiculo = Vehiculos.IDVehiculo
inner join Tecnicos  on Tecnicos.IDTecnico = Revisiones.IDTecnico;

-- 2
select Revisiones.CosteReparacion as Costo 
from Revisiones
where Revisiones.CosteReparacion > ((select avg(Revisiones.CosteReparacion) from Revisiones));

-- 3

select t.IDTecnico, t.Nombre, t.Apellido, count(*) as cantidadRevisiones
from tecnicos t
inner join Revisiones r on r.IDTecnico = t.IDTecnico
group by t.IDTecnico, t.Nombre, t.Apellido
having count(*) > 3;

-- 4
select Vehiculos.IDVehiculo as Vehiculo, count(Revisiones.IDRevision) as cantidadREvisiones
from Vehiculos 
left join Revisiones on Revisiones.IDVehiculo = Vehiculos.IDVehiculo
group by Vehiculos.IDVehiculo
order by cantidadREvisiones asc
limit 1;

-- 5
select Organizaciones.Nombre as Org, Revisiones.NivelBateria as Bateria
from Organizaciones
inner join Vehiculos on Organizaciones.IDOrganizacion = Vehiculos.IDOrganizacion
inner join Revisiones on Vehiculos.IDVehiculo = Revisiones.IDVehiculo
group by Organizaciones.Nombre
having Revisiones.NivelBateria < (select avg(Revisiones.NivelBateria) from Revisiones);

-- 6
select Tecnicos.Nombre as Nombre
from Tecnicos
inner join Revisiones on Tecnicos.IDTecnico = Revisiones.IDTecnico
where Revisiones.TipoServicio = "Correctivo"
order by Revisiones.IDRevision
desc
limit 3;