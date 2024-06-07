-- Matemathical
SELECT film_id, TRUNC(rental_rate/replacement_cost*100, 2) AS percentage
FROM film
WHERE TRUNC(rental_rate/replacement_cost*100, 2) < 4
ORDER BY percentage ASC

-- CASE WHEN
SELECT
title,
CASE
WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
WHEN description LIKE '%Drama%' AND length>90 THEN 'Long drama (tier 2)'
WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END as tier_list
FROM film
WHERE 
CASE
WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
WHEN description LIKE '%Drama%' AND length>90 THEN 'Long drama (tier 2)'
WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END is not null

-- CASE WHEN SUM
SELECT rating, COUNT(*)
FROM film
GROUP BY rating

-- CASE WHEN SUM
SELECT  
SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) AS "G",
SUM(CASE WHEN rating = 'PG-13'THEN 1 ELSE 0 END) AS "PG-13",
SUM(CASE WHEN rating = 'NC-17'THEN 1 ELSE 0 END) AS "NC-17",
SUM(CASE WHEN rating = 'PG'THEN 1 ELSE 0 END) AS "PG",
SUM(CASE WHEN rating = 'R'THEN 1 ELSE 0 END) AS "R"
FROM film

-- COALESCE CAST
SELECT rental_date, COALESCE(CAST(return_date AS VARCHAR), 'Not Returned')
FROM rental
ORDER BY rental_date DESC
