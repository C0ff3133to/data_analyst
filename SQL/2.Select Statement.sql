SELECT * 
FROM parks_and_recreation.employee_demographics;


SELECT first_name, 
last_name, 
birth_date,
age,
(age + 10) * 10
FROM parks_and_recreation.employee_demographics;
# PEMDAS = the order of operations for arithmetic 
# or math within mySQL
# stands for Parentheses, exponent, multiplication, division, addition, and subtraction. 

SELECT DISTINCT first_name, gender
FROM parks_and_recreation.employee_demographics;








