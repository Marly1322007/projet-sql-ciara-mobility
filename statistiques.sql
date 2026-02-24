-- 1. TAUX D'UTILISATION RÉEL PAR VILLE
SELECT
    vehicule.ville,
    COUNT(DISTINCT vehicule.id_vehicule) AS vehicules_total,
    COUNT(DISTINCT CASE WHEN location.date_fin IS NULL THEN vehicule.id_vehicule END) AS actuellement_loues,
    COUNT(DISTINCT CASE WHEN vehicule.etat = 'disponible' THEN vehicule.id_vehicule END) AS disponibles,
    COUNT(DISTINCT CASE WHEN vehicule.etat = 'en maintenance' THEN vehicule.id_vehicule END) AS en_maintenance,
    COUNT(DISTINCT CASE WHEN vehicule.etat = 'hors service' THEN vehicule.id_vehicule END) AS hors_service,
    ROUND(
        COUNT(DISTINCT CASE WHEN location.date_fin IS NULL THEN vehicule.id_vehicule END) * 100.0 /
        COUNT(DISTINCT vehicule.id_vehicule), 2
    ) AS taux_utilisation_pourcent
FROM vehicule
LEFT JOIN location
    ON vehicule.id_vehicule = location.id_vehicule
GROUP BY vehicule.ville
ORDER BY taux_utilisation_pourcent DESC;


-- 2. REVENUS PAR VILLE ET PAR MOIS
SELECT
    vehicule.ville,
    DATE_TRUNC('month', location.date_debut) AS mois,
    COUNT(location.id_location) AS nombre_locations,
    SUM(
        CASE
            WHEN vehicule.type_vehicule = 'voiture' THEN 50
            WHEN vehicule.type_vehicule = 'scooter' THEN 15
            WHEN vehicule.type_vehicule = 'trottinette' THEN 5
            WHEN vehicule.type_vehicule = 'vélo' THEN 10
            ELSE 0
        END
    ) AS revenus_euros
FROM location
JOIN vehicule
    ON location.id_vehicule = vehicule.id_vehicule
GROUP BY vehicule.ville, DATE_TRUNC('month', location.date_debut)
ORDER BY mois, revenus_euros DESC;


-- 3. REVENUS PAR TYPE DE VÉHICULE
SELECT
    vehicule.type_vehicule,
    COUNT(location.id_location) AS nombre_locations,
    SUM(
        CASE
            WHEN vehicule.type_vehicule = 'voiture' THEN 50
            WHEN vehicule.type_vehicule = 'scooter' THEN 15
            WHEN vehicule.type_vehicule = 'trottinette' THEN 5
            WHEN vehicule.type_vehicule = 'vélo' THEN 10
            ELSE 0
        END
    ) AS revenus_euros
FROM location
JOIN vehicule
    ON location.id_vehicule = vehicule.id_vehicule
GROUP BY vehicule.type_vehicule
ORDER BY revenus_euros DESC;


-- 4. ÉVOLUTION MENSUELLE
SELECT
    DATE_TRUNC('month', location.date_debut) AS mois,
    COUNT(location.id_location) AS nombre_locations,
    COUNT(DISTINCT location.id_client) AS clients_actifs,
    SUM(
        CASE
            WHEN vehicule.type_vehicule = 'voiture' THEN 50
            WHEN vehicule.type_vehicule = 'scooter' THEN 15
            WHEN vehicule.type_vehicule = 'trottinette' THEN 5
            WHEN vehicule.type_vehicule = 'vélo' THEN 10
            ELSE 0
        END
    ) AS revenus_euros
FROM location
JOIN vehicule
    ON location.id_vehicule = vehicule.id_vehicule
GROUP BY DATE_TRUNC('month', location.date_debut)
ORDER BY mois;


-- 5. SAISONNALITÉ PAR TRIMESTRE
SELECT
    EXTRACT(YEAR FROM location.date_debut) AS annee,
    EXTRACT(QUARTER FROM location.date_debut) AS trimestre,
    COUNT(location.id_location) AS nombre_locations
FROM location
GROUP BY EXTRACT(YEAR FROM location.date_debut),
         EXTRACT(QUARTER FROM location.date_debut)
ORDER BY annee, trimestre;


-- 6. JOUR DE LA SEMAINE LE PLUS ACTIF
SELECT
    EXTRACT(DOW FROM location.date_debut) AS jour_semaine,
    COUNT(location.id_location) AS nombre_locations
FROM location
GROUP BY EXTRACT(DOW FROM location.date_debut)
ORDER BY nombre_locations DESC;


-- 7. RENTABILITÉ PAR VÉHICULE
SELECT
    vehicule.marque,
    vehicule.modele,
    vehicule.type_vehicule,
    vehicule.ville,
    COUNT(location.id_location) AS fois_loue,
    COUNT(location.id_location) *
        CASE
            WHEN vehicule.type_vehicule = 'voiture' THEN 50
            WHEN vehicule.type_vehicule = 'scooter' THEN 15
            WHEN vehicule.type_vehicule = 'trottinette' THEN 5
            WHEN vehicule.type_vehicule = 'vélo' THEN 10
            ELSE 0
        END AS revenus_euros
