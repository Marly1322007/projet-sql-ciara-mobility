--vehicules_jamais_loues.sql 
-- On garde tous les véhicules grâce au LEFT JOIN
-- Ceux sans location ont les colonnes de location à NULL
-- Le filtre IS NULL permet donc de trouver les véhicules jamais loués
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