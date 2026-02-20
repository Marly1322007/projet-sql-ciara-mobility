-- 1. NOMBRE DE LIGNES PAR TABLE
SELECT 'vehicule' as table_name, COUNT(*) as nb_lignes FROM vehicule
UNION ALL SELECT 'client',   COUNT(*) FROM client
UNION ALL SELECT 'station',  COUNT(*) FROM station
UNION ALL SELECT 'location', COUNT(*) FROM location
ORDER BY table_name;

-- 2. ÉTATS DISTINCTS DES VÉHICULES
SELECT etat, COUNT(*) as nb FROM vehicule GROUP BY etat ORDER BY etat;

-- 3. LOCATIONS AVEC DATE_FIN < DATE_DEBUT
SELECT id_location, date_debut, date_fin FROM location
WHERE date_fin IS NOT NULL AND date_fin < date_debut::date;

-- 4. EMAILS CLIENTS DUPLIQUÉS
SELECT email, COUNT(*) as doublons FROM client
GROUP BY email HAVING COUNT(*) > 1;

-- 5. CLÉS ÉTRANGÈRES MANQUANTES
SELECT l.id_location, l.id_client FROM location l
LEFT JOIN client c ON l.id_client = c.id_client WHERE c.id_client IS NULL;

SELECT l.id_location, l.id_vehicule FROM location l
LEFT JOIN vehicule v ON l.id_vehicule = v.id_vehicule WHERE v.id_vehicule IS NULL;

SELECT l.id_location, l.id_station_depart FROM location l
LEFT JOIN station s ON l.id_station_depart = s.id_station WHERE s.id_station IS NULL;

-- 6. VÉHICULE AVEC 2 LOCATIONS OUVERTES EN MÊME TEMPS
SELECT id_vehicule, COUNT(*) as locations_ouvertes FROM location
WHERE date_fin IS NULL GROUP BY id_vehicule HAVING COUNT(*) > 1;

-- 7. STATION DÉPART = STATION ARRIVÉE
SELECT id_location, id_station_depart, id_station_arrivee FROM location
WHERE id_station_arrivee IS NOT NULL AND id_station_depart = id_station_arrivee;