--Question 1:
--Level: Simple
--Topic: DISTINCT
--Task: Create a list of all the different (distinct) replacement costs of the films.
--Question: What's the lowest replacement cost?

SELECT DISTINCT MIN(replacement_cost) AS lowest_replacement_cost
FROM film

--Question 2:
--Level: Moderate
--Topic: CASE + GROUP BY
--Task: Write a query that gives an overview of how many films have replacements costs in the following cost ranges
--low: 9.99 - 19.99
--medium: 20.00 - 24.99
--high: 25.00 - 29.99
--Question: How many films have a replacement cost in the "low" group?

SELECT COUNT(replacement_cost),
	CASE 
		WHEN replacement_cost >= 9.99 AND replacement_cost <= 19.99 THEN 'low'
		WHEN replacement_cost >= 20.00 AND replacement_cost <= 24.99 THEN 'medium'
		WHEN replacement_cost >= 25.00 AND replacement_cost <= 29.99 THEN 'high'
		ELSE 'None'
	END AS category
FROM film
WHERE 
CASE
	WHEN replacement_cost >= 9.99 AND replacement_cost <= 19.99 THEN 'low'
END = 'low'
GROUP BY category

--Question 3:
--Level: Moderate
--Topic: JOIN
--Task: Create a list of the film titles including their title, length, and category name ordered descendingly by length. Filter the results to only the movies in the category 'Drama' or 'Sports'.
--Question: In which category is the longest film and how long is it?

SELECT category.name, MAX(film.length) 
FROM film 
INNER JOIN film_category cat
ON film.film_id = cat.film_id
INNER JOIN category
ON category.category_id = cat.category_id
WHERE category.name = 'Sports' OR category.name = 'Drama'
GROUP BY category.name, film.length
ORDER BY film.length DESC

--Question 4:
--Level: Moderate
--Topic: JOIN & GROUP BY
--Task: Create an overview of how many movies (titles) there are in each category (name).
--Question: Which category (name) is the most common among the films?
SELECT category.name, COUNT(category.name)
FROM film 
INNER JOIN film_category cat
ON film.film_id = cat.film_id
INNER JOIN category
ON category.category_id = cat.category_id
GROUP BY category.name
ORDER BY COUNT(category.name) DESC

--Question 5:
--Level: Moderate
--Topic: JOIN & GROUP BY
--Task: Create an overview of the actors' first and last names and in how many movies they appear in.
--Question: Which actor is part of most movies??

SELECT first_name, last_name, COUNT(*)
FROM actor
JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY first_name, last_name
ORDER BY COUNT(*) DESC

--Question 6:
--Level: Moderate
--Topic: LEFT JOIN & FILTERING
--Task: Create an overview of the addresses that are not associated to any customer.
--Question: How many addresses are that?
--Answer: 4

SELECT COUNT(*)
FROM customer
RIGHT JOIN address
ON customer.address_id = address.address_id
WHERE customer.address_id IS NULL

--Question 7:
--Level: Moderate
--Topic: JOIN & GROUP BY
--Task: Create the overview of the sales  to determine the from which city (we are interested in the city in which the 
--customer lives, not where the store is) most sales occur.
--Question: What city is that and how much is the amount?
--Answer: Cape Coral with a total amount of 221.55

SELECT city, SUM(amount)
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY city
ORDER BY SUM(amount) DESC

--Question 8:
--Level: Moderate to difficult
--Topic: JOIN & GROUP BY
--Task: Create an overview of the revenue (sum of amount) grouped by a column in the format "country, city".
--Question: Which country, city has the least sales?
--Answer: United States, Tallahassee with a total amount of 50.85.

SELECT country, city, SUM(amount)
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY country, city
ORDER BY SUM(amount) ASC

--Question 9:
--Level: Difficult
--Topic: Uncorrelated subquery
--Task: Create a list with the average of the sales amount each staff_id has per customer.
--Question: Which staff_id makes on average more revenue per customer?
--Answer: staff_id 2 with an average revenue of 56.64 per customer.

SELECT staff_id, ROUND(AVG(total), 2)
FROM
	(SELECT staff_id, customer_id, SUM(amount) AS total
	FROM payment
	GROUP BY staff_id, customer_id)
GROUP BY staff_id
ORDER BY AVG(total) DESC

--Question 10:
--Level: Difficult to very difficult
--Topic: EXTRACT + Uncorrelated subquery
--Task: Create a query that shows average daily revenue of all Sundays.
--Question: What is the daily average revenue of all Sundays?

SELECT AVG(total)
FROM(
SELECT DATE(payment_date), EXTRACT('DOW' FROM payment_date) AS nameDay, SUM(amount) AS total
FROM payment
WHERE EXTRACT('DOW' FROM payment_date) = 0
GROUP BY DATE(payment_date), EXTRACT('DOW' FROM payment_date)
)
--Question 11:
--Level: Difficult to very difficult
--Topic: Correlated subquery
--Task: Create a list of movies - with their length and their replacement cost - that are longer than the average length 
--in each replacement cost group.
--Question: Which two movies are the shortest on that list and how long are they?
--Answer: CELEBRITY HORN and SEATTLE EXPECTATIONS with 110 minutes.

