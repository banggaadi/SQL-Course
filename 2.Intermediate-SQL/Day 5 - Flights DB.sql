-- CASE WHEN
SELECT COUNT(*) AS flights,
CASE
WHEN actual_departure IS NULL THEN 'No Departure Time'
WHEN actual_departure-scheduled_departure < '00:05' THEN 'On TIME'
WHEN actual_departure-scheduled_departure < '01:00' THEN 'Late'
ELSE 'Very Late'
END AS is_late
FROM flights
GROUP BY is_late

-- Season flight
SELECT 
COUNT(*) as flights,
CASE
WHEN EXTRACT(month from scheduled_departure) IN (12,1,2) THEN 'Winter'
WHEN EXTRACT (month from scheduled_departure) <= 5 THEN 'Spring'
WHEN EXTRACT (month from scheduled_departure) <= 8 THEN 'Summer'
ELSE 'Fall' 
END as season
FROM flights
GROUP BY season

-- COALESCE CAST
SELECT COALESCE(CAST(actual_departure AS VARCHAR), 'Not Arrived')
FROM flights

-- REPLACE
SELECT passenger_id,
REPLACE(passenger_id, ' ', '')
FROM tickets

SELECT flight_no,
CAST(REPLACE(flight_no, 'PG', '') AS VARCHAR)
FROM flights