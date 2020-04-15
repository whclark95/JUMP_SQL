---------------------------------------
-- Name: William Clark
-- Objective: Other Commands
-- Date: 1/7/2020
---------------------------------------

SELECT CONCAT(first_name, last_name)    -- CONCAT DEMO
FROM employees;

SELECT last_name, phone                 -- SUBSTR DEMO
FROM employees
WHERE SUBSTR(phone, 1, 3) = '515';

SELECT last_name, email, LENGTH(email) AS "EMail Length" -- LENGTH DEMO
FROM employees;

SELECT INSTR(LOWER(first_name), 'h')    -- INSTR DEMO
FROM employees;

SELECT customer_id, name, LPAD(credit_limit, 10, '*')    -- LPAD DEMO
FROM customers;

SELECT customer_id, name, RPAD(credit_limit, 10, '*')    -- RPAD DEMO
FROM customers;

SELECT REPLACE(first_name, 'w', 'uu') uwu                -- REPLACE DEMO
FROM employees
ORDER BY uwu DESC;

SELECT TRIM ('C' FROM last_name) CLess                        -- TRIM DEMO
FROM employees
ORDER BY CLess DESC;

SELECT employee_id, CONCAT(first_name, last_name) NAME, job_title, LENGTH(last_name), INSTR(last_name, 'a') "Contains 'a'?"
FROM employees
WHERE SUBSTR(job_title, 1, 5) = 'Sales';

SELECT job_title
FROM employees;

SELECT LPAD(SUBSTR(phone, -4), LENGTH(phone), '*')          -- Showing a SubString and padding the string to the appropriate length
FROM employees;

------------------------
-- Mathmatical Querys
------------------------

SELECT ROUND(45.923, 2), ROUND(45.923, 0), ROUND(45.923, -1)        -- ROUND TO THE SPECIFIED DECIMAL
FROM DUAL;

SELECT TRUNC(45.923, 2), TRUNC(45.923, 0), TRUNC(45.923, -1)        -- TRUNCATE TO THE SPECIFIED DECIMAL
FROM DUAL;

SELECT name, credit_limit, MOD(credit_limit, 500)                   -- MOD 
FROM customers;

SELECT DISTINCT hire_date
FROM employees;

SELECT last_name, hire_date
FROM employees
WHERE hire_date < '22-FEB-16';

SELECT sysdate                                                      -- Finds today's DATE
FROM DUAL;

SELECT manager_id
FROM employees;

SELECT last_name, manager_id, MONTHS_BETWEEN(sysdate, hire_date)/4 AS "Weeks Since Hired"
FROM employees
WHERE manager_id = '50';

SELECT employee_id, hire_date
FROM employees;

SELECT hire_date, NEXT_DAY(hire_date, 'tuesday'), LAST_DAY(hire_date), ADD_MONTHS(hire_date, 1), MONTHS_BETWEEN(sysdate, hire_date) -- Date Manipulatipon
FROM employees
WHERE employee_id = 4;

SELECT hire_date, MONTHS_BETWEEN(sysdate, hire_date)*4 AS "Weeks Past"
FROM employees;

SELECT last_name, hire_date, TO_CHAR(hire_date, 'fmDD Month YYYY') AS "MODDED HIRE DATE"
FROM employees;

SELECT name, TO_CHAR(credit_limit, 'fmL999,999,999')
FROM customers;

SELECT last_name, UPPER(CONCAT(SUBSTR(last_name, 1, 8), '_US'))
FROM employees
WHERE manager_id = 50;

----------------------------
--Conditional Logic
----------------------------

SELECT customer_id, name, credit_limit,
        CASE WHEN MOD(customer_id, 3) = 1 THEN 1.25 * credit_limit
             WHEN MOD(customer_id, 3) = 2 THEN 1.5 * credit_limit
             ELSE credit_limit
        END "NEW LIMIT"
FROM customers
ORDER BY customer_id;

SELECT * FROM employees;

UPDATE employees
SET salary = 45000
WHERE job_title = 'Public Relations Representative';

SELECT  employee_id, last_name, job_title, salary,
        DECODE(job_title, 'Sales Representative', 1.15*salary,
                          'Software Programmer', 1.25*salary,
                          'Shipping Clerk', 1.05*salary,
                          salary)
        NEW_SALARY
FROM employees
WHERE job_title = 'Sales Representative'
OR job_title = 'Software Programmer'
OR job_title = 'Shipping Clerk';

COMMIT;

SELECT last_name, NVL(salary, 40005), (NVL(salary, 40005)*12) AN_SAL                    -- Returns the value if defined, the other input if NULL
FROM employees;

SELECT last_name, hire_date, NVL2(salary, 'Assigned Wages', 'Default Wages') WAGES          -- Returns the first value if defined, the second if NULL
FROM employees
WHERE hire_date LIKE '%JAN%';

SELECT first_name, LENGTH(first_name) expr1, 
       last_name, LENGTH(last_name) expr2, 
       NULLIF(LENGTH(first_name), LENGTH(last_name)) result             -- Returns NULL if ==
FROM employees;

SELECT COALESCE(NULL, 1, NULL, 2, NULL, NULL, 4)
FROM DUAL;

---------------------
-- Grouping Commands
---------------------

SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM employees
WHERE job_title LIKE '%Rep%';

SELECT MIN(hire_date), MAX(hire_date)
FROM employees;

SELECT COUNT(*)
FROM employees
WHERE manager_id = 2;

SELECT COUNT(DISTINCT hire_date)
FROM employees;

-- Group functions ignore NULLS, unless NVL'd

SELECT AVG(salary)
FROM employees;

SELECT AVG(NVL(salary, 0))
FROM employees;

SELECT manager_id, AVG(salary)
FROM employees
GROUP BY manager_id
ORDER BY manager_id;

SELECT AVG(salary)
FROM employees
GROUP BY manager_id;

SELECT manager_id, job_title, SUM(salary)
FROM employees
GROUP BY manager_id, job_title
ORDER BY manager_id;

SELECT manager_id, COUNT(last_name)     -- Fails due to not having "a single group function" 
FROM employees;

SELECT manager_id, job_title, COUNT(last_name)      -- Fails due to "not a group by expression" AKA, everything not aggriated must be in the group by statement
FROM employees
GROUP BY manager_id;

SELECT manager_id, MAX(salary)
FROM employees
GROUP BY manager_id
HAVING MAX(salary) > 50000;             -- You can't use WHERE with group statments. Use HAVING instead

SELECT job_title, SUM(salary) PAYROLL
FROM employees
WHERE job_title NOT LIKE '%Rep%'        -- WHERE statement allowable due to not being ralated to the group statement
GROUP BY job_title
HAVING SUM(salary) > 80000
ORDER BY PAYROLL;

SELECT MAX(AVG(salary))
FROM employees
GROUP BY manager_id;