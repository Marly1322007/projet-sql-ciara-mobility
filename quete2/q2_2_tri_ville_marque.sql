--Véhicules disponibles triés par ville puis par marque
SELECT *
FROM vehicule
WHERE etat = 'disponible'
ORDER BY ville, marque;