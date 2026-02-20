SELECT 
    client.nom,
    client.prenom,
    COUNT(*) as nombre_locations
FROM location
INNER JOIN client ON location.id_client = client.id_client
GROUP BY client.id_client, client.nom, client.prenom
HAVING COUNT(*) >= 2
ORDER BY nombre_locations DESC;