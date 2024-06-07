-- OVER ORDER BY
-- CHALLENGE 1
SELECT flight_id, departure_airport, SUM(actual_arrival - scheduled_arrival) 
										OVER(ORDER BY flight_id)
FROM flights
WHERE actual_departure IS NOT NULL

-- CHALLENGE 2
SELECT flight_id, departure_airport, SUM(actual_arrival - scheduled_arrival) 
										OVER(PARTITION BY departure_airport 
											 ORDER BY flight_id)
FROM flights
