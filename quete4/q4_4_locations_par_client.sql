 --Nombre de locations par client
SELECT 
    client.nom,
    client.prenom,
    COUNT(*) AS nombre_locations
FROM location
INNER JOIN client ON location.id_client = client.id_client
GROUP BY client.id_client, client.nom, client.prenom
ORDER BY nombre_locations DESC;