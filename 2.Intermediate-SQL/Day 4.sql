-- UPPER LOWER LENGTH
SELECT LOWER(first_name), LOWER(last_name), LOWER(email)
FROM CUSTOMER
WHERE LENGTH(first_name)>10 OR LENGTH(last_name)>10

-- LEFT RIGHT
SELECT email, RIGHT(LEFT(RIGHT(email, 5),2),1)
FROM customer

-- CONCATENATE
SELECT LEFT(email,1) ||'***'|| RIGHT(email,19)
FROM customer

-- POSITION
SELECT 
	last_name
    ||','||
	LEFT(email, POSITION('.' IN email) - 1)  
FROM customer

-- SUBSTRING
SELECT 
LEFT(email,1)||'***'|| SUBSTRING(email, POSITION('.' IN email),2) ||'***'|| SUBSTRING(email, POSITION('@' IN email))
FROM customer

SELECT 
'***'
|| SUBSTRING(email, POSITION('.' IN email)-1, 1) 
||  SUBSTRING(email, POSITION('.' IN email),2) 
||'***'
|| SUBSTRING(email, POSITION('@' IN email))
FROM customer

-- EXTRACT
SELECT EXTRACT(month from payment_date), SUM(amount) AS Total_amount
FROM payment
GROUP BY EXTRACT(month from payment_date)
ORDER BY Total_amount DESC

SELECT EXTRACT(DOW from payment_date), SUM(amount) AS Total_amount
FROM payment
GROUP BY EXTRACT(DOW from payment_date)
ORDER BY Total_amount DESC

SELECT customer_id, EXTRACT(WEEK from payment_date), SUM(amount) AS Total_amount
FROM payment
GROUP BY customer_id, EXTRACT(WEEK from payment_date)
ORDER BY Total_amount DESC

-- TO CHAR
SELECT SUM(amount) AS Total_amount, TO_CHAR(payment_date, 'Dy, DD/MM/YYYY')
FROM payment
GROUP BY payment_date
ORDER BY payment_date DESC

SELECT SUM(amount) AS Total_amount, TO_CHAR(payment_date, 'mon, YYYY')
FROM payment
GROUP BY payment_date
ORDER BY Total_amount DESC

SELECT SUM(amount) AS Total_amount, TO_CHAR(payment_date, 'Dy, HH24:MI')
FROM payment
GROUP BY payment_date
ORDER BY Total_amount DESC

-- Intervals & Timestamp
-- I overthink this
SELECT customer_id, EXTRACT(day from return_date-rental_date) ||' Days '|| TO_CHAR(return_date-rental_date, 'HH24:MI')
FROM rental
WHERE customer_id = 35

SELECT customer_id, TRUNC(AVG(EXTRACT(day from return_date-rental_date)), 0) ||' Days '|| TO_CHAR(return_date-rental_date, 'HH24:MI:SS') AS Times
FROM rental
WHERE EXTRACT(day from return_date-rental_date) ||' Days '|| TO_CHAR(return_date-rental_date, 'HH24:MI:SS') IS NOT NULL
GROUP BY customer_id, return_date, rental_date
ORDER BY AVG(EXTRACT(day from return_date-rental_date)) DESC

-- SOLUTION
SELECT customer_id, AVG(return_date-rental_date) AS rental_duration
FROM rental
GROUP BY customer_id
ORDER BY rental_duration DESC
