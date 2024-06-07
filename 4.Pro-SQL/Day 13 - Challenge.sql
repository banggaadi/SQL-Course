-- TASK 1
-- TASK 1.1
CREATE TABLE employees(
	emp_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	job_position VARCHAR(50) NOT NULL,
	salary numeric(8,2),
	start_date DATE,
	birth_date DATE,
	store_id INT,
	department_id INT,
	manager_id INT
)

SELECT * FROM employees
SELECT * FROM departments
-- TASK 1.2
CREATE TABLE departments(
	department_id SERIAL PRIMARY KEY,
	department TEXT,
	division TEXT
)

-- TASK 2
ALTER TABLE departments
ALTER COLUMN department_id SET NOT NULL

ALTER TABLE employees
ALTER COLUMN start_date SET DEFAULT CURRENT_DATE,
ADD end_date DATE,
ADD CONSTRAINT birth_check CHECK(birth_date > CURRENT_DATE)

ALTER TABLE employees
RENAME job_position TO position_title

ALTER TABLE employees
DROP CONSTRAINT birth_check,
ADD CONSTRAINT birth_check CHECK(birth_date < CURRENT_DATE)

-- TASK 3
-- TASK 3.1
INSERT INTO employees(
	emp_id,
	first_name,
	last_name,
	position_title,
	salary,
	start_date,
	birth_date,
	store_id,
	department_id,
	manager_id,
	end_date
)
VALUES
	(1,'Morrie','Conaboy','CTO',21268.94,'2005-04-30','1983-07-10',1,1,NULL,NULL),
	(2,'Miller','McQuarter','Head of BI',14614.00,'2019-07-23','1978-11-09',1,1,1,NULL),
	(3,'Christalle','McKenny','Head of Sales',12587.00,'1999-02-05','1973-01-09',2,3,1,NULL),
	(4,'Sumner','Seares','SQL Analyst',9515.00,'2006-05-31','1976-08-03',2,1,6,NULL),
	(5,'Romain','Hacard','BI Consultant',7107.00,'2012-09-24','1984-07-14',1,1,6,NULL),
	(6,'Ely','Luscombe','Team Lead Analytics',12564.00,'2002-06-12','1974-08-01',1,1,2,NULL),
	(7,'Clywd','Filyashin','Senior SQL Analyst',10510.00,'2010-04-05','1989-07-23',2,1,2,NULL),
	(8,'Christopher','Blague','SQL Analyst',9428.00,'2007-09-30','1990-12-07',2,2,6,NULL),
	(9,'Roddie','Izen','Software Engineer',4937.00,'2019-03-22','2008-08-30',1,4,6,NULL),
	(10,'Ammamaria','Izhak','Customer Support',2355.00,'2005-03-17','1974-07-27',2,5,3,'2013-04-14'),
	(11,'Carlyn','Stripp','Customer Support',3060.00,'2013-09-06','1981-09-05',1,5,3,NULL),
	(12,'Reuben','McRorie','Software Engineer',7119.00,'1995-12-31','1958-08-15',1,5,6,NULL),
	(13,'Gates','Raison','Marketing Specialist',3910.00,'2013-07-18','1986-06-24',1,3,3,NULL),
	(14,'Jordanna','Raitt','Marketing Specialist',5844.00,'2011-10-23','1993-03-16',2,3,3,NULL),
	(15,'Guendolen','Motton','BI Consultant',8330.00,'2011-01-10','1980-10-22',2,3,6,NULL),
	(16,'Doria','Turbat','Senior SQL Analyst',9278.00,'2010-08-15','1983-01-11',1,1,6,NULL),
	(17,'Cort','Bewlie','Project Manager',5463.00,'2013-05-26','1986-10-05',1,5,3,NULL),
	(18,'Margarita','Eaden','SQL Analyst',5977.00,'2014-09-24','1978-10-08',2,1,6,'2020-03-16'),
	(19,'Hetty','Kingaby','SQL Analyst',7541.00,'2009-08-17','1999-04-25',1,2,6,NULL),
	(20,'Lief','Robardley','SQL Analyst',8981.00,'2002-10-23','1971-01-25',2,3,6,'2016-07-01'),
	(21,'Zaneta','Carlozzi','Working Student',1525.00,'2006-08-29','1995-04-16',1,3,6,'2012-02-19'),
	(22,'Giana','Matz','Working Student',1036.00,'2016-03-18','1987-09-25',1,3,6,NULL),
	(23,'Hamil','Evershed','Web Developper',3088.00,'2022-02-03','2012-03-30',1,4,2,NULL),
	(24,'Lowe','Diamant','Web Developper',6418.00,'2018-12-31','2002-09-07',1,4,2,NULL),
	(25,'Jack','Franklin','SQL Analyst',6771.00,'2013-05-18','2005-10-04',1,2,2,NULL),
	(26,'Jessica','Brown','SQL Analyst',8566.00,'2003-10-23','1965-01-29',1,1,2,NULL)

SELECT * FROM employees

-- TASK 3.2
INSERT INTO departments (
	department_id, 
	department, 
	division)
VALUES 
	(1,'Analytics','IT'),
	(2,'Finance','Administration'),
	(3,'Sales','Sales'),
	(4,'Website','IT'),
	(5,'Back Office','Administration')
		
