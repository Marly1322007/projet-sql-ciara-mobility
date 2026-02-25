# Projet SQL B1 - cIAra Mobility

## Binôme - B1 Informatique
**Marly DEDJIHO**  
**Mariam KEITA**

---

## Description du projet

Projet de gestion de locations de véhicules électriques pour l'entreprise fictive **cIAra Mobility**.

Nous avons entièrement conçu et généré la base de données, puis l'avons exploitée à travers **5 quêtes SQL progressives** répondant à des besoins métier concrets.

**Objectifs :**
- Concevoir un modèle relationnel cohérent  
- Générer des données réalistes avec saisonnalité  
- Maîtriser les jointures et agrégations  
- Répondre à des problématiques analytiques métier  

---

## Notre Base de Données

Nous n'avons pas utilisé de base fournie — nous avons tout conçu et créé depuis zéro.

**Volumétrie :**
- **48 véhicules** répartis sur 4 villes (Paris, Nantes, Lyon, Marseille)
- **40 clients** arrivant progressivement
- **12 stations** de location (3 par ville)
- **500 locations** sur 12 mois (février 2025 à février 2026)

**Réalisme des données :**
- Saisonnalité intégrée : 64 locations en hiver, 183 en été
- Croissance progressive des clients (10 → 20 → 30 → 40)
- 6 véhicules jamais loués pour tester la promotion
- Locations en cours (date_fin NULL)

---

## Structure du projet
```
projet-sql-ciara-mobility/
├── README.md
├── Base_de_données/création_base_de_données.sql
├── quete1/
│   ├── q1_1_tous_les_vehicules.sql
│   ├── q1_2_vehicules_disponibles.sql
│   ├── q1_3_vehicules_ville.sql
│   └── q1_4_autonomie_400.sql
├── quete2/
│   ├── q2_1_tri_autonomie.sql
│   ├── q2_2_tri_ville_marque.sql
│   └── q2_3_clients_alpha.sql
├── quete3/
│   ├── q3_1_locations_clients.sql
│   ├── q3_2_locations_vehicules.sql
│   └── q3_3_stations.sql
├── quete4/
│   ├── q4_1_total_vehicules.sql
│   ├── q4_2_vehicules_par_ville.sql
│   ├── q4_3_autonomie_moyenne.sql
│   └── q4_4_locations_par_client.sql
├── quete5/
│   ├── q5_1_top3_autonomes.sql
│   ├── q5_2_ville_avec_plus_de_vehicules.sql
│   ├── q5_3_clientsavecminimum_2_locations.sql
│   └── q5_4_vehicules_jamais_loues.sql
├── STATISTIQUES.sql
└── TESTS.sql
```

---

# Rapport d'Analyse Technique

## A. Organisation du travail

**Répartition des tâches :**
- **Marly** : Quêtes 1 et 3 (7 requêtes) + STATISTIQUES.sql
- **Mariam** : Quêtes 2 et 4 (7 requêtes) + TESTS.sql
- **Ensemble** : Quête 5 (4 requêtes) + création de la base + README

**Total :** 18 requêtes SQL + 16 statistiques + 7 tests

**Environnement technique :**
- **SGBD** : PostgreSQL 18
- **Interface** : pgAdmin 4
- **Éditeur** : Visual Studio Code
- **Gestion de version** : Git + GitHub

**Méthodologie :**
1. Analyse de la consigne
2. Conception de la logique SQL
3. Écriture de la requête
4. Test dans pgAdmin
5. Correction si erreur
6. Validation et commit Git

---

## B. Modèle relationnel

### Table vehicule
```sql
CREATE TABLE vehicule (
    id_vehicule    SERIAL PRIMARY KEY,
    marque         VARCHAR(50) NOT NULL,
    modele         VARCHAR(50) NOT NULL,
    type_vehicule  VARCHAR(20) NOT NULL,
    autonomie_km   INTEGER     NOT NULL,
    etat           VARCHAR(20) NOT NULL,
    ville          VARCHAR(50) NOT NULL
);
```

**Colonnes importantes :**
- `id_vehicule` : Identifiant unique auto-incrémenté
- `type_vehicule` : voiture, scooter, trottinette, vélo
- `autonomie_km` : autonomie en kilomètres
- `etat` : disponible, en location, en maintenance, hors service
- `ville` : Paris, Nantes, Lyon, Marseille

