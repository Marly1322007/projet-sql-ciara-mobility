--clientsavecminimum_2_locations.sql
-- On regroupe les locations par client
-- HAVING permet de filtrer après le GROUP BY, donc sur le COUNT
-- On garde uniquement les clients ayant au moins 2 locations
SELECT 
    client.nom,
    client.prenom,
    COUNT() AS nombre_locations
FROM location
INNER JOIN client 
        ON location.id_client = client.id_client
GROUP BY client.id_client, client.nom, client.prenom
HAVING COUNT() >= 2
ORDER BY nombre_locations DESC;