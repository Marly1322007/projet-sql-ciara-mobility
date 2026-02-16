SELECT marque, modele, autonomie_km, etat, ville
FROM vehicule
WHERE etat = 'disponible'
ORDER BY autonomie_km DESC
LIMIT 3;