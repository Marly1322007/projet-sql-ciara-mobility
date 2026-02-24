# Projet SQL B1 - cIAra Mobility

## Binôme - B1 Info
- Marly DEDJIHO
- Mariam KEITA

---

## Description

Projet de gestion de locations de véhicules électriques pour l'entreprise fictive cIAra Mobility. On a travaillé sur une base de données PostgreSQL que l'on a entièrement créée nous-mêmes, et on a répondu à des besoins métier concrets à travers 5 quêtes SQL progressives.

---

## Notre Base de Données

On n'a pas utilisé de base fournie — on a tout conçu et créé depuis zéro. La base contient 4 tables, avec 500 locations réparties sur 12 mois (février 2025 à février 2026) pour refléter une activité réaliste.

On a intégré une vraie saisonnalité dans les données : moins de locations en hiver, un pic en été, et une montée progressive au printemps. Les clients arrivent aussi progressivement dans le temps, comme dans une vraie entreprise qui grandit.

La base contient :
- 48 véhicules répartis sur 4 villes (Paris, Nantes, Lyon, Marseille)
- 40 clients de 10 familles différentes
- 12 stations de location, 3 par ville
- 500 locations avec saisonnalité réelle

---

## Structure du projet
```
projet-sql-ciara-mobility/
├── README.md
├── base_ciara_FINALE.sql
├── quete1/
│   ├── q1.1_tous_vehicules.sql
│   ├── q1.2_vehicules_disponibles.sql
│   ├── q1.3_vehicules_ville.sql
│   └── q1.4_autonomie_400.sql
├── quete2/
│   ├── q2.1_tri_autonomie.sql
│   ├── q2.2_tri_ville_marque.sql
│   └── q2.3_clients_alpha.sql
├── quete3/
│   ├── q3.1_locations_clients.sql
│   ├── q3.2_locations_vehicules.sql
│   └── q3.3_stations.sql
├── quete4/
│   ├── q4.1_total_vehicules.sql
│   ├── q4.2_vehicules_par_ville.sql
│   ├── q4.3_autonomie_moyenne.sql
│   └── q4.4_locations_par_client.sql
├── quete5/
│   ├── q5.1_top3_autonomes.sql
│   ├── q5.2_ville_plus_vehicules.sql
│   ├── q5.3_clients_2_locations.sql
│   └── q5.4_vehicules_jamais_loues.sql
├── STATISTIQUES.sql
└── TESTS.sql
```

---

## La base de données

### Table vehicule
- id_vehicule : identifiant unique
- marque : Mercedes, Lamborghini, Ferrari...
- modele : modèle du véhicule
- type_vehicule : voiture, scooter, trottinette, vélo
- autonomie_km : autonomie en kilomètres
- etat : disponible, en location, en maintenance, hors service
- ville : Paris, Nantes, Lyon, Marseille

### Table station
- id_station : identifiant unique
- nom : nom de la station
- ville : ville de la station

### Table client
- id_client : identifiant unique
- nom : nom de famille
- prenom : prénom
- email : email unique

### Table location
- id_location : identifiant unique
- date_debut : date de début
- date_fin : date de fin, NULL si la location est encore en cours
- id_client, id_vehicule, id_station_depart, id_station_arrivee : clés étrangères

---

## Avancement

- [x] Base de données créée par nos soins
- [x] Quête 1 - Marly
- [x] Quête 2 - Mariam
- [x] Quête 3 - Marly
- [x] Quête 4 - Mariam
- [x] Quête 5 - Ensemble
- [x] STATISTIQUES.sql - Marly
- [x] TESTS.sql - Mariam
- [x] Rapport d'analyse

---

# Rapport d'Analyse Technique

## A. Organisation du travail

On a réparti les quêtes selon la progression du cours. Marly a pris les quêtes 1 et 3, Mariam les quêtes 2 et 4. La quête 5 a été faite ensemble parce qu'elle combine tout ce qu'on a appris. La création de la base de données a aussi été faite ensemble depuis le début.

Répartition :
- Marly : Quêtes 1 et 3 (7 requêtes) + STATISTIQUES.sql
- Mariam : Quêtes 2 et 4 (7 requêtes) + TESTS.sql
- Ensemble : Quête 5 + création de la base

On a travaillé avec PostgreSQL et pgAdmin 4 pour tester les requêtes, et Visual Studio Code pour écrire le code. Notre méthode : lire la consigne, réfléchir à la logique, écrire la requête, tester, corriger si besoin.

---

## B. Le modèle de données

### Comment on a conçu la base

On a fait plusieurs choix pour que la base soit réaliste. On a choisi 4 villes françaises, des véhicules variés et on a généré 500 locations sur 12 mois avec une vraie courbe saisonnière : peu de locations en hiver, beaucoup en été.

On a aussi laissé volontairement 6 véhicules jamais loués, pour que la requête de promotion retourne de vrais résultats. Et les clients n'arrivent pas tous en même temps : 10 au départ, puis 10 de plus chaque trimestre, pour simuler la croissance d'une entreprise.