SELECT title, length
FROM film f1
WHERE length > (
    SELECT AVG(length)
    FROM film f2
    WHERE f1.replacement_cost = f2.replacement_cost
)
ORDER BY length ASC

--Question 12:
--Level: Very difficult
--Topic: Uncorrelated subquery
--Task: Create a list that shows the "average customer lifetime value" grouped by the different districts.
--Example:
--If there are two customers in "District 1" where one customer has a total (lifetime) spent of $1000 and the second 
--customer has a total spent of $2000 then the "average customer lifetime spent" in this district is $1500.
--So, first, you need to calculate the total per customer and then the average of these totals per district.
--Question: Which district has the highest average customer lifetime value?
--Answer: Saint-Denis with an average customer lifetime value of 216.54.

SELECT district, ROUND(AVG(total), 2)
FROM (
	SELECT customer.customer_id,customer.address_id, SUM(amount) AS total
	FROM customer
	INNER JOIN payment
	ON payment.customer_id = customer.customer_id
	GROUP BY customer.customer_id
) customer_total
INNER JOIN address
ON customer_total. address_id = address.address_id
GROUP BY district
ORDER BY AVG(total) DESC

--Question 13:
--Level: Very difficult
--Topic: Correlated query
--Task: Create a list that shows all payments including the payment_id, amount, and the film category (name) 
--plus the total amount that was made in this category. Order the results ascendingly by the category (name) and as 
--second order criterion by the payment_id ascendingly.
--Question: What is the total revenue of the category 'Action' and what is the lowest payment_id in that category 'Action'?
--Answer: Total revenue in the category 'Action' is 4375.85 and the lowest payment_id in that category is 16055.

SELECT payment_id, amount, name,
(
	SELECT SUM(amount)
	FROM payment
	INNER JOIN rental
	ON payment.rental_id = rental.rental_id
	INNER JOIN inventory
	ON inventory.inventory_id = rental.inventory_id
	INNER JOIN film_category
	ON inventory.film_id = film_category.film_id
	INNER JOIN category
	ON film_category.category_id = category.category_id
	WHERE name = 'Action'
	GROUP BY name 
)
FROM payment
INNER JOIN rental
ON payment.rental_id = rental.rental_id
INNER JOIN inventory
ON inventory.inventory_id = rental.inventory_id
INNER JOIN film_category
ON inventory.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
WHERE name = 'Action'
ORDER BY payment_id ASC

--Bonus question 14:
--Level: Extremely difficult
--Topic: Correlated and uncorrelated subqueries (nested)
--Task: Create a list with the top overall revenue of a film title (sum of amount per title) for each category (name).
--Question: Which is the top-performing film in the animation category?
--Answer: DOGMA FAMILY with 178.70.


--BEST

SELECT title, total_amount, name
FROM (
    SELECT 
        title, 
        SUM(amount) AS total_amount,
        name,
        ROW_NUMBER() OVER (PARTITION BY category.category_id ORDER BY SUM(amount) DESC) AS rank
    FROM 
        payment
        INNER JOIN rental ON payment.rental_id = rental.rental_id
        INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
        INNER JOIN film_category ON inventory.film_id = film_category.film_id
        INNER JOIN category ON film_category.category_id = category.category_id
        INNER JOIN film ON film.film_id = inventory.film_id
    GROUP BY 
        title, name, category.category_id
) AS top_performers
WHERE 
    rank = 1;

SELECT title, total_amount, name
FROM (
	SELECT title, SUM(amount) AS total_amount, name
	FROM payment
	INNER JOIN rental
	ON payment.rental_id = rental.rental_id
	INNER JOIN inventory
	ON inventory.inventory_id = rental.inventory_id
	INNER JOIN film_category
	ON inventory.film_id = film_category.film_id
	INNER JOIN category
	ON film_category.category_id = category.category_id
	INNER JOIN film
	ON film.film_id = inventory.film_id
	GROUP BY title, name
	ORDER BY SUM(amount) DESC
)

SELECT category.name AS category_name, COALESCE(top_performers.title, 'No top performer') AS title, COALESCE(top_performers.total_amount, 0) AS total_amount
FROM category
LEFT JOIN (
    SELECT film_category.category_id, film.title, SUM(payment.amount) AS total_amount
    FROM payment
    INNER JOIN rental ON payment.rental_id = rental.rental_id
    INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
    INNER JOIN film_category ON inventory.film_id = film_category.film_id
    INNER JOIN film ON film.film_id = inventory.film_id
    GROUP BY film_category.category_id, film.title
) AS top_performers ON category.category_id = top_performers.category_id
ORDER BY category_name, total_amount DESC
