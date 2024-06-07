SELECT first_name, last_name, phone, address
FROM customer
RIGHT JOIN address 
ON customer.address_id = address.address_id
WHERE address.district = 'Texas' 

SELECT * 
FROM address
LEFT JOIN customer
ON customer.address_id = address.address_id
WHERE customer.customer_id IS NULL

-- CHALLENGE

SELECT first_name, last_name, email, country
FROM customer cu
LEFT JOIN address ad
ON cu.address_id = ad.address_id
LEFT JOIN city ci
ON ad.city_id = ci.city_id
LEFT JOIN country co
ON ci.country_id = co.country_id
WHERE co.country = 'Brazil'

SELECT *
FROM rental

SELECT *
FROM inventory

SELECT title, first_name, COUNT(*) 
FROM inventory inv
LEFT JOIN rental ren
ON inv.inventory_id = ren.inventory_id 
LEFT JOIN film
ON inv.film_id = film.film_id
LEFT JOIN customer cus
ON ren.customer_id = cus.customer_id
WHERE first_name = 'GEORGE' AND last_name = 'LINTON'
GROUP BY film.title, cus.customer_id, first_name
ORDER BY COUNT(*)  DESC
