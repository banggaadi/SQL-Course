-- GROUPING SETS
SELECT TO_CHAR(payment_date, 'Month') AS month, staff_id, SUM(amount)
FROM payment
GROUP BY
	GROUPING SETS (
		(staff_id),
		(month),
		(staff_id, month)
	)
	
-- CHALLENGE
SELECT first_name, last_name, staff_id, sum(amount) AS total,
	ROUND(SUM(amount)/ FIRST_VALUE(SUM(amount)) OVER(PARTITION BY first_name, last_name ORDER BY SUM(amount) DESC), 2) AS percentage
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY
	GROUPING SETS(
		(first_name,last_name),
		(first_name, last_name, staff_id)
	)
ORDER BY first_name ASC

-- ROLLUP
SELECT 'Q'||TO_CHAR(payment_date, 'Q') AS quarter, EXTRACT(month from payment_date) AS month, DATE(payment_date),
SUM(amount)
FROM payment
GROUP BY
ROLLUP(
	'Q'||TO_CHAR(payment_date, 'Q'),
	EXTRACT(month from payment_date),
	DATE(payment_date)
)
ORDER BY 1,2,3

-- CUBE
SELECT customer_id, staff_id, DATE(payment_date), SUM(amount)
FROM payment
GROUP BY
CUBE(
	customer_id, 
	staff_id, 
	DATE(payment_date)
)
ORDER BY 1,2,3

-- CHALLENGE
SELECT payment.customer_id, DATE(payment_date), title, SUM(amount) AS total
FROM payment
LEFT JOIN rental
ON rental.rental_id = payment.rental_id
LEFT JOIN inventory
ON inventory.inventory_id = rental.inventory_id
LEFT JOIN film
ON film.film_id = inventory.film_id
GROUP BY
CUBE (
	payment.customer_id, DATE(payment_date), title
)
ORDER BY 1,2,3

-- SELF JOIN
CREATE TABLE employee (
	employee_id INT,
	name VARCHAR (50),
	manager_id INT
);

INSERT INTO employee 
VALUES
	(1, 'Liam Smith', NULL),
	(2, 'Oliver Brown', 1),
	(3, 'Elijah Jones', 1),
	(4, 'William Miller', 1),
	(5, 'James Davis', 2),
	(6, 'Olivia Hernandez', 2),
	(7, 'Emma Lopez', 2),
	(8, 'Sophia Andersen', 2),
	(9, 'Mia Lee', 3),
	(10, 'Ava Robinson', 3);
	
SELECT * FROM employee

SELECT 
    emp.employee_id,
    emp.name AS employee,
    mng.name AS manager
FROM 
    employee emp
LEFT JOIN 
    employee mng
ON 
    emp.manager_id = mng.employee_id
ORDER BY 
    emp.employee_id ASC
	
-- CHALLENGE
SELECT f1.title,f2.title, f1.length
FROM film f1
LEFT JOIN film f2
ON f1.length = f2.length AND f1.title <> f2.title
ORDER BY length DESC

-- CROSS JOIN
SELECT staff_id, store.store_id, first_name, store.store_id*staff_id
FROM staff
CROSS JOIN store

-- NATURAL JOIN
SELECT first_name, last_name, SUM(amount)
FROM payment
NATURAL INNER JOIN customer
GROUP BY first_name, last_name

SELECT * 
FROM customer
NATURAL INNER JOIN address
-- no matches found