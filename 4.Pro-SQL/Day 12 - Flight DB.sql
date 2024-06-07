-- ROLLUP
-- CHALLENGE
SELECT * FROM bookings

SELECT 
	'Q'||TO_CHAR(book_date, 'Q') AS quarter,
	EXTRACT(month from book_date) AS month,
	TO_CHAR(book_date, 'w') AS week_of_month,
	DATE(book_date),
	SUM(total_amount)
FROM bookings
GROUP BY
ROLLUP(
	'Q'||TO_CHAR(book_date, 'Q'),
	EXTRACT(month from book_date),
	TO_CHAR(book_date, 'w'),
	DATE(book_date)
)