---

### Table station
```sql
CREATE TABLE station (
    id_station SERIAL PRIMARY KEY,
    nom        VARCHAR(100) NOT NULL,
    ville      VARCHAR(50)  NOT NULL
);
```

**Données :** 12 stations, 3 par ville

---

### Table client
```sql
CREATE TABLE client (
    id_client SERIAL PRIMARY KEY,
    nom       VARCHAR(50)  NOT NULL,
    prenom    VARCHAR(50)  NOT NULL,
    email     VARCHAR(100) UNIQUE NOT NULL
);
```

**Contrainte importante :** `email UNIQUE` évite les doublons clients

---

### Table location
```sql
CREATE TABLE location (
    id_location        SERIAL PRIMARY KEY,
    date_debut         DATE    NOT NULL,
    date_fin           DATE,
    id_client          INTEGER NOT NULL,
    id_vehicule        INTEGER NOT NULL,
    id_station_depart  INTEGER NOT NULL,
    id_station_arrivee INTEGER,
    FOREIGN KEY (id_client)          REFERENCES client(id_client),
    FOREIGN KEY (id_vehicule)        REFERENCES vehicule(id_vehicule),
    FOREIGN KEY (id_station_depart)  REFERENCES station(id_station),
    FOREIGN KEY (id_station_arrivee) REFERENCES station(id_station)
);
```

**Colonnes importantes :**
- `date_fin` : NULL si la location est en cours
- `id_station_arrivee` : NULL si le véhicule n'est pas encore rendu
- **4 clés étrangères** : garantissent l'intégrité référentielle

---

### Schéma relationnel
```
┌──────────────┐         ┌─────────────┐
│    CLIENT    │         │   STATION   │
├──────────────┤         ├─────────────┤
│ id_client PK │         │ id_station  │
│ nom          │         │ nom         │
│ prenom       │         │ ville       │
│ email UNIQUE │         └─────────────┘
└──────────────┘               │
       │                       │
       └──────────┐   ┌────────┘
                  │   │
           ┌──────▼───▼──────────┐
           │      LOCATION       │
           ├─────────────────────┤
           │ id_location      PK │
           │ date_debut          │
           │ date_fin    (NULL?) │
           │ id_client        FK │
           │ id_vehicule      FK │
           │ id_station_depart FK│
           │ id_station_arr   FK │
           └─────────────────────┘
                      │
              ┌───────▼─────────┐
              │    VEHICULE     │
              ├─────────────────┤
              │ id_vehicule  PK │
              │ marque          │
              │ modele          │
              │ type_vehicule   │
              │ autonomie_km    │
              │ etat            │
              │ ville           │
              └─────────────────┘
```

---

## Pertinence métier

La table `location` est au centre du schéma. Elle relie clients, véhicules et stations.

**Relations :**
- Un client peut faire plusieurs locations (1:N)
- Un véhicule peut être loué plusieurs fois (1:N)
- Une station peut accueillir plusieurs départs et arrivées (1:N)

**Choix techniques répondant aux besoins métier :**

- **`date_fin` NULL** → suivre les locations en cours
- **`id_station_arrivee` NULL** → véhicule encore en trajet
- **`etat` dans vehicule** → connaître la disponibilité immédiate
- **`email UNIQUE`** → éviter les doublons clients
- **Table `location` centrale** → éviter toute duplication de données

Cette structure centralisée permet d'interroger n'importe quel croisement client/véhicule/station en une seule requête avec jointures, essentiel pour le suivi opérationnel de la flotte cIAra Mobility.

---

## C. Choix techniques SQL

### INNER JOIN et LEFT JOIN

**INNER JOIN** : utilisé quand la relation est obligatoire dans les deux tables.

Exemple : afficher les locations avec leurs clients (toute location a forcément un client).

**LEFT JOIN** : utilisé quand on veut garder toutes les lignes de la première table même sans correspondance.

Exemple : afficher toutes les stations même celles sans départ, ou les véhicules jamais loués.

---

### Exemple concret : Véhicules jamais loués

**Problème métier :** Identifier les véhicules à promouvoir

