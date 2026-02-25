--vehicules_jamais_loues.sql 
SELECT 
    vehicule.id_vehicule,
    vehicule.marque,
    vehicule.modele,
    vehicule.type_vehicule,
    vehicule.ville
FROM vehicule
LEFT JOIN location 
       ON vehicule.id_vehicule = location.id_vehicule
WHERE location.id_location IS NULL;