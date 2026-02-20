
-- 1. TAUX D'UTILISATION RÉEL PAR VILLE (basé sur locations ouvertes)
SELECT
    v.ville,
    COUNT(DISTINCT v.id_vehicule) as vehicules_total,
    COUNT(DISTINCT CASE WHEN l.date_fin IS NULL THEN v.id_vehicule END) as actuellement_loues,
    COUNT(DISTINCT CASE WHEN v.etat = 'disponible'     THEN v.id_vehicule END) as disponibles,
    COUNT(DISTINCT CASE WHEN v.etat = 'en maintenance' THEN v.id_vehicule END) as en_maintenance,
    COUNT(DISTINCT CASE WHEN v.etat = 'hors service'   THEN v.id_vehicule END) as hors_service,
    ROUND(
        COUNT(DISTINCT CASE WHEN l.date_fin IS NULL THEN v.id_vehicule END) * 100.0 /
        COUNT(DISTINCT v.id_vehicule), 2
    ) as taux_utilisation_pourcent
FROM vehicule v
LEFT JOIN location l ON v.id_vehicule = l.id_vehicule
GROUP BY v.ville
ORDER BY taux_utilisation_pourcent DESC;


-- 2. REVENUS PAR VILLE ET PAR MOIS
SELECT
    v.ville,
    TO_CHAR(l.date_debut, 'YYYY-MM') as mois,
    COUNT(*) as nombre_locations,
    SUM(CASE
        WHEN v.type_vehicule = 'voiture'     THEN 50
        WHEN v.type_vehicule = 'scooter'     THEN 15
        WHEN v.type_vehicule = 'trottinette' THEN 5
        WHEN v.type_vehicule = 'vélo'        THEN 10
        ELSE 0
    END) as revenus_euros
FROM location l
JOIN vehicule v ON l.id_vehicule = v.id_vehicule
GROUP BY v.ville, TO_CHAR(l.date_debut, 'YYYY-MM')
ORDER BY mois, revenus_euros DESC;


-- 3. REVENUS PAR TYPE DE VÉHICULE
SELECT
    v.type_vehicule,
    COUNT(*) as nombre_locations,
    SUM(CASE
        WHEN v.type_vehicule = 'voiture'     THEN 50
        WHEN v.type_vehicule = 'scooter'     THEN 15
        WHEN v.type_vehicule = 'trottinette' THEN 5
        WHEN v.type_vehicule = 'vélo'        THEN 10
        ELSE 0
    END) as revenus_euros
FROM location l
JOIN vehicule v ON l.id_vehicule = v.id_vehicule
GROUP BY v.type_vehicule
ORDER BY revenus_euros DESC;


-- 4. ÉVOLUTION MENSUELLE : LOCATIONS, CLIENTS ACTIFS ET REVENUS
SELECT
    TO_CHAR(l.date_debut, 'YYYY-MM') as mois,
    COUNT(*) as nombre_locations,
    COUNT(DISTINCT l.id_client) as clients_actifs,
    SUM(CASE
        WHEN v.type_vehicule = 'voiture'     THEN 50
        WHEN v.type_vehicule = 'scooter'     THEN 15
        WHEN v.type_vehicule = 'trottinette' THEN 5
        WHEN v.type_vehicule = 'vélo'        THEN 10
        ELSE 0
    END) as revenus_euros
FROM location l
JOIN vehicule v ON l.id_vehicule = v.id_vehicule
GROUP BY TO_CHAR(l.date_debut, 'YYYY-MM')
ORDER BY mois;


-- 5. SAISONNALITÉ PAR TRIMESTRE
SELECT
    EXTRACT(YEAR    FROM date_debut) as annee,
    EXTRACT(QUARTER FROM date_debut) as trimestre,
    COUNT(*) as nombre_locations
FROM location
GROUP BY annee, trimestre
ORDER BY annee, trimestre;


-- 6. JOUR DE LA SEMAINE LE PLUS ACTIF
SELECT
    TO_CHAR(date_debut, 'Day') as jour,
    COUNT(*) as nombre_locations
FROM location
GROUP BY TO_CHAR(date_debut, 'Day'), EXTRACT(DOW FROM date_debut)
ORDER BY nombre_locations DESC;


-- 7. RENTABILITÉ PAR VÉHICULE
SELECT
    v.marque,
    v.modele,
    v.type_vehicule,
    v.ville,
    COUNT(l.id_location) as fois_loue,
    COUNT(l.id_location) * CASE
        WHEN v.type_vehicule = 'voiture'     THEN 50
        WHEN v.type_vehicule = 'scooter'     THEN 15
        WHEN v.type_vehicule = 'trottinette' THEN 5
        WHEN v.type_vehicule = 'vélo'        THEN 10
        ELSE 0
    END as revenus_euros
FROM vehicule v
LEFT JOIN location l ON v.id_vehicule = l.id_vehicule
GROUP BY v.id_vehicule, v.marque, v.modele, v.type_vehicule, v.ville
ORDER BY revenus_euros DESC;


-- 8. COMPARAISON MARQUES DE LUXE
SELECT
    v.marque,
    COUNT(DISTINCT v.id_vehicule) as nombre_vehicules,
    COUNT(l.id_location) as nombre_locations,
    ROUND(COUNT(l.id_location)::NUMERIC / COUNT(DISTINCT v.id_vehicule), 2) as locations_par_vehicule,
    ROUND(AVG(v.autonomie_km), 0) as autonomie_moyenne_km,
    COUNT(l.id_location) * 50 as revenus_estimes_euros
