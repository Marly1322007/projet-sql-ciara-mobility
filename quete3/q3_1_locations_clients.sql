SELECT 
    location.id_location,
    location.date_debut,
    location.date_fin,
    client.nom,
    client.prenom,
    client.email
FROM location
INNER JOIN client ON location.id_client = client.id_client;