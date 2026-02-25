-- On sélectionne les locations avec leurs stations de départ et d'arrivée.
-- La station de départ est obligatoire dans le schéma, donc un INNER JOIN suffit.
-- La station d'arrivée peut être absente (location en cours), donc on utilise un LEFT JOIN.
-- On joint deux fois la table station grâce à des alias pour distinguer départ et arrivée.

SELECT 
    location.id_location,
    location.date_debut,
    location.date_fin,
    station_depart.nom  AS station_depart,
    station_depart.ville AS ville_depart,
    station_arrivee.nom  AS station_arrivee,
    station_arrivee.ville AS ville_arrivee
FROM location
INNER JOIN station AS station_depart  
        ON location.id_station_depart = station_depart.id_station
LEFT JOIN station AS station_arrivee 
        ON location.id_station_arrivee = station_arrivee.id_station;