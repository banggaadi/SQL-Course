-- SUBQUERIES
SELECT film_id, title
FROM film
WHERE length > (
	SELECT AVG(length)
	FROM film
)

SELECT inventory.film_id, title
FROM inventory
INNER JOIN film 
ON inventory.film_id = film.film_id
WHERE inventory.store_id = 2
GROUP BY inventory.film_id, title
HAVING COUNT(*) > 3
ORDER by title ASC

--OR
SELECT *
FROM film
WHERE film_id IN
(
	SELECT film_id 
	FROM inventory
	WHERE store_id = 2
	GROUP BY film_id
	HAVING COUNT(*)>3
)

-- CHALLENGE 1
SELECT first_name, last_name
FROM customer
WHERE customer_id IN
(
	SELECT customer_id
	FROM payment
	WHERE DATE(payment_date) = '2020-01-25'
)

-- CHALLENGE 2
SELECT first_name, email
FROM customer
WHERE customer_id IN
(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount)>30
)

-- CHALLENGE 3
SELECT first_name, email
FROM customer
WHERE customer_id IN
(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 100
)
AND 
customer_id IN
(
	SELECT customer_id
	FROM customer cu
	INNER JOIN address ad
	ON ad.address_id = cu.address_id
	WHERE ad.district = 'California'
)

-- SUBQUERIES FROM
SELECT AVG(total_amount)
FROM
(
	SELECT customer_id, SUM(amount) as total_amount
	FROM payment
	GROUP BY customer_id
) AS subquery

-- CHALLENGE
SELECT ROUND(AVG(total_per_day), 2)
FROM
(
	SELECT DATE(payment_date), SUM(amount) as total_per_day
	FROM payment
	GROUP BY DATE(payment_date)
)

-- SUBQUERIES SELECT
SELECT * , (
	SELECT AVG(amount) 
	FROM payment
)
FROM payment

--CHALLENGE
SELECT * , (
	SELECT MAX(amount)
	FROM payment
) - amount
FROM payment

-- CORRELATED SUBQUERIES WHERE
SELECT * FROM payment p1
WHERE amount = 
(
	SELECT MAX(amount) FROM payment p2
	WHERE p1.customer_id = p2.customer_id
)
ORDER BY customer_id

--CHALLENGE
SELECT title, film_id, replacement_cost, rating
FROM film f1
WHERE replacement_cost = 
(
	SELECT MIN(replacement_cost) FROM film f2
	WHERE f1.rating = f2.rating
)

--CHALLENGE 2
SELECT title, film_id, length, rating
FROM film f1
WHERE length = 
(
	SELECT MAX(length) FROM film f2
	WHERE f1.rating = f2.rating
)

-- CORRELATED SUBQUERIES SELECT
SELECT *, 
(
	SELECT MAX(amount) from payment p2
	WHERE p1.customer_id = p2.customer_id
)
FROM payment p1
ORDER BY customer_id

-- CHALLENGE

SELECT payment_id, customer_id, staff_id, amount,
(
	SELECT SUM(amount) FROM payment p2
	WHERE p1.customer_id = p2.customer_id
) AS total_amount,
(
	SELECT COUNT(amount) FROM payment p3
	WHERE p1.customer_id = p3.customer_id
) AS total_count
FROM payment p1

-- CHALLENGE 2
SELECT title, replacement_cost, rating,
(
	SELECT ROUND(AVG(replacement_cost), 2) FROM film f2
	WHERE f1.rating = f2.rating
)
FROM film f1
ORDER BY replacement_cost DESC, title ASC

-- CHALLENGE 3

SELECT first_name, amount, payment_id
FROM payment p1
INNER JOIN customer c1
ON p1.customer_id  = c1.customer_id
WHERE amount = 
(
	SELECT MAX(amount) FROM payment p2 WHERE p1.customer_id = p2.customer_id
)