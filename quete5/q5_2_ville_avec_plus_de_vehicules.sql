-- Ville avec le plus de véhicules disponibles
SELECT ville, COUNT(*) AS nombre_vehicules
FROM vehicule
WHERE etat = 'disponible'
GROUP BY ville
ORDER BY nombre_vehicules DESC
LIMIT 1;