FROM vehicule
LEFT JOIN location
    ON vehicule.id_vehicule = location.id_vehicule
GROUP BY vehicule.id_vehicule, vehicule.marque, vehicule.modele, vehicule.type_vehicule, vehicule.ville
ORDER BY revenus_euros DESC;


-- 8. COMPARAISON MARQUES DE LUXE (simplifiée)
SELECT
    vehicule.marque,
    COUNT(DISTINCT vehicule.id_vehicule) AS nombre_vehicules,
    COUNT(location.id_location) AS nombre_locations,
    ROUND(
        COUNT(location.id_location) * 1.0 / COUNT(DISTINCT vehicule.id_vehicule), 2
    ) AS locations_par_vehicule,
    ROUND(AVG(vehicule.autonomie_km), 0) AS autonomie_moyenne_km,
    COUNT(location.id_location) * 50 AS revenus_estimes_euros
FROM vehicule
LEFT JOIN location
    ON vehicule.id_vehicule = location.id_vehicule
WHERE vehicule.marque IN ('Mercedes', 'Lamborghini', 'Ferrari')
GROUP BY vehicule.marque
ORDER BY revenus_estimes_euros DESC;


-- 9. DURÉE MOYENNE DES LOCATIONS PAR TYPE
SELECT
    vehicule.type_vehicule,
    COUNT(location.id_location) AS nombre_locations,
    ROUND(AVG(location.date_fin - location.date_debut), 1) AS duree_moyenne_jours
FROM location
JOIN vehicule
    ON location.id_vehicule = vehicule.id_vehicule
WHERE location.date_fin IS NOT NULL
GROUP BY vehicule.type_vehicule
ORDER BY duree_moyenne_jours DESC;


-- 10. STATIONS LES PLUS ACTIVES (départs uniquement)
SELECT
    station.nom AS station,
    COUNT(location.id_location) AS nombre_departs
FROM station
LEFT JOIN location
    ON station.id_station = location.id_station_depart
GROUP BY station.nom
ORDER BY nombre_departs DESC;


-- 11. STATIONS EN DÉSÉQUILIBRE (simplifiée)
SELECT
    station.nom AS station,
    COUNT(location.id_station_depart) AS departs
FROM station
LEFT JOIN location
    ON station.id_station = location.id_station_depart
GROUP BY station.nom
HAVING COUNT(location.id_station_depart) > 5
ORDER BY departs DESC;


-- 12. TOP 10 CLIENTS
SELECT
    client.nom,
    client.prenom,
    client.email,
    COUNT(location.id_location) AS nombre_locations,
    MIN(location.date_debut) AS premiere_location,
    MAX(location.date_debut) AS derniere_location,
    SUM(
        CASE
            WHEN vehicule.type_vehicule = 'voiture' THEN 50
            WHEN vehicule.type_vehicule = 'scooter' THEN 15
            WHEN vehicule.type_vehicule = 'trottinette' THEN 5
            WHEN vehicule.type_vehicule = 'vélo' THEN 10
            ELSE 0
        END
    ) AS total_depense_euros
FROM location
JOIN client
    ON location.id_client = client.id_client
JOIN vehicule
    ON location.id_vehicule = vehicule.id_vehicule
GROUP BY client.id_client, client.nom, client.prenom, client.email
ORDER BY nombre_locations DESC
LIMIT 10;


-- 13. CLIENTS INACTIFS DEPUIS PLUS DE 90 JOURS
SELECT
    client.nom,
    client.prenom,
    client.email,
    COUNT(location.id_location) AS total_locations,
    MAX(location.date_debut) AS derniere_location,
    CURRENT_DATE - MAX(location.date_debut) AS jours_inactif
FROM location
JOIN client
    ON location.id_client = client.id_client
GROUP BY client.id_client, client.nom, client.prenom, client.email
HAVING CURRENT_DATE - MAX(location.date_debut) > 90
ORDER BY jours_inactif DESC;


-- 14. VÉHICULE PRÉFÉRÉ PAR CLIENT (simplifiée)
SELECT
    client.nom,
    client.prenom,
    vehicule.type_vehicule,
    COUNT(location.id_location) AS nombre_locations
FROM location
JOIN client
    ON location.id_client = client.id_client
JOIN vehicule
    ON location.id_vehicule = vehicule.id_vehicule
GROUP BY client.id_client, client.nom, client.prenom, vehicule.type_vehicule
ORDER BY client.nom, nombre_locations DESC;


-- 15. NOUVEAUX CLIENTS PAR MOIS (simplifiée)
SELECT
    DATE_TRUNC('month', MIN(location.date_debut)) AS mois_arrivee,
    location.id_client
FROM location
GROUP BY location.id_client
ORDER BY mois_arrivee;


-- 16. VÉHICULES JAMAIS LOUÉS
SELECT
    vehicule.marque,
    vehicule.modele,
    vehicule.type_vehicule,
    vehicule.autonomie_km,
    vehicule.ville,
    vehicule.etat
FROM vehicule
LEFT JOIN location
    ON vehicule.id_vehicule = location.id_vehicule
WHERE location.id_location IS NULL
ORDER BY vehicule.type_vehicule, vehicule.autonomie_km DESC;