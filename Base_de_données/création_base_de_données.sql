-- =====================================================
-- CRÉATION DE LA BASE DE DONNÉES cIAra Mobility
-- Système de location de véhicules électriques
-- Pour PostgreSQL
-- =====================================================

-- =====================================================
-- SUPPRESSION DES TABLES SI ELLES EXISTENT
-- =====================================================
DROP TABLE IF EXISTS location CASCADE;
DROP TABLE IF EXISTS client CASCADE;
DROP TABLE IF EXISTS vehicule CASCADE;
DROP TABLE IF EXISTS station CASCADE;

-- =====================================================
-- CRÉATION DES TABLES
-- =====================================================

-- Table des stations
CREATE TABLE station (
    id_station SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    ville VARCHAR(50) NOT NULL
);

-- Table des véhicules
CREATE TABLE vehicule (
    id_vehicule SERIAL PRIMARY KEY,
    marque VARCHAR(50) NOT NULL,
    modele VARCHAR(50) NOT NULL,
    type_vehicule VARCHAR(20) NOT NULL,
    autonomie_km INTEGER NOT NULL,
    etat VARCHAR(20) NOT NULL,
    ville VARCHAR(50) NOT NULL
);

-- Table des clients
CREATE TABLE client (
    id_client SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Table des locations
CREATE TABLE location (
    id_location SERIAL PRIMARY KEY,
    date_debut DATE NOT NULL,
    date_fin DATE,
    id_client INTEGER NOT NULL,
    id_vehicule INTEGER NOT NULL,
    id_station_depart INTEGER NOT NULL,
    id_station_arrivee INTEGER,
    FOREIGN KEY (id_client) REFERENCES client(id_client),
    FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule),
    FOREIGN KEY (id_station_depart) REFERENCES station(id_station),
    FOREIGN KEY (id_station_arrivee) REFERENCES station(id_station)
);

-- =====================================================
-- INSERTION DES DONNÉES
-- =====================================================

-- STATIONS (3 villes : Paris, Nantes, Champigny)
INSERT INTO station (nom, ville) VALUES
-- Paris (4 stations)
('Gare du Nord', 'Paris'),
('Tour Eiffel', 'Paris'),
('République', 'Paris'),
('Bastille', 'Paris'),

-- Nantes (3 stations)
('Gare de Nantes', 'Nantes'),
('Place Royale', 'Nantes'),
('Ile de Nantes', 'Nantes'),

-- Champigny (3 stations)
('Centre Ville Champigny', 'Champigny'),
('Mairie de Champigny', 'Champigny'),
('RER Champigny', 'Champigny');

-- =====================================================
-- VÉHICULES (48 véhicules - 7 états différents)
-- =====================================================

INSERT INTO vehicule (marque, modele, type_vehicule, autonomie_km, etat, ville) VALUES

-- VOITURES MERCEDES (10 véhicules)
('Mercedes', 'EQS', 'voiture', 780, 'disponible', 'Paris'),
('Mercedes', 'EQE', 'voiture', 660, 'disponible', 'Paris'),
('Mercedes', 'EQC', 'voiture', 450, 'en location', 'Nantes'),
('Mercedes', 'EQA', 'voiture', 420, 'réservé', 'Champigny'),
('Mercedes', 'EQB', 'voiture', 470, 'disponible', 'Paris'),
('Mercedes', 'EQS SUV', 'voiture', 600, 'en charge', 'Nantes'),
('Mercedes', 'EQV', 'voiture', 350, 'en maintenance', 'Paris'),
('Mercedes', 'EQE SUV', 'voiture', 590, 'disponible', 'Champigny'),
('Mercedes', 'EQB SUV', 'voiture', 480, 'en nettoyage', 'Paris'),
('Mercedes', 'GLE Hybrid', 'voiture', 410, 'disponible', 'Nantes'),

-- VOITURES LAMBORGHINI (5 véhicules)
('Lamborghini', 'Revuelto', 'voiture', 500, 'disponible', 'Paris'),
('Lamborghini', 'Urus Hybrid', 'voiture', 420, 'disponible', 'Paris'),
('Lamborghini', 'Sian', 'voiture', 380, 'en location', 'Nantes'),
('Lamborghini', 'Asterion', 'voiture', 450, 'réservé', 'Champigny'),
('Lamborghini', 'Terzo Millennio', 'voiture', 520, 'hors service', 'Paris'),

