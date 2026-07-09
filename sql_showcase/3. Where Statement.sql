-- WHERE CLAUSE

SELECT *
FROM employee_salary
WHERE first_name = 'Leslie'
;

#Equal or Greater than 
SELECT *
FROM employee_salary
WHERE salary >= 50000
;

#Less than or Equal to
SELECT *
FROM employee_salary
WHERE salary <= 50000
;

# Where selector
SELECT *
FROM employee_demographics
WHERE gender = 'female'
;

# Where-is-not selector
SELECT *
FROM employee_demographics
WHERE gender != 'female'
;

# After date selector
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;

-- AND OR NOT -- Logical Operators

# After date selector
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male'
;

# After date OR NOT selector
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male'
;

# Narrow down query where Pemdas overwrite the greater than clause
SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55
;

-- LIKE statement
-- % and _
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%'
;
-- Each _ result with x amount of characters to match with like 2 for Ann
-- % works as an OR opperator where anything after will match as well
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%'
;

-- No exact birth dates will even work!
SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%'
;