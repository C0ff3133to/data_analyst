-- String Functions

SELECT LENGTH('skyfall');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2;

SELECT UPPER('sky');
SELECT LOWER('SKY');

SELECT first_name, UPPER(first_name)
FROM employee_demographics;

-- trim to take the white space on the front or the end and get rid of it

SELECT TRIM('        sky    ') AS trim;
SELECT LTRIM('        sky    ') AS trim;
SELECT RTRIM('        sky    ') AS trim;

-- show first 4 or last 4 chars
SELECT first_name, 
LEFT(first_name, 4),
RIGHT(first_name, 4)
FROM employee_demographics;

-- show first 4 or last 4 chars
SELECT first_name, 
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name,3,2),
birth_date,
SUBSTRING(birth_date,6,2) AS birth_month
FROM employee_demographics;


-- REPLACE

SELECT first_name, REPLACE (first_name, 'a', 'z')
FROM employee_demographics;

-- LOCATE

SELECT LOCATE('x','Alexander');

SELECT first_name, LOCATE('An',first_name)
FROM employee_demographics;

-- CONCAT to merge 2 cells into a new one
SELECT first_name, last_name,
CONCAT(first_name,' ',last_name) AS full_name
FROM employee_demographics;


