-- Calculation
SELECT MIN(replacement_cost), MAX(replacement_cost), CAST(AVG(replacement_cost) as numeric (36,2)), SUM(replacement_cost)
FROM film

-- Grouping
SELECT staff_id, SUM(amount) as total_amount, COUNT(amount)
FROM payment
WHERE amount != 0
GROUP BY staff_id
ORDER BY total_amount DESC

-- Grouping multiple column
SELECT DATE(payment_date) as date, staff_id, SUM(amount) as total_amount, COUNT(amount)
FROM payment
WHERE amount != 0
GROUP BY staff_id, date
ORDER BY total_amount DESC

-- Having
SELECT customer_id, DATE(payment_date) AS date, ROUND(AVG(amount), 2) as AverageAmount, COUNT(*)
FROM payment
WHERE DATE(payment_date) IN ('2020-04-28','2020-04-29','2020-04-30')
GROUP BY customer_id, date
HAVING COUNT(payment_date) > 1
ORDER BY AverageAmount DESC