FROM vehicule v
LEFT JOIN location l ON v.id_vehicule = l.id_vehicule
WHERE v.marque IN ('Mercedes', 'Lamborghini', 'Ferrari')
GROUP BY v.marque
ORDER BY revenus_estimes_euros DESC;


-- 9. DURÉE MOYENNE DES LOCATIONS PAR TYPE
SELECT
    v.type_vehicule,
    COUNT(*) as nombre_locations,
    ROUND(AVG(l.date_fin - l.date_debut), 1) as duree_moyenne_jours
FROM location l
JOIN vehicule v ON l.id_vehicule = v.id_vehicule
WHERE l.date_fin IS NOT NULL
GROUP BY v.type_vehicule
ORDER BY duree_moyenne_jours DESC;


-- 10. STATIONS LES PLUS ACTIVES
SELECT
    s.nom as station,
    s.ville,
    COUNT(DISTINCT d.id_location) as departs,
    COUNT(DISTINCT a.id_location) as arrivees,
    COUNT(DISTINCT d.id_location) + COUNT(DISTINCT a.id_location) as activite_totale
FROM station s
LEFT JOIN location d ON s.id_station = d.id_station_depart
LEFT JOIN location a ON s.id_station = a.id_station_arrivee
GROUP BY s.id_station, s.nom, s.ville
ORDER BY activite_totale DESC;


-- 11. STATIONS EN DÉSÉQUILIBRE
SELECT
    s.nom as station,
    s.ville,
    COUNT(DISTINCT d.id_location) as departs,
    COUNT(DISTINCT a.id_location) as arrivees,
    COUNT(DISTINCT d.id_location) - COUNT(DISTINCT a.id_location) as solde
FROM station s
LEFT JOIN location d ON s.id_station = d.id_station_depart
LEFT JOIN location a ON s.id_station = a.id_station_arrivee
GROUP BY s.id_station, s.nom, s.ville
HAVING ABS(COUNT(DISTINCT d.id_location) - COUNT(DISTINCT a.id_location)) > 1
ORDER BY solde ASC;


-- 12. TOP 10 CLIENTS LES PLUS FIDÈLES
SELECT
    c.nom,
    c.prenom,
    c.email,
    COUNT(*) as nombre_locations,
    MIN(l.date_debut) as premiere_location,
    MAX(l.date_debut) as derniere_location,
    SUM(CASE
        WHEN v.type_vehicule = 'voiture'     THEN 50
        WHEN v.type_vehicule = 'scooter'     THEN 15
        WHEN v.type_vehicule = 'trottinette' THEN 5
        WHEN v.type_vehicule = 'vélo'        THEN 10
        ELSE 0
    END) as total_depense_euros
FROM location l
JOIN client c ON l.id_client = c.id_client
JOIN vehicule v ON l.id_vehicule = v.id_vehicule
GROUP BY c.id_client, c.nom, c.prenom, c.email
ORDER BY nombre_locations DESC
LIMIT 10;


-- 13. CLIENTS INACTIFS DEPUIS PLUS DE 90 JOURS
SELECT
    c.nom,
    c.prenom,
    c.email,
    COUNT(l.id_location) as total_locations,
    MAX(l.date_debut) as derniere_location,
    CURRENT_DATE - MAX(l.date_debut) as jours_inactif
FROM location l
JOIN client c ON l.id_client = c.id_client
GROUP BY c.id_client, c.nom, c.prenom, c.email
HAVING CURRENT_DATE - MAX(l.date_debut) > 90
ORDER BY jours_inactif DESC;


-- 14. VÉHICULE PRÉFÉRÉ PAR CLIENT (type le plus loué)
SELECT
    c.nom,
    c.prenom,
    c.email,
    MODE() WITHIN GROUP (ORDER BY v.type_vehicule) as vehicule_prefere,
    COUNT(l.id_location) as nombre_locations
FROM location l
JOIN client c ON l.id_client = c.id_client
JOIN vehicule v ON l.id_vehicule = v.id_vehicule
GROUP BY c.id_client, c.nom, c.prenom, c.email
ORDER BY nombre_locations DESC;


-- 15. NOUVEAUX CLIENTS PAR MOIS (croissance de la clientèle)
SELECT
    TO_CHAR(premiere_location, 'YYYY-MM') as mois_arrivee,
    COUNT(*) as nouveaux_clients
FROM (
    SELECT id_client, MIN(date_debut) as premiere_location
    FROM location
    GROUP BY id_client
) AS p
GROUP BY TO_CHAR(p.premiere_location, 'YYYY-MM')
ORDER BY mois_arrivee;


-- 16. VÉHICULES JAMAIS LOUÉS (à promouvoir)
SELECT
    v.marque,
    v.modele,
    v.type_vehicule,
    v.autonomie_km,
    v.ville,
    v.etat
FROM vehicule v
LEFT JOIN location l ON v.id_vehicule = l.id_vehicule
WHERE l.id_location IS NULL
ORDER BY v.type_vehicule, v.autonomie_km DESC;