-- TASK 4
-- TASK 4.1
UPDATE employees
SET position_title = 'Senior SQL Analyst', salary = 7200
WHERE first_name = 'Jack' AND last_name = 'Franklin'

SELECT * FROM employees
WHERE position_title = 'Senior SQL Analyst'

-- TASK 4.2
UPDATE employees
SET salary = salary*1.06
WHERE position_title = 'Senior SQL Analyst'

UPDATE employees
SET salary = salary*1.06
WHERE position_title = 'SQL Analyst'

-- TASK 4.3
UPDATE employees
SET position_title = 'Customer Specialist'
WHERE position_title = 'Customer Support'

-- TASK 4.4
SELECT ROUND(AVG(salary), 2)
FROM employees
WHERE position_title <> 'Senior SQL Analyst' AND position_title = 'SQL Analyst'

-- TASK 5
-- TASK 5.1
SELECT first_name ||' '|| last_name 
FROM employees
WHERE manager_id IS NOT NULL

ALTER TABLE employees
ADD is_active BOOLEAN;

UPDATE employees
SET is_active = CASE
		WHEN end_date IS NULL THEN true
		WHEN end_date IS NOT NULL THEN false
	END
	
--TASK 5.2
CREATE VIEW v_employees_info AS
	SELECT first_name ||' '|| last_name AS manager
	FROM employees
	WHERE manager_id IS NOT NULL
	
-- TASK 6
SELECT position_title, ROUND(AVG(salary), 2)
FROM employees
GROUP BY position_title

-- TASK 7
SELECT * FROM employees;
SELECT * FROM departments;

SELECT division, ROUND(AVG(salary), 2)
FROM departments
LEFT JOIN employees
ON departments.department_id = employees.department_id
GROUP BY division

-- TASK 8
-- TASK 8.1
SELECT emp_id, first_name, last_name, employees.position_title, salary, average
FROM employees
LEFT JOIN (
	SELECT position_title, ROUND(AVG(salary), 2) AS average
	FROM employees
	GROUP BY position_title
) AS average
ON employees.position_title = average.position_title
ORDER BY emp_id

-- TASK 8.2
SELECT COUNT(*)
FROM employees
LEFT JOIN (
	SELECT position_title, ROUND(AVG(salary), 2) AS average
	FROM employees
	GROUP BY position_title
) AS average
ON employees.position_title = average.position_title
WHERE salary < average

-- TASK 9
SELECT emp_id, salary, start_date, SUM(salary) OVER(ORDER BY start_date)
FROM employees
ORDER BY start_date ASC

-- TASK 10
SELECT emp_id, start_date, SUM(salary) OVER(ORDER BY start_date)
FROM
(	SELECT emp_id, start_date, salary
	FROM employees
	UNION ALL
	SELECT emp_id, end_date, salary * -1
	FROM employees
	WHERE end_date IS NOT NULL)
ORDER BY start_date ASC

-- TASK 11
-- TASK 11.1
SELECT first_name, employees.position_title, top_earner
FROM employees
LEFT JOIN (
	SELECT position_title, MAX(salary) AS top_earner
	FROM employees
	GROUP BY position_title
) AS top
ON employees.salary = top.top_earner
WHERE top_earner IS NOT NULL

-- TASK 11.2
SELECT first_name, employees.position_title, top_earner, average
FROM employees
LEFT JOIN (
	SELECT position_title, MAX(salary) AS top_earner
	FROM employees
	GROUP BY position_title
) AS top
ON employees.salary = top.top_earner
LEFT JOIN (
	SELECT position_title, ROUND(AVG(salary), 2) AS average
	FROM employees
	GROUP BY position_title
) AS average_salary
ON employees.position_title = average_salary.position_title
WHERE top_earner IS NOT NULL

-- TASK 11.3
SELECT first_name, employees.position_title, top_earner, average
FROM employees
LEFT JOIN (
	SELECT position_title, MAX(salary) AS top_earner
	FROM employees
	GROUP BY position_title
) AS top
ON employees.salary = top.top_earner
LEFT JOIN (
	SELECT position_title, ROUND(AVG(salary), 2) AS average
	FROM employees
	GROUP BY position_title
) AS average_salary
ON employees.position_title = average_salary.position_title
WHERE top_earner IS NOT NULL AND top_earner <> average

-- TASK 12
SELECT division, department, position_title, SUM(salary), COUNT(emp_id), ROUND(AVG(salary), 2)
FROM employees
LEFT JOIN departments
ON departments.department_id = employees.department_id
GROUP BY 
ROLLUP(
	division, department, position_title
)
ORDER BY 1, 2, 3

-- TASK 13
SELECT emp_id, position_title, department, salary, RANK() OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees
LEFT JOIN departments
ON departments.department_id = employees.department_id

-- TASK 14
SELECT emp_id, employees.position_title,department, top_earner
FROM employees
LEFT JOIN (
	SELECT department, MAX(salary) AS top_earner
	FROM employees
	LEFT JOIN departments
	ON departments.department_id = employees.department_id
	GROUP BY department
) AS top
ON employees.salary = top.top_earner
WHERE top_earner IS NOT NULL