---------------------------------------
-- Name: William Clark
-- Assignment: Oracle Assignment 2
-- Date: 1/8/2020
-- Objective: Sorting, Order By, Group By, Having, Case, Joins
---------------------------------------

--------------------------------
-- Sorting
--------------------------------

-- Question 1

-- Part i           -- Order Customers Table by Names in Decending Order

SELECT      *
FROM        customers
ORDER BY    name DESC;

-- Part ii          -- Arrages [inputed] Table by First and Last Names in Descending Order
-- customers table lacks first and last name, substituting employees table

SELECT      *
FROM        employees
ORDER BY    first_name, last_name DESC;

-- Part iii          -- Arrages [inputed] Table by First and Last Names in Ascending Order
-- Ascending varient

SELECT      *
FROM        employees
ORDER BY    first_name, last_name ASC;

-- Part iv          -- Arrages [inputed] Table such that nulls appear first in the selected column

SELECT      *
FROM        employees
ORDER BY    salary NULLS FIRST;

-- Part v           -- Arrages [inputed] Table such that nulls appear last in the selected column

SELECT      *
FROM        employees
ORDER BY    salary NULLS LAST;

----------------------------------
--Order By
----------------------------------

-- Question 1

-- Part i               -- Orders a Column such that the names containing only upper case values are shown first

SELECT      name
FROM        customers
ORDER BY    UPPER(name);

--Part ii               -- Orders a column given the specified ALIAS

SELECT      customer_id, name company_name, credit_limit, credit_limit*12 "Yearly Credit"
FROM        customers
ORDER BY    company_name;

-----------------------------------
-- Aggregate 
-----------------------------------

-- Question 1           -- Shows the Number of Orders placed by each customer

SELECT      customer_id, COUNT(order_id) orders
FROM        orders
GROUP BY    customer_id;

-----------------------------------
-- Having
-----------------------------------

SELECT  *
FROM    order_items;

-- Question 1           -- Displays only the Orders who's total cost exceeds a set amount

SELECT   order_id, SUM(unit_price*quantity) order_total
FROM     order_items
GROUP BY order_id
HAVING   SUM(unit_price*quantity) > 1000000
ORDER BY order_id;

-- Question 2           -- Displays only the Orders who's total cost exceeds a set amount and which contain an ammount of items between 2 values

SELECT      order_id, COUNT(product_id) number_of_products, SUM(unit_price*quantity) order_total
FROM        order_items
GROUP BY    order_id
HAVING      SUM(unit_price*quantity) > 500000
AND         COUNT(product_id) BETWEEN 10 AND 12;


-----------------------------------
-- Case
-----------------------------------

SELECT  *
FROM    products;

SELECT  *
FROM    product_categories;

-- Question 1           -- Finds the Discount for a product based on it's type

SELECT product_id, product_name, category_id, list_price, 
        CASE category_id WHEN 1 THEN ROUND(list_price*.05, 2)   -- category_id 1 = CPU
                         WHEN 2 THEN ROUND(list_price*.1, 2)    -- category_id 2 = Video Cards
                         ELSE ROUND(list_price*.08, 2)
        END "Discount"
FROM   products;

-- Question 2           -- Classifys products into various catagories based on list prices

SELECT  product_id, product_name, category_id, list_price,
        CASE WHEN list_price < 100 THEN 'Budget'
             WHEN list_price BETWEEN 100 AND 1000 THEN 'Moderate'
             ELSE 'Expesnive'
        END budget
FROM    products;

----------------------------
-- Joins
----------------------------

-- Question 1               -- Get information from Orders and Order_Items tables with an INNER JOIN

SELECT      ord.order_id, ord.customer_id, ord.status, itm.item_id
FROM        orders ord
INNER JOIN  order_items itm
ON          ord.order_id = itm.order_id;

-- Varient

SELECT      *
FROM        orders ord
INNER JOIN  order_items itm
ON          ord.order_id = itm.order_id;

-- Question 2               -- INNER JOINs Order and Order_Items tables using a USING clause

SELECT      order_id, customer_id, status
FROM        orders
INNER JOIN  order_items
USING       (order_id);

-- Question 3               -- Joins 3 tables with INNER JOINs

SELECT      cust.name "Customer Name", ord.order_id "Order ID", ord.status "Order Status", itm.product_id "Product ID"
FROM        customers cust
INNER JOIN  orders ord
ON          cust.customer_id = ord.customer_id
INNER JOIN  order_items itm
ON          ord.order_id = itm.order_id;

-- Question 4               -- Gets Order and Employee data from both Tables with a LEFT JOIN

SELECT      *
FROM        orders ord
LEFT JOIN   employees emp
ON          ord.salesman_id = emp.employee_id;

-- Question 5               -- Gets Order and Salesman data with a LEFT JOIN

SELECT      *
FROM        orders ord
LEFT JOIN   employees emp
ON          ord.salesman_id = emp.employee_id
WHERE       ord.order_id = 58;

-- Question 6               -- Gets Order and Salesman data with a LEFT JOIN without using WHERE statement

SELECT      *
FROM        orders ord
LEFT JOIN   employees emp
ON          (ord.salesman_id = emp.employee_id)
AND         ord.order_id = 58;

-- Question 7               -- Gets all salesmen and their orders with a RIGHT OUTER JOIN

SELECT              seller.employee_id seller_id, seller.last_name seller_name, ord.order_id order_number
FROM                employees seller
RIGHT OUTER JOIN    orders ord
ON                  seller.employee_id = ord.salesman_id
ORDER BY            order_number;

-- Question 8               -- Gets the employee and order data of employee 57 using a RIGHT JOIN

SELECT      *
FROM        employees emp
RIGHT JOIN  orders ord
ON          emp.employee_id = ord.salesman_id
WHERE       emp.employee_id = 57;

-- Question 9               -- Gets the employee and order data of employee 57 using a RIGHT JOIN without using a WHERE Statement

SELECT      *
FROM        employees emp
RIGHT JOIN  orders ord
ON          (emp.employee_id = ord.salesman_id)
AND         emp.employee_id = 57;

-- Question 10              -- Display each employee who is a manager

SELECT COUNT(DISTINCT manager_id)                   --Count of Unique managaer Ids to verify query results
FROM employees;

SELECT DISTINCT emp.employee_id, emp.last_name     --Gets the name of each employees that is listed as a manager for an employee and their employee id
FROM            employees emp
JOIN            employees mgr
ON              emp.employee_id = mgr.manager_id;