### Les relations entre les tables

La table location est au centre du schéma. Elle relie les clients, les véhicules et les stations.

- Un client peut faire plusieurs locations (relation 1 vers N)
- Un véhicule peut être loué plusieurs fois (relation 1 vers N)
- Une station peut accueillir plusieurs départs et arrivées (relation 1 vers N)

Points importants : date_fin peut être NULL si la location est en cours, id_station_arrivee aussi. On teste toujours ces cas avec IS NULL et jamais avec = NULL.
Cette structure centralisée autour de location permet d'interroger n'importe 
quel croisement client/véhicule/station en une seule requête avec jointures, 
ce qui est essentiel pour le suivi opérationnel de la flotte cIAra 
(savoir qui loue quoi, où, et depuis quand).
---

## C. Choix techniques

### INNER JOIN et LEFT JOIN

On utilise INNER JOIN quand on veut seulement les lignes qui ont une correspondance dans les deux tables. Par exemple pour afficher les locations avec leurs clients, puisque toute location a forcément un client.

On utilise LEFT JOIN quand on veut garder toutes les lignes de la première table même sans correspondance. Par exemple pour les stations d'arrivée qui peuvent être NULL, ou pour trouver les véhicules jamais loués.

### GROUP BY et HAVING

GROUP BY sert à regrouper les données pour faire des calculs. HAVING filtre après le regroupement, ce qu'on ne peut pas faire avec WHERE. La règle : WHERE filtre avant de grouper, HAVING filtre après. Et toute colonne affichée qui n'est pas dans une agrégation doit être dans le GROUP BY.

### Fonctions utilisées

COUNT, AVG, SUM pour les calculs courants. TO_CHAR pour formater les dates. EXTRACT pour récupérer le trimestre ou l'année. MODE pour trouver le type de véhicule préféré d'un client. INTERVAL pour les calculs de durée.

---

## D. Difficultés rencontrées et solutions

### Marly (Quêtes 1 & 3)

**Jointure double sur station :** On devait afficher départ ET arrivée de la même table, donc on a utilisé des alias pour joindre `station` deux fois.

**Gestion des valeurs NULL :** Les locations en cours n'ont pas de station d'arrivée. On a utilisé LEFT JOIN pour garder toutes les locations et `IS NULL` pour tester les valeurs nulles.

### Mariam (Quêtes 2 & 4)

**Différence WHERE et HAVING :** On voulait filtrer les clients avec plusieurs locations mais `WHERE COUNT(*) >= 2` ne marchait pas. WHERE filtre avant GROUP BY, HAVING filtre après les agrégations.

**Colonnes dans GROUP BY :** On affichait nom et prénom mais on groupait uniquement par id_client, ce qui causait une erreur. On a ajouté nom et prénom dans le GROUP BY pour résoudre le problème.

### Ensemble (Quête 5)

**Véhicules jamais loués :** On a utilisé LEFT JOIN puis WHERE IS NULL pour trouver les véhicules sans location.

**Top 3 correct :** LIMIT seul prenait 3 au hasard, on a ajouté ORDER BY avant pour trier d'abord.

---

## E. Schéma de la base
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

## F. Fichiers complémentaires

### création_base_de_données.sql

C'est notre base de données complète. Le fichier crée les 4 tables, insère les 12 stations, les 48 véhicules, les 40 clients et les 500 locations. Les index sont aussi créés pour améliorer les performances.

### STATISTIQUES.sql (Marly)

Des analyses avancées pour répondre à des questions métier : taux d'utilisation par ville, revenus par type de véhicule, évolution mensuelle, saisonnalité par trimestre, stations les plus actives, clients les plus fidèles, véhicules à promouvoir...

### TESTS.sql (Mariam)

Des requêtes de vérification pour s'assurer que la base est cohérente. On vérifie qu'aucune location n'a une date de fin avant la date de début, que les emails sont uniques, que toutes les clés étrangères sont valides, qu'aucun véhicule n'est loué deux fois en même temps... Ces tests ne retournent aucune ligne quand tout va bien, ce qui est exactement le résultat attendu.


### Gestion de version (Git/GitHub)

On a utilisé Git avec GitHub pour travailler en parallèle sans se marcher dessus.

- **Fréquence des commits** : on a commité à chaque fin de session de travail, ou dès qu'une quête ou un fichier était terminé (ex : "création de la base données, mise en place des quetes q1,q3", "ajout de la première partie de la quete 5").
- **Répartition** : chacune travaillait sur sa propre branche de fichiers (Marly sur quête 1, 3, STATISTIQUES — Mariam sur quête 2, 4, TESTS), ce qui évitait les conflits.
- **Conflits** : on n'a pas eu de conflits majeurs car on ne modifiait pas les mêmes fichiers en même temps. Pour le README et la base, on se coordonnait avant de pusher.
- **Nommage** : en début de projet certains commits ont des noms courts ("nn"), on a amélioré ça ensuite avec des messages plus explicites.