-- VOITURES FERRARI (6 véhicules)
('Ferrari', 'SF90 Stradale', 'voiture', 390, 'disponible', 'Paris'),
('Ferrari', 'SF90 Spider', 'voiture', 390, 'disponible', 'Nantes'),
('Ferrari', 'LaFerrari', 'voiture', 370, 'en location', 'Paris'),
('Ferrari', '296 GTB', 'voiture', 420, 'en charge', 'Champigny'),
('Ferrari', 'Purosangue Hybrid', 'voiture', 480, 'disponible', 'Paris'),
('Ferrari', 'Roma Hybrid', 'voiture', 400, 'en nettoyage', 'Nantes'),

-- SCOOTERS ÉLECTRIQUES (7 véhicules)
('Niu', 'MQi GT', 'scooter', 130, 'disponible', 'Paris'),
('Super Soco', 'CPx', 'scooter', 140, 'disponible', 'Nantes'),
('Vespa', 'Elettrica', 'scooter', 100, 'en location', 'Champigny'),
('Gogoro', 'S2', 'scooter', 110, 'réservé', 'Paris'),
('Etergo', 'AppScooter', 'scooter', 240, 'en maintenance', 'Nantes'),
('Niu', 'NQi Sport', 'scooter', 150, 'en charge', 'Champigny'),
('BMW', 'CE 04', 'scooter', 130, 'disponible', 'Paris'),

-- TROTTINETTES ÉLECTRIQUES (7 véhicules)
('Xiaomi', 'Mi Scooter Pro 2', 'trottinette', 45, 'disponible', 'Paris'),
('Segway', 'Ninebot Max', 'trottinette', 65, 'disponible', 'Nantes'),
('Dualtron', 'Thunder', 'trottinette', 120, 'disponible', 'Champigny'),
('Xiaomi', 'Mi Scooter 3', 'trottinette', 30, 'en location', 'Paris'),
('Ninebot', 'KickScooter', 'trottinette', 40, 'en charge', 'Nantes'),
('Dualtron', 'Ultra', 'trottinette', 100, 'hors service', 'Champigny'),
('E-TWOW', 'Booster V', 'trottinette', 35, 'disponible', 'Paris'),

-- VÉLOS ÉLECTRIQUES (12 véhicules)
('VanMoof', 'S3', 'vélo', 150, 'disponible', 'Paris'),
('Cowboy', 'C4', 'vélo', 70, 'disponible', 'Nantes'),
('Brompton', 'Electric', 'vélo', 50, 'disponible', 'Champigny'),
('Specialized', 'Turbo Vado', 'vélo', 130, 'en location', 'Paris'),
('Trek', 'Allant+', 'vélo', 90, 'réservé', 'Nantes'),
('Cannondale', 'Quick Neo', 'vélo', 75, 'en nettoyage', 'Champigny'),
('Giant', 'FastRoad E+', 'vélo', 100, 'disponible', 'Paris'),
('Riese & Müller', 'Supercharger', 'vélo', 180, 'en maintenance', 'Nantes'),
('Moustache', 'Friday 28', 'vélo', 120, 'disponible', 'Champigny'),
('Gazelle', 'Ultimate C380', 'vélo', 110, 'en charge', 'Paris'),
('Cube', 'Touring Hybrid', 'vélo', 95, 'disponible', 'Nantes'),
('Kalkhoff', 'Endeavour', 'vélo', 115, 'disponible', 'Champigny');

-- =====================================================
-- CLIENTS (3 familles : Smith, Bel, Arpeur)
-- =====================================================

INSERT INTO client (nom, prenom, email) VALUES
-- Famille SMITH (5 personnes)
('Smith', 'Sofia', 'sofia.smith@email.com'),
('Smith', 'Lucas', 'lucas.smith@email.com'),
('Smith', 'Emma', 'emma.smith@email.com'),
('Smith', 'Arthur', 'arthur.smith@email.com'),
('Smith', 'Inès', 'ines.smith@email.com'),

