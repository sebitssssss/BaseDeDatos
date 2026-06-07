USE fg;
 
SELECT s.Ciudad AS CiudadOrigen, AVG(p.Peso) AS PesoPromedio, SUM(e.CostoEnvio) AS CostoAcumulado FROM Envios e JOIN Paquetes p ON e.IDPaquete = p.IDPaquete JOIN Sucursales s ON p.IDSucursalOrigen = s.IDSucursalOrigen WHERE e.Estado  = 'Entregado' AND p.Peso > 1 AND p.Peso < 50 GROUP BY s.Ciudad HAVING SUM(e.CostoEnvio) > 50000;
 
SELECT s.Ciudad AS CiudadOrigen, COUNT(e.IDEnvio) AS TotalEnCamino FROM Envios e JOIN Paquetes p ON e.IDPaquete = p.IDPaquete JOIN Sucursales s ON p.IDSucursalOrigen = s.IDSucursal WHERE e.Estado = 'En Camino' AND e.CostoEnvio > 5000 GROUP BY s.Ciudad; 

SELECT p.DescripcionContenido AS Descripcion, e.CostoEnvio AS Costo_Envio FROM Envios e JOIN Paquetes p ON e.IDPaquete = p.IDPaquete JOIN Sucursales s ON p.IDSucursalOrigen = s.IDSucursal WHERE s.Provincia  = 'Buenos Aires' AND p.TipoEnvio = 'Express' ORDER BY e.CostoEnvio DESC; 

SELECT p.IDPaquete, p.DescripcionContenido, p.Peso, p.TipoEnvio, e.FechaDespacho, e.Estado, e.CostoEnvio FROM Paquetes p JOIN Envios e ON p.IDPaquete = e.IDPaquete WHERE p.DescripcionContenido LIKE 'Caja%' AND YEAR(e.FechaDespacho)  = 2026 AND MONTH(e.FechaDespacho) = 5;
