-- UPDATE
SELECT *
FROM customer

SELECT *
FROM film
ORDER BY rental_rate ASC

ALTER TABLE customer
ADD COLUMN initials varchar(10)

UPDATE customer
SET initials = CONCAT(LEFT(first_name, 1), '.', LEFT(last_name, 1), '.')

UPDATE film
SET rental_rate = 1.99
WHERE rental_rate = 0.99

-- DELETE
SELECT *
FROM payment
WHERE payment_id IN (17064,17067)

DELETE FROM payment
WHERE payment_id IN (17064,17067)
RETURNING *

-- CREATE TABLE AS
CREATE TABLE customer_spending AS
	SELECT CONCAT(first_name,' ', last_name) AS Name, SUM(amount) AS total_amount FROM customer
	LEFT JOIN payment
	ON customer.customer_id = payment.customer_id
	GROUP BY CONCAT(first_name,' ', last_name)
	
SELECT * FROM customer_spending

-- VIEW
CREATE VIEW films_category AS
	SELECT title, length, name
	FROM film
	LEFT JOIN film_category
	ON film.film_id = film_category.film_id
	LEFT JOIN category
	ON film_category.category_id = category.category_id
	WHERE name IN ('Action', 'Comedy')
	ORDER BY length DESC
	
SELECT * FROM films_category

-- MANAGING VIEW
CREATE VIEW v_customer_info
AS
SELECT cu.customer_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country
     FROM customer cu
     JOIN address a ON cu.address_id = a.address_id
     JOIN city ON a.city_id = city.city_id
     JOIN country ON city.country_id = country.country_id
ORDER BY customer_id
--
ALTER VIEW v_customer_info RENAME TO v_customer_information
--
ALTER TABLE v_customer_information
RENAME COLUMN customer_id TO c_id
--
CREATE OR REPLACE VIEW v_customer_information AS
SELECT 
    cu.customer_id AS c_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country,
    LEFT(cu.first_name, 1) || '.' || LEFT(cu.last_name, 1) || '.' AS initials
FROM 
    customer cu
    JOIN address a ON cu.address_id = a.address_id
    JOIN city ON a.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id
ORDER BY 
    cu.customer_id;

SELECT *
FROM v_customer_information

-- IMPORT EXPORT
CREATE TABLE sales (
	transaction_id SERIAL PRIMARY KEY,
	customer_id INT,
	payment_type VARCHAR(20),
	creditcard_no VARCHAR(20),
	cost DECIMAL(5,2),
	quantity INT,
	price DECIMAL(5,2)
)

SELECT * FROM sales