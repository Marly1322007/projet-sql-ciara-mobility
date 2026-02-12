SELECT ville, COUNT(*) AS nombre_vehicules
FROM vehicule
GROUP BY ville;