-- =====================================================
-- PROJET SQL B1 - cIAra Mobility
-- Fichier 2 ULTRA-COMPLET : Données avec TOUS les états
-- Auteurs : Marly & Mariam
-- Villes : Nantes, Paris, Champigny
-- Marques : Mercedes, Lamborghini, Ferrari
-- États : disponible, en location, réservé, en maintenance, 
--         en charge, en nettoyage, hors service
-- =====================================================

-- =====================================================
-- INSERTION DES STATIONS
-- =====================================================
INSERT INTO station (nom, ville) VALUES
-- Stations à Paris
('Gare du Nord', 'Paris'),
('Tour Eiffel', 'Paris'),
('République', 'Paris'),
('Bastille', 'Paris'),

-- Stations à Nantes
('Gare de Nantes', 'Nantes'),
('Place Royale', 'Nantes'),
('Ile de Nantes', 'Nantes'),

-- Stations à Champigny
('Centre Ville Champigny', 'Champigny'),
('Mairie de Champigny', 'Champigny'),
('RER Champigny', 'Champigny');

-- =====================================================
-- INSERTION DES VÉHICULES AVEC TOUS LES ÉTATS
-- =====================================================
INSERT INTO vehicule (marque, modele, type_vehicule, autonomie_km, etat, ville) VALUES

-- ========== VOITURES MERCEDES (10 véhicules) ==========
('Mercedes', 'EQS', 'voiture', 780, 'disponible', 'Paris'),
('Mercedes', 'EQE', 'voiture', 660, 'disponible', 'Paris'),
('Mercedes', 'EQC', 'voiture', 450, 'en location', 'Nantes'),       -- EN LOCATION
('Mercedes', 'EQA', 'voiture', 420, 'réservé', 'Champigny'),        -- RÉSERVÉ
('Mercedes', 'EQB', 'voiture', 470, 'disponible', 'Paris'),
('Mercedes', 'EQS SUV', 'voiture', 600, 'en charge', 'Nantes'),     -- EN CHARGE
('Mercedes', 'EQV', 'voiture', 350, 'en maintenance', 'Paris'),     -- EN MAINTENANCE
('Mercedes', 'EQE SUV', 'voiture', 590, 'disponible', 'Champigny'),
('Mercedes', 'EQB SUV', 'voiture', 480, 'en nettoyage', 'Paris'),   -- EN NETTOYAGE
('Mercedes', 'GLE Hybrid', 'voiture', 410, 'disponible', 'Nantes'),

-- ========== VOITURES LAMBORGHINI (5 véhicules) ==========
('Lamborghini', 'Revuelto', 'voiture', 500, 'disponible', 'Paris'),
('Lamborghini', 'Urus Hybrid', 'voiture', 420, 'disponible', 'Paris'),
('Lamborghini', 'Sian', 'voiture', 380, 'en location', 'Nantes'),  -- EN LOCATION
('Lamborghini', 'Asterion', 'voiture', 450, 'réservé', 'Champigny'), -- RÉSERVÉ
('Lamborghini', 'Terzo Millennio', 'voiture', 520, 'hors service', 'Paris'), -- HORS SERVICE (accident)

-- ========== VOITURES FERRARI (6 véhicules) ==========
('Ferrari', 'SF90 Stradale', 'voiture', 390, 'disponible', 'Paris'),
('Ferrari', 'SF90 Spider', 'voiture', 390, 'disponible', 'Nantes'),
('Ferrari', 'LaFerrari', 'voiture', 370, 'en location', 'Paris'),  -- EN LOCATION
('Ferrari', '296 GTB', 'voiture', 420, 'en charge', 'Champigny'),  -- EN CHARGE
('Ferrari', 'Purosangue Hybrid', 'voiture', 480, 'disponible', 'Paris'),
('Ferrari', 'Roma Hybrid', 'voiture', 400, 'en nettoyage', 'Nantes'), -- EN NETTOYAGE

-- ========== SCOOTERS ÉLECTRIQUES (7 véhicules) ==========
('Niu', 'MQi GT', 'scooter', 130, 'disponible', 'Paris'),
('Super Soco', 'CPx', 'scooter', 140, 'disponible', 'Nantes'),
('Vespa', 'Elettrica', 'scooter', 100, 'en location', 'Champigny'),  -- EN LOCATION
('Gogoro', 'S2', 'scooter', 110, 'réservé', 'Paris'),                -- RÉSERVÉ
('Etergo', 'AppScooter', 'scooter', 240, 'en maintenance', 'Nantes'), -- EN MAINTENANCE
('Niu', 'NQi Sport', 'scooter', 150, 'en charge', 'Champigny'),      -- EN CHARGE
('BMW', 'CE 04', 'scooter', 130, 'disponible', 'Paris'),

