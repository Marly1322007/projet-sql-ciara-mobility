-- Locations avec station de départ ET d'arrivée
SELECT 
    location.id_location,
    location.date_debut,
    location.date_fin,
    station_depart.nom  AS station_depart,
    station_depart.ville AS ville_depart,
    station_arrivee.nom  AS station_arrivee,
    station_arrivee.ville AS ville_arrivee
FROM location
INNER JOIN station AS station_depart  ON location.id_station_depart  = station_depart.id_station
LEFT  JOIN station AS station_arrivee ON location.id_station_arrivee = station_arrivee.id_station;