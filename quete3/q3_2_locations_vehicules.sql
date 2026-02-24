-- Locations avec les infos du véhicule
SELECT 
    location.id_location,
    location.date_debut,
    location.date_fin,
    vehicule.marque,
    vehicule.modele,
    vehicule.type_vehicule,
    vehicule.autonomie_km
FROM location
INNER JOIN vehicule ON location.id_vehicule = vehicule.id_vehicule;