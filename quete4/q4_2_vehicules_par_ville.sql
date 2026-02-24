--Nombre de véhicules par ville
SELECT ville, COUNT(*) AS nombre_vehicules
FROM vehicule
GROUP BY ville;