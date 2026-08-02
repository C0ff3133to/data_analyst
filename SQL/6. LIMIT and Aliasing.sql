-- LIMIT & Aliasing

# 3 oldest in descending order
SELECT * 
FROM employee_demographics
ORDER BY age DESC
LIMIT 3
;

# start at position 2 and then one row after it resulting we'll see the 3rd position
SELECT * 
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1
;

-- Aliasing aka change name of columns
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;