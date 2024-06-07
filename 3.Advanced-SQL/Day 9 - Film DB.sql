-- Search any behind the scenes word inside film
SELECT COUNT(*) FROM film WHERE 'Behind the Scenes'=ANY(special_features)

-- CREATE NEW TABLE 
CREATE TABLE director(
	director_id SERIAL PRIMARY KEY,
	director_account_name varchar(50) UNIQUE,
	first_name varchar(50),
	last_name varchar(50) DEFAULT 'Not Specified',
	date_of_birth DATE,
	address_id INT REFERENCES address(address_id)
)

CREATE TABLE online_sales(
	transaction_id SERIAL PRIMARY KEY,
	customer_id INT REFERENCES customer(customer_id),
	film_id INT REFERENCES film(film_id),
	amount NUMERIC(5,2) NOT NULL,
	promotion_code varchar(10) DEFAULT 'None'
)

-- INSERT INTO
INSERT INTO online_sales(customer_id, film_id, amount)
VALUES(269,13,10.99), (27,12,29.99)

INSERT INTO online_sales(customer_id, film_id, amount, promotion_code)
VALUES (124,65,14.99, 'PROMO2022'), (225,231,12.99, 'JULYPROMO'), (119, 53, 15.99, 'SUMMERDEAL')

SELECT *
FROM online_sales

--ALTER TABLE
SELECT * FROM director

ALTER TABLE director
ALTER COLUMN director_account_name TYPE varchar(30),
ALTER COLUMN last_name DROP DEFAULT,
ALTER COLUMN last_name SET NOT NULL,
ADD email varchar(50)

ALTER TABLE director RENAME director_account_name TO account_name

ALTER TABLE director RENAME TO directors

-- DROP and TRUNCATE
-- Create table
CREATE TABLE emp_table 
(
	emp_id SERIAL PRIMARY KEY,
	emp_name TEXT
)

-- SELECT table
SELECT * FROM emp_table

-- Drop table
DROP TABLE emp_table

-- Insert rows
INSERT INTO emp_table
VALUES
(1,'Frank'),
(2,'Maria')

-- SELECT table
SELECT * FROM emp_table

-- Truncate table
TRUNCATE TABLE emp_table

-- CHECK
CREATE TABLE songs(
	song_id SERIAL PRIMARY KEY,
	song_name varchar(30) NOT NULL,
	genre varchar(30)DEFAULT 'Not Defined',
	price NUMERIC(4,2) DEFAULT 1.99,
	release_date DATE,
	CONSTRAINT date_check CHECK(release_date <= CURRENT_DATE),
	CONSTRAINT price_check CHECK(price >= 1.99)
)

INSERT INTO songs(song_name, price, release_date)
VALUES ('SQL Song', 0.99, '2022-01-07')

ALTER TABLE songs
DROP CONSTRAINT price_check,
ADD CONSTRAINT price_check CHECK(price >= 0.99)

SELECT * FROM songs