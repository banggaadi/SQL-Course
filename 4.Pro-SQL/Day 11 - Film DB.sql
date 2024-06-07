-- OVER PARTITION BY
SELECT *, COUNT(*) OVER (PARTITION BY customer_id)
FROM payment
ORDER BY 1

-- CHALLENGE 1 
SELECT film.film_id, title, length, name, ROUND(AVG(length) OVER(PARTITION BY name), 2)
FROM film
LEFT JOIN film_category fc
ON film.film_id = fc.film_id
LEFT JOIN category
ON fc.category_id = category.category_id
ORDER BY film_id ASC

-- CHALLENGE 2
SELECT payment_id, customer_id, staff_id, rental_id, amount, payment_date, COUNT(payment_id) OVER(PARTITION BY customer_id, amount)
FROM payment
ORDER BY payment_id ASC

-- OVER ORDER BY
SELECT *, SUM(amount) OVER(PARTITION BY customer_id ORDER BY payment_date)
FROM payment

-- RANK
SELECT * FROM (
	SELECT title, length, name, DENSE_RANK() OVER(PARTITION BY name ORDER BY length DESC) AS rank
	FROM film
	LEFT JOIN film_category fc
	ON film.film_id = fc.film_id
	LEFT JOIN category
	ON fc.category_id = category.category_id
)
WHERE rank = 1

-- CHALLENGE 1
SELECT CONCAT(first_name,' ', last_name) AS name, 
       country, 
       COUNT(*) AS payment_count,
       RANK() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rank
FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
LEFT JOIN address ON address.address_id = customer.address_id
LEFT JOIN city ON city.city_id = address.city_id
LEFT JOIN country ON country.country_id = city.country_id
GROUP BY name, country
ORDER BY country ASC;

-- FIRST VALUE
SELECT CONCAT(first_name,' ', last_name) AS name, 
       country, 
       COUNT(*) AS payment_count,
       FIRST_VALUE(COUNT(*)) OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rank
FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
LEFT JOIN address ON address.address_id = customer.address_id
LEFT JOIN city ON city.city_id = address.city_id
LEFT JOIN country ON country.country_id = city.country_id
GROUP BY name, country
ORDER BY country ASC;

-- LEAD & LAG
SELECT CONCAT(first_name,' ', last_name) AS name, 
       country, 
       COUNT(*) AS payment_count,
       LEAD(CONCAT(first_name,' ', last_name)) OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rank
FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
LEFT JOIN address ON address.address_id = customer.address_id
LEFT JOIN city ON city.city_id = address.city_id
LEFT JOIN country ON country.country_id = city.country_id
GROUP BY name, country
ORDER BY country ASC

SELECT CONCAT(first_name,' ', last_name) AS name, 
       country, 
       COUNT(*) AS payment_count,
       LAG(CONCAT(first_name,' ', last_name)) OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rank
FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
LEFT JOIN address ON address.address_id = customer.address_id
LEFT JOIN city ON city.city_id = address.city_id
LEFT JOIN country ON country.country_id = city.country_id
GROUP BY name, country
ORDER BY country ASC

-- CHALLENGE
SELECT SUM(amount),DATE(payment_date) AS day,  
	LAG(SUM(amount)) 
		OVER(ORDER BY DATE(payment_date)) AS previous_day,
	SUM(amount) - LAG(SUM(amount)) 
		OVER(ORDER BY DATE(payment_date)) AS differences,
	ROUND((SUM(amount)-LAG(SUM(amount))OVER(ORDER BY DATE(payment_date))) / LAG(SUM(amount))OVER(ORDER BY DATE(payment_date)), 2) AS growth
FROM payment
GROUP BY DATE(payment_date)