-- Famille BEL (5 personnes)
('Bel', 'Hugo', 'hugo.bel@email.com'),
('Bel', 'Léa', 'lea.bel@email.com'),
('Bel', 'Louis', 'louis.bel@email.com'),
('Bel', 'Jade', 'jade.bel@email.com'),
('Bel', 'Tom', 'tom.bel@email.com'),

-- Famille ARPEUR (5 personnes)
('Arpeur', 'Chloé', 'chloe.arpeur@email.com'),
('Arpeur', 'Gabriel', 'gabriel.arpeur@email.com'),
('Arpeur', 'Manon', 'manon.arpeur@email.com'),
('Arpeur', 'Nathan', 'nathan.arpeur@email.com'),
('Arpeur', 'Sarah', 'sarah.arpeur@email.com');

-- =====================================================
-- LOCATIONS (Février - Avril 2025)
-- =====================================================

INSERT INTO location (date_debut, date_fin, id_client, id_vehicule, id_station_depart, id_station_arrivee) VALUES

-- LOCATIONS TERMINÉES (Février - Mars 2025)
('2025-02-01', '2025-02-03', 1, 2, 1, 4),   -- Smith Sofia - Mercedes EQE
('2025-02-05', '2025-02-07', 2, 5, 4, 2),   -- Smith Lucas - Mercedes EQB
('2025-02-10', '2025-02-12', 3, 11, 5, 6),  -- Smith Emma - Lamborghini Revuelto
('2025-02-14', '2025-02-16', 6, 16, 1, 3),  -- Bel Hugo - Ferrari SF90 Stradale
('2025-02-20', '2025-02-20', 7, 22, 8, 10), -- Bel Léa - Niu scooter
('2025-02-25', '2025-02-27', 11, 10, 5, 7), -- Arpeur Chloé - Mercedes GLE
('2025-03-01', '2025-03-03', 4, 12, 2, 5),  -- Smith Arthur - Lamborghini Urus
('2025-03-05', '2025-03-05', 8, 23, 4, 1),  -- Bel Louis - Super Soco scooter
('2025-03-10', '2025-03-12', 12, 1, 1, 4),  -- Arpeur Gabriel - Mercedes EQS
('2025-03-15', '2025-03-15', 1, 47, 3, 2),  -- Smith Sofia - Gazelle vélo
('2025-03-20', '2025-03-22', 9, 20, 5, 6),  -- Bel Jade - Ferrari Purosangue
('2025-03-25', '2025-03-27', 13, 35, 8, 9), -- Arpeur Manon - VanMoof vélo
('2025-04-01', '2025-04-02', 10, 17, 6, 5), -- Bel Tom - Ferrari SF90 Spider
('2025-04-05', '2025-04-06', 14, 30, 1, 3), -- Arpeur Nathan - Segway trottinette
('2025-04-08', '2025-04-09', 5, 36, 5, 6),  -- Smith Inès - Cowboy vélo

-- LOCATIONS EN COURS (Avril 2025 - date_fin NULL)
('2025-04-10', NULL, 11, 3, 5, NULL),  -- Arpeur Chloé - Mercedes EQC
('2025-04-12', NULL, 1, 13, 8, NULL),  -- Smith Sofia - Lamborghini Sian
('2025-04-15', NULL, 6, 18, 1, NULL),  -- Bel Hugo - Ferrari LaFerrari
('2025-04-17', NULL, 7, 24, 6, NULL),  -- Bel Léa - Vespa scooter
('2025-04-18', NULL, 8, 31, 2, NULL),  -- Bel Louis - Xiaomi trottinette
('2025-04-19', NULL, 9, 38, 3, NULL);  -- Bel Jade - Specialized vélo

-- =====================================================
-- CRÉATION D'INDEX POUR LES PERFORMANCES
-- =====================================================

CREATE INDEX idx_vehicule_etat ON vehicule(etat);
CREATE INDEX idx_vehicule_ville ON vehicule(ville);
CREATE INDEX idx_vehicule_type ON vehicule(type_vehicule);
CREATE INDEX idx_location_client ON location(id_client);
CREATE INDEX idx_location_vehicule ON location(id_vehicule);
CREATE INDEX idx_location_dates ON location(date_debut, date_fin);
