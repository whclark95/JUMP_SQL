---------------------------------------
-- Name: William Clark
-- Objective: MultiTable SELECTs
-- Date: 1/8/2020
---------------------------------------

-----------------------
-- LEFT JOIN
--
--SELECT [list]
--FROM [tableA] A
--LEFT JOIN
--  [tableB] B
--ON A.Value = B.Value;
--
-- RIGHT JOIN
--
--SELECT [list]
--FROM [tableA] A
--RIGHT JOIN
--  [tableB] B
--ON A.Value = B.Value;
--
-- LEFT JOIN (COND)
--
--SELECT [list]
--FROM [tableA] A
--LEFT JOIN
--  [tableB] B
--ON A.Value = B.Value
--WHERE B.Value IS NULL;
--
-- RIGHT JOIN (COND)
--
--SELECT [list]
--FROM [tableA] A
--RIGHT JOIN
--  [tableB] B
--ON A.Value = B.Value
--WHERE B.Value IS NULL;
--
-- FULL OUTER JOIN
--
--SELECT [list]
--FROM [tableA] A
--FULL OUTER JOIN
--  [tableB] B
--ON A.Value = B.Value;
--
-- FULL OUTER JOIN (COND)
--
--SELECT [list]
--FROM [tableA] A
--FULL OUTER JOIN
--  [tableB] B
--ON A.Value = B.Value
--WHERE A.Value IS NULL
--0R B.Value IS NULL;
--
-- INNER JOIN
--
-------------------------

SELECT DISTINCT customer_id, name, credit_limit, contact_id, last_name, email
FROM customers
NATURAL JOIN contacts;

SELECT * FROM locations;

INSERT INTO DEPARTMENTS(DEPARTMENT_ID, NAME, DEPARTMENT_LOCATION, LOCATION_ID) VALUES(1,'SALES', 'Roma', 1);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, NAME, DEPARTMENT_LOCATION, LOCATION_ID) VALUES(2,'FINANCE', 'Venice', 2);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, NAME, DEPARTMENT_LOCATION, LOCATION_ID) VALUES(3,'SALES', 'Tokyo', 3);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, NAME, DEPARTMENT_LOCATION, LOCATION_ID) VALUES(4,'SALES', 'Hiroshima', 4);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, NAME, DEPARTMENT_LOCATION, LOCATION_ID) VALUES(5,'ADMIN', 'Southlake', 5);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, NAME, DEPARTMENT_LOCATION, LOCATION_ID) VALUES(6,'SALES', 'South San Francisco', 6);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, NAME, DEPARTMENT_LOCATION, LOCATION_ID) VALUES(7,'PR', 'South Brunswick', 7);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, NAME, DEPARTMENT_LOCATION, LOCATION_ID) VALUES(8,'IT', 'Seatle', 8);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, NAME, DEPARTMENT_LOCATION, LOCATION_ID) VALUES(9,'IT', 'Bombay', 12);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, NAME, DEPARTMENT_LOCATION, LOCATION_ID) VALUES(10,'SALES', 'London', 15);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, NAME, DEPARTMENT_LOCATION, LOCATION_ID) VALUES(11,'SALES', 'Oxford', 16);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, NAME, DEPARTMENT_LOCATION, LOCATION_ID) VALUES(12,'SALES', 'Munich', 18);

SELECT *
FROM departments;

UPDATE departments
SET department_location = 'Roma'
WHERE department_id = 1;

COMMIT;

SELECT *
FROM employees;

UPDATE employees
SET department_id = 5
WHERE job_title = 'Manager';

SELECT employee_id, last_name, location_id, department_id
FROM employees
JOIN departments
USING (department_id);

--SELECT l.city, d.department_id
--FROM locations l
--JOIN departments d
--USING (location_id)
--WHERE d.location_id = 1400;       --Breaks  --Don't specify that which is being used to join

SELECT e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
FROM employees e
JOIN departments d
ON (e.department_id = d.department_id);     -- ON able to join non-same data type

SELECT d.department_id, d.name, d.location_id, l.location_id, l.country_id
FROM departments d
JOIN locations l
ON (l.location_id = d.location_id);

SELECT e.employee_id, l.city, d.name        -- Joining 3 tables with ON statements
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
ORDER BY e.employee_id;

SELECT e.employee_id, e.last_name, e.department_id, d.location_id   --Limiting Results with Join Statements
FROM employees e
JOIN departments d
ON (e.department_id = d.department_id)
AND e.manager_id = 2;

SELECT e.employee_id, e.last_name, e.department_id, d.location_id
FROM employees e
JOIN departments d
ON (e.department_id = d.department_id)
WHERE e.manager_id = 2;

-----------------------------------
-- NATURAL JOINs join columns that are the same
--
-- ON
-----------------------------------

