select Revisiones.CosteReparacion as Costo 
from Revisiones
where Revisiones.CosteReparacion > ((select avg(Revisiones.CosteReparacion) from Revisiones));

select Organizaciones.Nombre as Org, Revisiones.NivelBateria as Bateria
from Organizaciones
inner join Vehiculos on Organizaciones.IDOrganizacion = Vehiculos.IDOrganizacion
inner join Revisiones on Vehiculos.IDVehiculo = Revisiones.IDVehiculo
group by Organizaciones.Nombre
having Revisiones.NivelBateria < (select avg(Revisiones.NivelBateria) from Revisiones);

select Tecnicos.Nombre as Nombre 
from Tecnicos
inner join Revisiones on Tecnicos.IDTecnico = Revisiones.IDTecnico
where Revisiones.TipoServicio = "Correctivo"
order by Revisiones.IDRevision
desc
limit 3;