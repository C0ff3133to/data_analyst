-- Having VS Where

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

-- Execution order: FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY
-- WHERE = "Filter the raw ingredients before cooking"
-- HAVING = "Filter the cooked dishes after cooking"

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%' -- Filters rows first
GROUP BY occupation
HAVING AVG(salary) > 75000        -- Filters groups after
;

-- Use WHERE when you want to filter individual records (before aggregation).
-- Use HAVING when you want to filter groups based on aggregate values (after GROUP BY).
-- You can (and often should) use both in the same query — WHERE first, then HAVING.
