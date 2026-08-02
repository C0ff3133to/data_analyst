-- window functions

-- with GROUP BY
SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
;

-- with window function

SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER(partition by gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.first_name, dem.last_name, gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY dem.first_name, dem.last_name, gender;

-- SUM
SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(partition by gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

-- row_number
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() OVER(partition by gender order by salary DESC) AS row_num,
RANK() OVER(partition by gender order by salary DESC) AS rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
-- dense rank
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() OVER(partition by gender order by salary DESC) AS row_num,
RANK() OVER(partition by gender order by salary DESC) AS rank_num,
DENSE_RANK() OVER(partition by gender order by salary DESC) AS dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    