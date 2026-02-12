 -- Nombre de locations par client
SELECT client_id, COUNT(*) AS NbLocations
FROM locations
GROUP BY client_id; 