SELECT worker.last_name emp, manager.last_name mpr
FROM employees worker
JOIN employees manager
ON (worker.manager_id = manager.employee_id);

-- Inner and Outer Joins

SELECT COUNT(*) FROM (
SELECT emp.last_name, emp.department_id, dept.name
FROM employees emp
LEFT OUTER JOIN departments dept
ON (emp.department_id = dept.department_id));

SELECT COUNT(*) FROM (
SELECT emp.last_name, emp.department_id, dept.name
FROM employees emp
RIGHT OUTER JOIN departments dept
ON (emp.department_id = dept.department_id));

SELECT COUNT(*) FROM (
SELECT emp.last_name, emp.department_id, dept.name
FROM employees emp
FULL OUTER JOIN departments dept                    -- Same as the Right, as there where no unique results in the Left
ON (emp.department_id = dept.department_id));

-- Cross Join

SELECT last_name, name
FROM employees
CROSS JOIN departments;

SELECT *
FROM employees, departments;

-- SubQuery (Querys within Query)

SELECT *
FROM employees;

SELECT last_name, salary
FROM employees
WHERE salary > 
               (SELECT salary
                FROM employees
                WHERE last_name = 'Peterson');
                
SELECT (first_name||' '||last_name) name, customer_id       -- Using a Subquery to limit another Query
FROM contacts
WHERE customer_id IN
                     (SELECT customer_id
                      FROM customers
                      WHERE credit_limit > 2500);
 
 SELECT last_name, job_title, salary                -- Using Multaple Subquerys with a single row return value
 FROM   employees
 WHERE  job_title = 
                    (SELECT job_title
                     FROM   employees
                     WHERE  last_name = 'Cox')
 AND    salary >    
                    (SELECT salary
                     FROM   employees
                     WHERE  last_name = 'Gardner');
                     
SELECT last_name, job_title, salary
FROM   employees
WHERE  salary = 
                (SELECT MIN(salary)
                 FROM employees);
                 
SELECT   department_id, MIN(salary)
FROM     employees
GROUP BY department_id
HAVING   MIN(salary) > 
                       (SELECT MIN(salary)
                        FROM   employees
                        WHERE  department_id = 4);
                        
SELECT (first_name||' '||last_name) name, customer_id       --Subquery Subquery
FROM   contacts
WHERE  customer_id IN
                      (SELECT customer_id
                       FROM customers
                       WHERE credit_limit IN
                                             (SELECT MAX(credit_limit)
                                              FROM customers));
                                              
SELECT last_name, job_title
FROM   employees
WHERE  job_title = 
                   (SELECT job_title
                    FROM   employees
                    WHERE  last_name = 'Clark');
                    
---------------------------------------
-- Multi-Row Subquery return Operators
--
-- IN - Returned Values Contains
--
-- ANY - 
--
-- ALL - 
----------------------------------------

SELECT  employee_id, last_name, job_title, salary
FROM    employees
WHERE   salary < ANY 
                   (SELECT  salary
                    FROM    employees
                    WHERE   job_title = 'Software Programmer')
AND     job_title <> 'Software Programmer';

SELECT  employee_id, last_name, job_title, salary
FROM    employees
WHERE   salary < ALL 
                   (SELECT  salary
                    FROM    employees
                    WHERE   job_title = 'Software Programmer')
AND     job_title <> 'Software Programmer';

SELECT  emp.last_name
FROM    employees emp
WHERE   emp.employee_id NOT IN
                               (SELECT mgr.manager_id
                                FROM employees mgr);
                
----------------------------------------
-- Set Operators
--
-- Must be used on fields with the same data type
--
-- UNION - Both sets without duplicates
--
-- UNION ALL - Both sets with duplicates
--
-- INTERSECT - Only that which is duplicated
--
-- MINUS - Only those not included in the second set
-----------------------------------------

SELECT COUNT(*) FROM (
SELECT  customer_id
FROM    customers
UNION   
SELECT  employee_id
FROM    employees);

SELECT COUNT(*) FROM (
SELECT  customer_id
FROM    customers
UNION ALL
SELECT  employee_id
FROM    employees);

SELECT COUNT(*) FROM (
SELECT  customer_id
FROM    customers
INTERSECT
SELECT  employee_id
FROM    employees);

SELECT COUNT(*) FROM (
SELECT  customer_id
FROM    customers
MINUS
SELECT  employee_id
FROM    employees);

SELECT  location_id, name "Department", TO_CHAR(NULL) "Warehouse Location"      -- UNIONs must have same column count
FROM    departments
UNION
SELECT  location_id, TO_CHAR(NULL) "Department", state "Warehouse Location"
FROM    locations;

SELECT  customer_id, name, 'xxx-xxx-xxxx' phone
FROM    customers
UNION
SELECT  customer_id, last_name, phone
FROM    contacts;

