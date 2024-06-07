-- INNER JOIN
SELECT *
FROM seats

SELECT *
FROM flights

SELECT *
FROM boarding_passes

SELECT COUNT(*), fare_conditions
FROM seats
INNER JOIN boarding_passes
ON seats.seat_no = boarding_passes.seat_no
GROUP BY fare_conditions

-- FULL OUTER JOIN
SELECT *
FROM boarding_passes
FULL OUTER JOIN tickets
ON boarding_passes.ticket_no = tickets.ticket_no
WHERE boarding_passes.ticket_no IS NULL 


-- LEFT JOIN
SELECT * FROM aircrafts_data
LEFT JOIN flights
ON aircrafts_data.aircraft_code = flights.aircraft_code
WHERE flights.flight_no IS NULL
-- FIND WHICH SEAT IS FAVORITE
SELECT s.seat_no, COUNT(*) 
FROM seats s
LEFT JOIN boarding_passes b
ON s.seat_no = b.seat_no
GROUP BY s.seat_no
ORDER BY COUNT(*) DESC
-- CHECKING IF THERE ARE ANY SEATS THAT NEVER BEEN BOOKED
SELECT *
FROM seats s
LEFT JOIN boarding_passes b
ON s.seat_no = b.seat_no
WHERE b.boarding_no IS NULL

-- FIND WHICH SEAT LINE IS FAVORITE
SELECT RIGHT(s.seat_no, 1) AS seat_line, COUNT(*)
FROM seats s
LEFT JOIN boarding_passes b
ON s.seat_no = b.seat_no
GROUP BY seat_line
ORDER BY COUNT(*) DESC

-- AVG PRICE FOR DIFFERENT SEAT NUMBER
SELECT *
FROM boarding_passes

SELECT *
FROM ticket_flights

SELECT seat_no, ROUND(AVG(amount),2) 
FROM ticket_flights tf
LEFT JOIN boarding_passes bp
ON tf.ticket_no = bp.ticket_no
AND tf.flight_id = bp.flight_id
GROUP BY seat_no
ORDER BY 2 DESC

-- CHALLENGE
SELECT passenger_name,SUM(total_amount) FROM tickets t
INNER JOIN bookings b
ON t.book_ref=b.book_ref
GROUP BY passenger_name
ORDER BY SUM(total_amount) DESC

SELECT passenger_name, fare_conditions, COUNT(fare_conditions) as use
FROM tickets ti
LEFT JOIN ticket_flights tf
ON ti.ticket_no = tf.ticket_no
WHERE passenger_name = 'ALEKSANDR IVANOV'
GROUP BY passenger_name, fare_conditions
ORDER BY use DESC



