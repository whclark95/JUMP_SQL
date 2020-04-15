---------------------------------------
-- Name: William Clark
-- Assignment: Oracle Assignment 1
-- Date: 1/6/2020
-- Objective: DDL Commands
---------------------------------------

---------------------------------------
-- SELECT Statements
---------------------------------------

-- Question 1       -- Get Customer Names from the Table
SELECT  name
FROM    customers;

-- Question 2       -- Get Customer_ID, Name, and Credit_Limit from Customers Table
SELECT  customer_id, name, credit_limit
FROM    customers;

-- Question 3       -- Get all Columns of Customers Table
SELECT  * 
FROM    customers;

-- Question 4       -- Get all unique elements of Contacts table
SELECT DISTINCT *
FROM            contacts;

-- Question 5       -- Get Distinct Product_ID and Quantity of Order_Items
SELECT DISTINCT product_id, quantity
FROM            order_items
ORDER BY        product_id ASC;

-- Question 6       -- Combine Two Columns
SELECT  first_name||' '||last_name AS "Employee Name"
FROM    employees;

----------------------
-- Day 2!
-- Oracle Assignment 2
-- 1/7/2020
-- Objective: Filtering
----------------------

-- Question 7       -- Get Customers with Credit_Limit more than 5000
SELECT  customer_id, name, credit_limit
FROM    customers
WHERE   credit_limit > 5000;

-- Question 8       -- Get Customers with Credit_Limit less than 3000
SELECT      customer_id, name, credit_limit
FROM        customers
WHERE       credit_limit < 3000
ORDER BY    credit_limit;

-- Question 9       -- Get Customers with Credit_Limit BETWEEN 3000 AND 5000
SELECT  customer_id, name, credit_limit
FROM    customers
WHERE   credit_limit > 3000       -- I Forgot that BETWEEN operator existed
AND     credit_limit < 5000;

SELECT  customer_id, name, credit_limit
FROM    customers
WHERE   credit_limit BETWEEN 3000 AND 5000;


-- Question 10      -- Get Orders that are not Canceled
SELECT      *
FROM        orders
WHERE       status <> 'Canceled'      -- != also WORKS!
ORDER BY    order_date;

-- Question 11      -- Get Orders with No Salesmen
SELECT  *
FROM    orders
WHERE   NVL(salesman_id, 0) = 0;  -- I Forgot IS NULL existed

-- Question 12      -- Get all Orders that are either Pending or Canceled
SELECT  *
FROM    orders
WHERE   status = 'Pending'        -- Alternate method due to constraints of the data, WHERE status <> 'Shipped', Less Accurate to the question
OR      status = 'Canceled';

-- Question 13      -- Get all Customers who's name starts with auto 
SELECT  *
FROM    customers
WHERE   LOWER(name) LIKE 'auto%';

-- Question 14      -- Get all Orders that are shipped and where ordered on 29th of November, 2016
SELECT  *
FROM    orders
WHERE   status = 'Shipped'
AND     order_date = '29-NOV-2016';

-- Question 15
UPDATE contacts
SET last_name = 'Anderson'
WHERE contact_id = 11;

UPDATE contacts
SET last_name = 'Andersen'
WHERE contact_id = 22;

UPDATE contacts
SET last_name = 'Andersan'
WHERE contact_id = 33;

SELECT *
FROM contacts
WHERE REGEXP_LIKE(last_name, '^Anders');

-- Question 16
SELECT *
FROM customers
WHERE REGEXP_LIKE(LOWER(name), '^a|^o|^e')
ORDER BY name;

-- Question 17
SELECT *
FROM customers
WHERE REGEXP_LIKE(LOWER(name), 'a$|o$|e$')'
ORDER BY name;

----------------------
-- Day 1 Querys
----------------------

SELECT count(*)
FROM customers
WHERE credit_limit > 500; 

DESC employees;

SELECT first_name
FROM employees
WHERE first_name LIKE 'So%';

SELECT last_name
FROM employees
WHERE last_name LIKE '%o_';

SELECT last_name, manager_id
FROM employees
WHERE manager_id IS NULL;

SElECT customer_id, name, credit_limit
FROM customers
WHERE credit_limit >= 2500
AND customer_id LIKE '%20%';

SElECT customer_id, name, credit_limit
FROM customers
WHERE credit_limit >= 2500
OR customer_id LIKE '%20%';

SELECT *
FROM customers
WHERE customer_id = 20
OR customer_id = 10
AND credit_limit > 500;

SELECT *
FROM customers
WHERE (customer_id = 20
OR customer_id = 10)
AND credit_limit > 500;

SELECT last_name, job_title, manager_id, hire_date
FROM employees
ORDER BY hire_date;

SELECT last_name, job_title, manager_id, hire_date
FROM employees
ORDER BY hire_date DESC;

SELECT customer_id, name, credit_limit Credit
FROM customers
ORDER BY Credit;

SELECT last_name, job_title, manager_id, hire_date
FROM employees
ORDER BY 3;

SELECT last_name, manager_id, phone
FROM employees
ORDER BY manager_id, last_name DESC;

SELECT UPPER(first_name)
FROM employees;

SELECT employee_id, last_name, manager_id
FROM employees
WHERE last_name = 'Cooper';

SELECT employee_id, last_name, manager_id
FROM employees
WHERE LOWER(last_name) = 'Cooper';