-- ========== TROTTINETTES ÉLECTRIQUES (7 véhicules) ==========
('Xiaomi', 'Mi Scooter Pro 2', 'trottinette', 45, 'disponible', 'Paris'),
('Segway', 'Ninebot Max', 'trottinette', 65, 'disponible', 'Nantes'),
('Dualtron', 'Thunder', 'trottinette', 120, 'disponible', 'Champigny'),
('Xiaomi', 'Mi Scooter 3', 'trottinette', 30, 'en location', 'Paris'),  -- EN LOCATION
('Ninebot', 'KickScooter', 'trottinette', 40, 'en charge', 'Nantes'),   -- EN CHARGE
('Dualtron', 'Ultra', 'trottinette', 100, 'hors service', 'Champigny'), -- HORS SERVICE
('E-TWOW', 'Booster V', 'trottinette', 35, 'disponible', 'Paris'),

-- ========== VÉLOS ÉLECTRIQUES (12 véhicules) ==========
('VanMoof', 'S3', 'vélo', 150, 'disponible', 'Paris'),
('Cowboy', 'C4', 'vélo', 70, 'disponible', 'Nantes'),
('Brompton', 'Electric', 'vélo', 50, 'disponible', 'Champigny'),
('Specialized', 'Turbo Vado', 'vélo', 130, 'en location', 'Paris'),  -- EN LOCATION
('Trek', 'Allant+', 'vélo', 90, 'réservé', 'Nantes'),                -- RÉSERVÉ
('Cannondale', 'Quick Neo', 'vélo', 75, 'en nettoyage', 'Champigny'), -- EN NETTOYAGE
('Giant', 'FastRoad E+', 'vélo', 100, 'disponible', 'Paris'),
('Riese & Müller', 'Supercharger', 'vélo', 180, 'en maintenance', 'Nantes'), -- EN MAINTENANCE
('Moustache', 'Friday 28', 'vélo', 120, 'disponible', 'Champigny'),
('Gazelle', 'Ultimate C380', 'vélo', 110, 'en charge', 'Paris'),     -- EN CHARGE
('Cube', 'Touring Hybrid', 'vélo', 95, 'disponible', 'Nantes'),
('Kalkhoff', 'Endeavour', 'vélo', 115, 'disponible', 'Champigny');

-- =====================================================
-- INSERTION DES CLIENTS
-- Familles : Erica, Faria, Cécile
-- =====================================================
INSERT INTO client (nom, prenom, email) VALUES
-- Famille ERICA (5 personnes)
('Erica', 'Sofia', 'sofia.erica@email.com'),
('Erica', 'Lucas', 'lucas.erica@email.com'),
('Erica', 'Emma', 'emma.erica@email.com'),
('Erica', 'Arthur', 'arthur.erica@email.com'),
('Erica', 'Inès', 'ines.erica@email.com'),

-- Famille FARIA (5 personnes)
('Faria', 'Hugo', 'hugo.faria@email.com'),
('Faria', 'Léa', 'lea.faria@email.com'),
('Faria', 'Louis', 'louis.faria@email.com'),
('Faria', 'Jade', 'jade.faria@email.com'),
('Faria', 'Tom', 'tom.faria@email.com'),

-- Famille CÉCILE (5 personnes)
('Cécile', 'Chloé', 'chloe.cecile@email.com'),
('Cécile', 'Gabriel', 'gabriel.cecile@email.com'),
('Cécile', 'Manon', 'manon.cecile@email.com'),
('Cécile', 'Nathan', 'nathan.cecile@email.com'),
('Cécile', 'Sarah', 'sarah.cecile@email.com');

-- =====================================================
-- INSERTION DES LOCATIONS
-- Dates : Février - Avril 2025
-- =====================================================
INSERT INTO location (date_debut, date_fin, id_client, id_vehicule, id_station_depart, id_station_arrivee) VALUES

-- ========== LOCATIONS TERMINÉES (Février - Mars 2025) ==========
-- Location 1 : Erica Sofia loue Mercedes EQE
('2025-02-01', '2025-02-03', 1, 2, 1, 4),

-- Location 2 : Erica Lucas loue Mercedes EQB
('2025-02-05', '2025-02-07', 2, 5, 4, 2),

-- Location 3 : Erica Emma loue Lamborghini Revuelto
('2025-02-10', '2025-02-12', 3, 11, 5, 6),

-- Location 4 : Faria Hugo loue Ferrari SF90 Stradale
('2025-02-14', '2025-02-16', 6, 16, 1, 3),

-- Location 5 : Faria Léa loue Niu scooter
('2025-02-20', '2025-02-20', 7, 22, 8, 10),

