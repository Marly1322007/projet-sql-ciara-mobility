-- Nombre de véhicules par ville
SELECT ville, COUNT(*) AS NbVehicules
FROM vehicules
GROUP BY ville;