**Solution SQL :**
```sql
SELECT 
    vehicule.id_vehicule,
    vehicule.marque,
    vehicule.modele,
    vehicule.type_vehicule
FROM vehicule
LEFT JOIN location ON vehicule.id_vehicule = location.id_vehicule
WHERE location.id_location IS NULL;
```

**Pourquoi LEFT JOIN + IS NULL ?**
- LEFT JOIN garde **tous les véhicules**, même sans location
- WHERE IS NULL filtre uniquement ceux qui n'ont **jamais été loués**
- Avec INNER JOIN, on perdrait ces véhicules
- Avec NOT IN, on risque des problèmes si la sous-requête contient NULL

---

### Jointure double sur la même table

**Problème :** Afficher départ ET arrivée depuis la même table `station`.

**Solution :** Utiliser des alias pour joindre `station` deux fois.
```sql
SELECT 
    location.id_location,
    station_depart.nom  AS station_depart,
    station_arrivee.nom  AS station_arrivee
FROM location
INNER JOIN station AS station_depart  
    ON location.id_station_depart = station_depart.id_station
LEFT JOIN station AS station_arrivee 
    ON location.id_station_arrivee = station_arrivee.id_station;
```

**Explications :**
- `station_depart` et `station_arrivee` sont des alias pour différencier
- INNER JOIN sur départ (toujours présent)
- LEFT JOIN sur arrivée (peut être NULL si location en cours)

---

### GROUP BY et HAVING

**Différence WHERE vs HAVING :**

| WHERE | HAVING |
|-------|--------|
| Filtre **AVANT** GROUP BY | Filtre **APRÈS** GROUP BY |
| Sur lignes individuelles | Sur groupes agrégés |
| ❌ Pas de COUNT/AVG | ✅ Avec COUNT/AVG |

**Exemple :**
```sql
-- ❌ ERREUR : WHERE ne peut pas utiliser COUNT
SELECT client.nom, COUNT(*) 
FROM location
JOIN client ON location.id_client = client.id_client
WHERE COUNT(*) >= 2  -- ❌ Erreur
GROUP BY client.nom;

-- ✅ CORRECT : HAVING filtre après le regroupement
SELECT client.nom, COUNT(*) 
FROM location
JOIN client ON location.id_client = client.id_client
GROUP BY client.nom
HAVING COUNT(*) >= 2;  -- ✅ OK
```

**Ordre d'exécution SQL :**
1. FROM / JOIN
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY
7. LIMIT

→ **C'est pourquoi WHERE ne peut pas utiliser COUNT : il s'exécute AVANT le regroupement !**

**Règle importante :** Toute colonne affichée qui n'est pas dans une agrégation doit être dans le GROUP BY.

---

### Fonctions utilisées

- **COUNT, AVG, SUM** : calculs courants
- **TO_CHAR** : formater les dates
- **EXTRACT** : récupérer trimestre ou année
- **INTERVAL** : calculs de durée

---

## D. Difficultés rencontrées et solutions

### 1. Différence WHERE et HAVING

**Problème :** On voulait filtrer les clients avec plusieurs locations mais `WHERE COUNT(*) >= 2` ne marchait pas.

**Solution :** WHERE filtre avant GROUP BY, HAVING filtre après les agrégations.

---

### 2. Colonnes manquantes dans GROUP BY

**Problème :** On affichait nom et prénom mais on groupait uniquement par id_client, ce qui causait une erreur.

**Solution :** Ajouter toutes les colonnes non agrégées dans le GROUP BY.

---

### 3. Jointure double sur la même table

**Problème :** Afficher départ ET arrivée depuis la même table `station`.

**Solution :** Utiliser des alias (AS station_depart, AS station_arrivee).

---

### 4. Gestion des valeurs NULL

**Problème :** Les locations en cours n'ont pas de station d'arrivée.

**Solution :** Utiliser LEFT JOIN pour garder toutes les locations et IS NULL (jamais = NULL) pour tester les valeurs nulles.

---

### 5. Construction cohérente de 500 locations

**Problème :** Générer une saisonnalité réaliste et une croissance progressive.

**Solution :** Script avec distribution par trimestre et arrivée progressive des clients.

---

## E. Gestion de version (Git/GitHub)

Nous avons utilisé Git avec GitHub pour travailler en parallèle.

