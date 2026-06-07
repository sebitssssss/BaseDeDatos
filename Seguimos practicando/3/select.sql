USE fg;

SELECT c.Tematica, SUM(ch.AsistentesEstimados) AS TotalAsistentes FROM Charlas ch JOIN Congresos c ON ch.IDCongreso = c.IDCongreso JOIN Expositores e ON ch.IDExpositor = e.IDExpositor WHERE e.Pais IN ('Chile', 'Brasil') AND ch.AsistentesEstimados > 100 GROUP BY c.Tematica HAVING COUNT(ch.IDCharla) > 2;

SELECT e.Pais, AVG(ch.AsistentesEstimados) AS PromedioAsistentes FROM Charlas ch JOIN Congresos c ON ch.IDCongreso = c.IDCongreso JOIN Expositores e ON ch.IDExpositor = e.IDExpositor WHERE c.Tematica = 'Inteligencia Artificial' GROUP BY e.Pais;

SELECT ch.TituloCharla, e.Nombre AS NombreExpositor, ch.DuracionMinutos FROM Charlas ch JOIN Expositores e ON ch.IDExpositor = e.IDExpositor WHERE ch.DuracionMinutos > 60 ORDER BY ch.DuracionMinutos DESC;

SELECT Tematica, PrecioInscripcion FROM Congresos WHERE Tematica LIKE '%Avanzada%' OR Tematica LIKE '%Inteligencia%' ORDER BY Tematica ASC;