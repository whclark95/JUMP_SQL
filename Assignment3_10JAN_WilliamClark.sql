---------------------------------------
-- Name: William Clark
-- Assignment: Oracle Assignment 3
-- Date: 1/10/2020
-- Objective: INSERT, UPDATE, DELETE
---------------------------------------

ROLLBACK;

----------------
-- INSERT
----------------

SELECT  *
FROM    regions;

-- QUESTION 1   -- insert into regions table with column names
INSERT INTO regions (region_id, region_name)
VALUES      (5, 'USA');

SELECT  *
FROM    regions;

-- QUESTION 2   -- insert into regions table without column names
INSERT INTO regions
VALUES      (6, 'Russia');

SELECT  *
FROM    regions;

-- QUESTION 3   -- insert into select
INSERT INTO customers
    SELECT  employee_id*330, first_name||' '||last_name, NULL, NULL, NVL(salary, 0)/25  -- employee id * 330 to prevent conflicting IDs
    FROM    employees
    WHERE   job_title LIKE '%President';

SELECT      *
FROM        customers
ORDER BY    customer_id DESC;

-- QUESTION 4   -- insert into sales table by selecting data from orders table
CREATE TABLE sales
    (order_id NUMBER,
     seller_id NUMBER,
     customer_id NUMBER);

INSERT INTO sales
    SELECT  order_id, salesman_id, customer_id
    FROM    orders;

-- QUESTION 5   -- Retrieve data from sales table
SELECT   *
FROM     sales
ORDER BY order_id ASC;


----------------
-- UPDATE
----------------

-- QUESTION 1   -- update warehouse_name from Bombay to Mumbai in warehouse  table
SELECT  *
FROM    warehouses;

UPDATE  warehouses
SET     warehouse_name = 'Mumbai'
WHERE   warehouse_name = 'Bombay';

SELECT  *
FROM    warehouses;

-- QUESTION 2   -- update email_id and phone number of employee  where employee_id is 13
SELECT  *
FROM    employees
WHERE   employee_id = 13;

UPDATE  employees
SET     email = 'whclark95@gmail.com', phone = '919.561.2086'
WHERE   employee_id = 13;

SELECT  *
FROM    employees
WHERE   employee_id = 13;

-- QUESTION 3   -- UPDATE multiple rows 
SELECT  *
FROM    employees;

UPDATE  employees
SET     email = 'whclark95@gmail.com', phone = '919.561.2086';

SELECT  *
FROM    employees;

----------------
-- DELETE
----------------

-- QUESTION 1   -- delete all sales records where order id is 1
DELETE FROM sales
WHERE       order_id = 1;

SELECT      *
FROM        sales
ORDER BY    order_id ASC;

-- QUESTION 2   -- delete all rows from sales table
DELETE FROM sales;              -- TRUNKATE also works

SELECT      *
FROM        sales
ORDER BY    order_id ASC;

-- QUESTION 3   -- delete cascade 
SELECT  *
FROM    inventories
ORDER BY warehouse_id DESC;     -- Warehouse_ID is a foregn key in inventories with a delete cascade condition

DELETE FROM warehouses
WHERE       warehouse_id = 9;

SELECT  *
FROM    inventories
ORDER BY warehouse_id DESC;

CREATE TABLE parental (num NUMBER CONSTRAINT par_num_pk PRIMARY KEY);
DROP TABLE parental;

INSERT INTO parental VALUES (4);

CREATE TABLE childlike (kid_num NUMBER CONSTRAINT cld_num_fk REFERENCES parental(num) ON DELETE CASCADE, my_num NUMBER);

INSERT INTO childlike VALUES (4, 3);

SELECT * FROM parental;
SELECT * FROM childlike;

DELETE FROM parental;

DROP TABLE childlike;
DROP TABLE parental;

-------------------------------------

DROP TABLE sales;
ROLLBACK;