-- Location 6 : Cécile Chloé loue Mercedes GLE
('2025-02-25', '2025-02-27', 11, 10, 5, 7),

-- Location 7 : Erica Arthur loue Lamborghini Urus
('2025-03-01', '2025-03-03', 4, 12, 2, 5),

-- Location 8 : Faria Louis loue Super Soco scooter
('2025-03-05', '2025-03-05', 8, 23, 4, 1),

-- Location 9 : Cécile Gabriel loue Mercedes EQS
('2025-03-10', '2025-03-12', 12, 1, 1, 4),

-- Location 10 : Erica Sofia loue Gazelle vélo
('2025-03-15', '2025-03-15', 1, 47, 3, 2),

-- Location 11 : Faria Jade loue Ferrari Purosangue
('2025-03-20', '2025-03-22', 9, 20, 5, 6),

-- Location 12 : Cécile Manon loue VanMoof vélo
('2025-03-25', '2025-03-27', 13, 35, 8, 9),

-- Location 13 : Faria Tom loue Ferrari SF90 Spider
('2025-04-01', '2025-04-02', 10, 17, 6, 5),

-- Location 14 : Cécile Nathan loue Segway trottinette
('2025-04-05', '2025-04-06', 14, 30, 1, 3),

-- Location 15 : Erica Inès loue Cowboy vélo
('2025-04-08', '2025-04-09', 5, 36, 5, 6),

-- ========== LOCATIONS EN COURS (Avril 2025 - date_fin NULL) ==========
-- Ces véhicules ont l'état "en location"

-- Location 16 : Mercedes EQC - EN LOCATION ACTUELLE
('2025-04-10', NULL, 11, 3, 5, NULL),

-- Location 17 : Lamborghini Sian - EN LOCATION ACTUELLE  
('2025-04-12', NULL, 1, 13, 8, NULL),

-- Location 18 : Ferrari LaFerrari - EN LOCATION ACTUELLE
('2025-04-15', NULL, 6, 18, 1, NULL),

-- Location 19 : Vespa scooter - EN LOCATION ACTUELLE
('2025-04-17', NULL, 7, 24, 6, NULL),

-- Location 20 : Xiaomi trottinette - EN LOCATION ACTUELLE
('2025-04-18', NULL, 8, 31, 2, NULL),

-- Location 21 : Specialized vélo - EN LOCATION ACTUELLE
('2025-04-19', NULL, 9, 38, 3, NULL);

-- =====================================================
-- STATISTIQUES DÉTAILLÉES
-- =====================================================

-- Vue d'ensemble des états
-- SELECT etat, COUNT(*) as nombre
-- FROM vehicule
-- GROUP BY etat
-- ORDER BY nombre DESC;

-- Résultat attendu :
-- disponible : 26 véhicules
-- en location : 6 véhicules
-- réservé : 4 véhicules
-- en charge : 4 véhicules
-- en nettoyage : 3 véhicules
-- en maintenance : 3 véhicules
-- hors service : 2 véhicules

-- Véhicules actuellement loués (détails)
-- SELECT v.marque, v.modele, v.type_vehicule, c.nom, c.prenom, l.date_debut
-- FROM vehicule v
-- JOIN location l ON v.id_vehicule = l.id_vehicule
-- JOIN client c ON l.id_client = c.id_client
-- WHERE l.date_fin IS NULL
-- ORDER BY l.date_debut;

-- Véhicules réservés pour bientôt
-- SELECT marque, modele, type_vehicule, ville
-- FROM vehicule
-- WHERE etat = 'réservé';

-- Véhicules en charge (batteries)
-- SELECT marque, modele, type_vehicule, autonomie_km, ville
-- FROM vehicule
-- WHERE etat = 'en charge'
-- ORDER BY autonomie_km DESC;

-- Véhicules en maintenance
-- SELECT marque, modele, type_vehicule, ville
-- FROM vehicule
-- WHERE etat = 'en maintenance';

-- Véhicules hors service (à réparer/remplacer)
-- SELECT marque, modele, type_vehicule, ville
-- FROM vehicule
-- WHERE etat = 'hors service';

-- Véhicules en nettoyage
-- SELECT marque, modele, type_vehicule, ville
-- FROM vehicule
-- WHERE etat = 'en nettoyage';

-- Répartition par type et état
-- SELECT type_vehicule, etat, COUNT(*) as nombre
-- FROM vehicule
-- GROUP BY type_vehicule, etat
-- ORDER BY type_vehicule, etat;

-- Top véhicules disponibles par autonomie
-- SELECT marque, modele, autonomie_km, ville
-- FROM vehicule
-- WHERE etat = 'disponible'
-- ORDER BY autonomie_km DESC
-- LIMIT 10;