**Méthode de travail :**
- Dépôt GitHub partagé entre Marly et Mariam
- Chacune travaillait sur ses propres fichiers pour éviter les conflits
- Commits réguliers à chaque fin de session ou quête terminée
- Synchronisation avant de pusher les fichiers partagés (README, base)

**Répartition des commits :**
- **Marly** → quêtes 1, 3 + STATISTIQUES.sql + création de la base
- **Mariam** → quêtes 2, 4 + TESTS.sql
- **Ensemble** → quête 5 + README final

**Nommage :** Messages de commit explicites décrivant l'action menée.
Le projet a évolué par **itérations successives** avec corrections et améliorations jusqu'à la version finale stable, ce qui explique les nombreux commits


---

## F. Fichiers complémentaires

### création_base_de_données.sql

Script SQL complet contenant :
- DROP et création des 4 tables avec contraintes
- Insertion de 12 stations
- Insertion de 48 véhicules (répartis dans 4 villes)
- Insertion de 40 clients
- Insertion de 500 locations (avec saisonnalité)
- Création de 6 index pour optimiser les performances

---

### STATISTIQUES.sql (Marly)

16 requêtes d'analyse avancées :
- Taux d'utilisation réel par ville
- Revenus par ville et par mois
- Revenus par type de véhicule
- Évolution mensuelle de l'activité
- Saisonnalité par trimestre
- Jour de la semaine le plus actif
- Rentabilité par véhicule
- Comparaison des marques de luxe
- Durée moyenne des locations
- Stations les plus actives
- Stations en déséquilibre
- Top 10 des clients les plus fidèles
- Clients inactifs depuis plus de 90 jours
- Véhicule préféré par client
- Nouveaux clients par mois
- Véhicules jamais loués (à promouvoir)

---

### TESTS.sql (Mariam)

7 requêtes de vérification :
- Nombre de lignes par table
- États distincts des véhicules
- Locations avec date_fin < date_debut (incohérence)
- Emails clients dupliqués
- Clés étrangères manquantes
- Véhicules avec 2 locations ouvertes simultanément
- Locations où station_depart = station_arrivee

**Principe :** Ces requêtes ne retournent **aucune ligne** si la base est cohérente.

---

## G. Apports pédagogiques

Ce projet a été réalisé grâce aux connaissances acquises lors de la **piscine SQL** et des cours.

Les exercices pratiques de la piscine nous ont permis de maîtriser les bases du SQL (SELECT, WHERE, JOIN, GROUP BY), ce qui nous a aidées à construire des requêtes plus complexes dans ce projet.

**Ressources utilisées :**
- Documentation PostgreSQL
- pgAdmin 4 Documentation
- Piscine SQL (exercices pratiques)
- Support de cours SQL B1
- Documentation des mentors

---

## H. Améliorations possibles

Si le projet devait être étendu :

**Techniques :**
- Contraintes CHECK
- Vues SQL
- Index supplémentaires
- Procédures stockées
- Triggers

**Fonctionnelles :**
- Table TARIF (facturation)
- Table ABONNEMENT (forfaits clients)
- Table INCIDENT (pannes et accidents)
- Table MAINTENANCE (planification entretien)
- Table PROMOTION (offres commerciales)

**Application :**
- Interface web (PHP/Python + PostgreSQL)
- Système d'authentification
- Tableau de bord analytique
- API REST
- Système de paiement

---

# Conclusion

Ce projet nous a permis de passer de la théorie à la pratique en maîtrisant les jointures, les agrégations et la conception d'une base relationnelle complète.

Nous avons conçu une base de données entièrement depuis zéro, répondant à des besoins métiers réels, tout en travaillant de manière structurée en binôme avec Git.

**Nous sommes maintenant capables de concevoir et interroger une base de données métier réaliste de A à Z.**

---

## Points forts du projet

✅ Base de données entièrement conçue par le binôme  
✅ Données réalistes avec saisonnalité sur 12 mois  
✅ 500 locations générées avec cohérence métier  
✅ Requêtes fonctionnelles répondant aux besoins  
✅ Bonne répartition du travail en binôme  
✅ Documentation complète et structurée  
✅ Fichiers complémentaires (STATISTIQUES et TESTS)  

---

## Contact

**Marly DEDJIHO**  
**Mariam KEITA**  
Paris Ynov Campus - B1 Informatique