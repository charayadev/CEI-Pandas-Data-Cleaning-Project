-- Create table commands


--1. customer table
CREATE TABLE customers ( 
    customer_id   INT           PRIMARY KEY, 
    first_name    VARCHAR(50)   NOT NULL, 
    last_name     VARCHAR(50)   NOT NULL, 
    email         VARCHAR(100)  UNIQUE NOT NULL, 
    city          VARCHAR(50)   NOT NULL, 
    state         VARCHAR(50)   NOT NULL, 
    join_date     DATE          NOT NULL, 
    is_premium    BOOLEAN       DEFAULT FALSE 
); 
 
-- Index for filtering by city/state 
CREATE INDEX idx_customers_city ON customers(city); 
CREATE INDEX idx_customers_state ON customers(state); 

--2. products table command
CREATE TABLE products ( 
    product_id    INT           PRIMARY KEY, 
    product_name  VARCHAR(100)  NOT NULL, 
    category      VARCHAR(50)   NOT NULL, 
    brand         VARCHAR(50)   NOT NULL, 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    stock_qty     INT           NOT NULL  DEFAULT 0  CHECK (stock_qty >= 0) 
); 
 
-- Index for filtering by category 
CREATE INDEX idx_products_category ON products(category);

--3. order table command
CREATE TABLE orders ( 
    order_id      INT           PRIMARY KEY, 
    customer_id   INT           NOT NULL, 
    order_date    DATE          NOT NULL, 
    status        VARCHAR(20)   NOT NULL  DEFAULT 'Pending' 
                  CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')), 
    total_amount  DECIMAL(12,2) NOT NULL  CHECK (total_amount >= 0), 
     
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
); 
 
-- Index for date-based filtering and sorting 
CREATE INDEX idx_orders_date ON orders(order_date); 
CREATE INDEX idx_orders_status ON orders(status); 

--4. order_items table command
CREATE TABLE order_items ( 
    item_id       INT           PRIMARY KEY, 
    order_id      INT           NOT NULL, 
    product_id    INT           NOT NULL, 
    quantity      INT           NOT NULL  CHECK (quantity > 0), 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    discount_pct  DECIMAL(5,2)  DEFAULT 0 CHECK (discount_pct BETWEEN 0 AND 100), 
     
    FOREIGN KEY (order_id)   REFERENCES orders(order_id), 
    FOREIGN KEY (product_id) REFERENCES products(product_id) 
); 



-- Insert the data in the tables of the database 
-- ========== INSERT: customers ========== 
INSERT INTO customers VALUES 
(101, 'Aarav',  'Sharma', 'aarav.s@email.com',  'Mumbai',    'Maharashtra', '2024-01-15', TRUE), 
(102, 'Priya',  'Patel',  'priya.p@email.com',  'Ahmedabad', 'Gujarat',     '2024-02-20', FALSE), 
(103, 'Rohan',  'Gupta',  'rohan.g@email.com',  'Delhi',     'Delhi',       '2024-03-10', TRUE), 
(104, 'Sneha',  'Reddy',  'sneha.r@email.com',  'Hyderabad', 'Telangana',   '2024-04-05', FALSE), 
(105, 'Vikram', 'Singh',  'vikram.s@email.com', 'Jaipur',    'Rajasthan',   '2024-05-12', TRUE), 
(106, 'Ananya', 'Iyer',   'ananya.i@email.com', 'Chennai',   'Tamil Nadu',  '2024-06-18', FALSE), 
(107, 'Karan',  'Mehta',  'karan.m@email.com',  'Pune',      'Maharashtra', '2024-07-22', TRUE), 
(108, 'Divya',  'Nair',   'divya.n@email.com',  'Kochi',     'Kerala',      '2024-08-30', FALSE); 


-- ========== INSERT: products ========== 
INSERT INTO products VALUES 
(201, 'Wireless Earbuds',     'Electronics', 'BoAt',          1499.00, 250), 
(202, 'Cotton T-Shirt',       'Clothing',    'Levis',         799.00,  500), 
(203, 'Smart Watch',          'Electronics', 'Noise',         2999.00, 150), 
(204, 'Running Shoes',        'Clothing',    'Nike',          4599.00, 120), 
(205, 'Bluetooth Speaker',    'Electronics', 'JBL',           3499.00, 200), 
(206, 'Bedsheet Set',         'Home',        'Spaces',        1299.00, 300), 
(207, 'Laptop Stand',         'Electronics', 'AmazonBasics',  899.00,  180), 
(208, 'Cushion Covers (Set)', 'Home',        'HomeCenter',    599.00,  400); 


-- ========== INSERT: orders ========== 
INSERT INTO orders VALUES 
(1001, 101, '2024-08-01', 'Delivered',  4498.00), 
(1002, 102, '2024-08-03', 'Delivered',  799.00), 
(1003, 103, '2024-08-05', 'Shipped',    7498.00), 
(1004, 101, '2024-08-10', 'Delivered',  3499.00), 
(1005, 104, '2024-08-12', 'Cancelled',  2999.00), 
(1006, 105, '2024-08-15', 'Delivered',  5898.00), 
(1007, 106, '2024-08-18', 'Pending',    1299.00), 
(1008, 103, '2024-08-20', 'Delivered',  899.00), 
(1009, 107, '2024-08-25', 'Shipped',    6098.00), 
(1010, 108, '2024-08-28', 'Delivered',  1598.00); 


-- ========== INSERT: order_items ========== 
INSERT INTO order_items VALUES 
(5001, 1001, 201, 2, 1499.00, 0), 
(5002, 1001, 207, 1, 899.00,  10), 
(5003, 1002, 202, 1, 799.00,  0), 
(5004, 1003, 203, 1, 2999.00, 0), 
(5005, 1003, 204, 1, 4599.00, 5), 
(5006, 1004, 205, 1, 3499.00, 0), 
(5007, 1005, 203, 1, 2999.00, 0), 
(5008, 1006, 201, 1, 1499.00, 10), 
(5009, 1006, 204, 1, 4599.00, 5), 
(5010, 1007, 206, 1, 1299.00, 0), 
(5011, 1008, 207, 1, 899.00,  0), 
(5012, 1009, 205, 1, 3499.00, 0), 
(5013, 1009, 208, 2, 599.00,  15), 
(5014, 1010, 206, 1, 1299.00, 0), 
(5015, 1010, 208, 1, 599.00,  0); 



-- data check once
SELECT COUNT(*) FROM customers; 

SELECT COUNT(*) FROM products;

SELECT COUNT(*) FROM orders;

SELECT COUNT(*) FROM order_items;

-- customer = 8 , products = 8 , orders = 10 , order_items = 15

/*

Section A — SQL Basics (SELECT, Constraints, Primary Keys) 


*/


-- Q1. Write a query to display all columns and rows from the customer's table.
SELECT
	*
FROM
	CUSTOMERS;


-- Q2. Retrieve only the first_name, last_name, and city of all customers. 
SELECT
	first_name,
	last_name,
	city
FROM
	CUSTOMERS;

--Q3. List all unique categories available in the products table. 
SELECT
	DISTINCT(category)
FROM
	products;

/*
Q4. Identify the Primary Key of each table.

customers    =  customer_id
products     = product_id
orders       = order_id
order_items  = item_id

-- for verifying the Primary key We can look to the the create table commands

- A Primary Key uniquely identifies each record in a table.
- It must be UNIQUE and cannot contain NULL values.
- It cannot be NULL because every record must have an identifier.
*/


-- Q5. What constraints are applied to the email column?
-- email         VARCHAR(100)  UNIQUE NOT NULL (here it is from the create command)
/*
Constraints Applied:
1. UNIQUE
2. NOT NULL


The email column cannot contain duplicate values and cannot be empty.
*/

-- Example Query

INSERT INTO customers
VALUES
(109,'Test','User','aarav.s@email.com',
'Mumbai','Maharashtra','2024-09-01',FALSE);

/*
ERROR: duplicate key value violates unique constraint
Reason:
Email already exists in the customers table.
*/


-- Q6. Insert a product with unit_price = -50.

--total_amount  DECIMAL(12,2) NOT NULL  CHECK (total_amount >= 0)
-- as per the table constraint on the column it will give the error as we had given that value must be greater than 0.

INSERT INTO products
VALUES
(
209,
'Test Product',
'Electronics',
'Test Brand',
-50,
100
);

/*
ERROR: new row violates CHECK constraint

Reason:
The products table contains:
CHECK (unit_price > 0)
which prevents negative product prices from being inserted.
*/



/*
  
  Section B — Filtering & Optimization (WHERE, Indexes) 

*/


-- Q7. Retrieve all orders with status = 'Delivered'. 

SELECT
	*
FROM
	ORDERS
WHERE
	STATUS = 'Delivered';

-- Q8. Find all products in the 'Electronics' category with a unit_price greater than ₹2000. 
SELECT
	*
FROM
	PRODUCTS
WHERE
	CATEGORY = 'Electronics'
	AND UNIT_PRICE > 2000;


-- Q9. List all customers who joined in the year 2024 and belong to the state 'Maharashtra'. 
SELECT
	*
FROM
	CUSTOMERS
WHERE
	JOIN_DATE >= '2024-01-01'
	AND STATE = 'Maharashtra';

-- Q10. Find all orders placed between '2024-08-10' and '2024-08-25' (inclusive) that are NOT cancelled. 

SELECT
	*
FROM
	ORDERS
WHERE
	ORDER_DATE BETWEEN '2024-08-10' AND '2024-08-25'
	AND STATUS <> 'Cancelled';
/*
Q11. Explain what the index idx_orders_date does. 
How would it improve the performance of a query that filters orders by order_date? 
Write a sample query that would benefit from this index. 
*/
/*

The idx_orders_date index is created on the order_date column of the orders table.

CREATE INDEX idx_orders_date ON orders(order_date); 

It helps the database find records faster when a query filters or searches data using order_date in the table. 
Instead of scanning whole rows in the table, the database can use the index to directly locate the required records, which improves  performance 
and reduces execution time of query.

*/
SELECT
	*
FROM
	ORDERS
WHERE
	ORDER_DATE = '2024-08-15';



/*
Q12. If you run: SELECT * FROM customers WHERE YEAR(join_date) = 2024; —
would the index on join_date be used? 
Explain why or why not, and rewrite the query to be index-friendly (SARGable).

*/


/*


No, the index on join_date would not be used efficiently because the YEAR() function is applied to the column. 
The database has to calculate the year for every row before filtering, which can lead to a full table value checking.

To make the query index-friendly (SARGable), we should filter using a date range instead of applying a YEAR function to the column.
*/

-- Index-Friendly Query

SELECT
	*
FROM
	CUSTOMERS
WHERE
	JOIN_DATE >= '2024-01-01'
	AND JOIN_DATE < '2025-01-01';



/*

Section C — Aggregation (GROUP BY, SUM, COUNT, AVG, MIN, MAX) 


*/




-- Q13. Count the total number of orders in the orders table. 


SELECT
	COUNT(*) as total_orders 
FROM
	ORDERS;


-- Q14. Find the total revenue (SUM of total_amount) from all 'Delivered' orders. 
SELECT
	SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE
FROM
	ORDERS
WHERE
	STATUS = 'Delivered';


--  Q15. Calculate the average unit_price of products in each category. 

SELECT
	CATEGORY,
	ROUND(AVG(UNIT_PRICE), 2) AS  AVG_UNIT_PRICE
FROM
	PRODUCTS
GROUP BY
	CATEGORY;

-- Q16. For each order status, find the count of orders and the total revenue. Sort the result by total revenue in descending order.
SELECT
	STATUS,
	COUNT(ORDER_ID) AS ORDER_COUNTS,
	SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE
FROM
	ORDERS
GROUP BY
	STATUS
ORDER BY
	TOTAL_REVENUE DESC;




-- Q17. Find the most expensive (MAX) and cheapest (MIN) product in each category. 

SELECT
	CATEGORY,
	MAX(UNIT_PRICE) AS MOST_EXPENSIVE,
	MIN(UNIT_PRICE) AS CHEAPEST
FROM
	PRODUCTS
GROUP BY
	CATEGORY
ORDER BY
	CATEGORY;


-- Q18. List all product categories where the average unit_price is greater than ₹2000. (Hint: Use HAVING clause) 
SELECT
	CATEGORY,
	ROUND(AVG(UNIT_PRICE), 2) AS AVG_PRICE
FROM
	PRODUCTS
GROUP BY
	CATEGORY
HAVING
	AVG(UNIT_PRICE) > 2000;




/*

Section D — Joins & Relationships 

*/

/*
   Q19. Write an INNER JOIN query to display each order along with the customer's first_name and last_name. 
   Show: order_id, order_date, first_name, last_name, total_amount.
*/


SELECT
	O.ORDER_ID,
	O.ORDER_DATE,
	C.FIRST_NAME,
	C.LAST_NAME,
	O.TOTAL_AMOUNT
FROM
	CUSTOMERS AS C
	JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;



/*
Q20. Using a LEFT JOIN, list ALL customers and their orders (if any). .
Customers with no orders should still appear with NULL values for order columns. 
*/
SELECT
	*
FROM
	CUSTOMERS AS C
	LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;

/*
In the sample dataset all customers have at least one order,
therefore no NULL values appear in the result.
*/




/*Q21. Write a query using JOINs across three tables (orders → order_items → products) 
to show: order_id, product_name, quantity, unit_price, and discount_pct for each order item.
*/
SELECT
	O.ORDER_ID,
	P.PRODUCT_NAME,
	OI.QUANTITY,
	OI.UNIT_PRICE,
	OI.DISCOUNT_PCT
FROM
	ORDERS AS O
	JOIN ORDER_ITEMS AS OI ON O.ORDER_ID = OI.ORDER_ID
	JOIN PRODUCTS AS P ON P.PRODUCT_ID = OI.PRODUCT_ID;



/*Q22. Explain the difference between LEFT JOIN and RIGHT JOIN with an example from this schema. When would you use a FULL OUTER JOIN?*/

/*

LEFT JOIN returns all records from the left table and only matching records from the right table.
If no matching record exists in the right table, NULL values are returned in the ouput.

Example:
customers LEFT JOIN orders in question 20.

This will show all customers, even if they have not placed any orders.


RIGHT JOIN returns all records from the right table and only matching records from the left table.
If no matching record exists in the left table, NULL values are returned in the output.

Example:
customers RIGHT JOIN orders

This will show all orders, even if a matching customer record is not found.


FULL OUTER JOIN returns all records from both tables.
If there is no match, NULL values are shown for the missing side.

It is useful when we want to see:
- all customers
- all orders
including matched and unmatched records from both tables.
simply we can say that when we need to see all the records from both the tables
*/


/*

Q23. Identify all Foreign Key relationships in the schema. 
Explain what would happen if you tried to insert an order with customer_id = 999 (which doesn't exist in customers)
*/

/*
Foreign Keys:

1. orders.customer_id
   REFERENCES customers(customer_id)
   -- query in the create table command
   FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 

2. order_items.order_id
   REFERENCES orders(order_id)
    -- query in the create table command
    FOREIGN KEY (order_id)   REFERENCES orders(order_id), 
    

3. order_items.product_id
   REFERENCES products(product_id)
    -- query in the create table command
   FOREIGN KEY (product_id) REFERENCES products(product_id) 


if we enter the customer id that is not there customer table?

Example:*/

INSERT INTO orders
VALUES
(
1011,
999,
'2024-09-01',
'Pending',
1000.00
);

/*Result:

The query will fail because customer_id = 999 does not exist in the customers table.

A Foreign Key constraint violation error will occur.

Reason:

The Foreign Key ensures that every order must belong to a valid customer already present in the customers table. 
This helps maintain data integrity and prevents invalid relationships between tables.
*/


/*
Section E — Advanced Concepts (CASE, ACID, Transactions) 
*/

/*
Q24. Write a query using CASE to classify products into price tiers: 
  • 'Budget'    → unit_price < 1000 
  • 'Mid-Range' → unit_price BETWEEN 1000 AND 3000 
  • 'Premium'   → unit_price > 3000 
Display: product_name, unit_price, price_tier. */


SELECT
	PRODUCT_NAME,
	UNIT_PRICE,
	CASE
		WHEN UNIT_PRICE < 1000 THEN 'Budget'
		WHEN UNIT_PRICE BETWEEN 1000 AND 3000  THEN 'Mid-Range'
		WHEN UNIT_PRICE > 3000 THEN 'Premium'
	END AS PRICE_TIER
FROM
	PRODUCTS
ORDER BY
	PRICE_TIER;




/*Q25. Using a CASE statement inside an aggregate function, count how many orders are 'Delivered' vs 'Not Delivered' (all other statuses). 
Display the result in a single row. */
SELECT
	SUM(
		CASE
			WHEN STATUS = 'Delivered' THEN 1
			ELSE 0
		END
	) AS DELIVERED_ORDERS,
	SUM(
		CASE
			WHEN STATUS <> 'Delivered' THEN 1
			ELSE 0
		END
	) AS NOT_DELIVERED_ORDERS
FROM
	ORDERS;

/*

Q26. Explain each letter of ACID: 
  • A – Atomicity 
  • C – Consistency 
  • I – Isolation 
  • D – Durability 
Give a real-world example (e.g., bank transfer) showing why each property is important. 

*/




/*
ACID properties are used in databases to ensure that transactions are processed reliably and accurately.

A – Atomicity
Atomicity means a transaction is treated as a single unit. Either all operations are completed successfully or none of them are performed.

Example:
In a bank transfer, if ₹1000 is deducted from one account but cannot be added to another account, the entire transaction is cancelled.

C – Consistency
Consistency ensures that the database remains valid before and after a transaction.

Example:
If a bank has a total balance of ₹10,000 before a transfer, the total balance should remain ₹10,000 after the transfer.

I – Isolation
Isolation means multiple transactions can run at the same time without affecting each other.

Example:
If two customers are transferring money simultaneously, one transaction should not interfere with the other.

D – Durability
Durability means once a transaction is committed, the changes are permanently saved in the database.

Example:
After a successful bank transfer, the updated account balances will remain saved even if the system crashes or loses power.

Therefore, ACID properties help maintain data accuracy, reliability, and integrity in a database system.
*/

/*

Q27. Write a SQL transa	ction that does the following atomically: 
  1. Insert a new order (order_	id=1011, customer_id=102, today's date, 'Pending', 1598.00) 
  2. Insert two order items for that order 
  3. Update the stock_qty of the purchased products 
  4. If any step fails, ROLLBACK the entire transaction. Otherwise, COMMIT. 
Write the complete BEGIN...COMMIT/ROLLBACK block. 

*/


/*

The transaction inserts a new order, inserts order items,
updates stock quantities, and ensures that all operations
are completed successfully. If any step fails, the entire
transaction is rolled back.
*/

BEGIN;

-- Step 1: Insert New Order

INSERT INTO orders
(order_id, customer_id, order_date, status, total_amount)
VALUES
(1011, 102, CURRENT_DATE, 'Pending', 1598.00);

-- Step 2: Insert Order Items

INSERT INTO order_items
(item_id, order_id, product_id, quantity, unit_price, discount_pct)
VALUES
(5016, 1011, 206, 1, 1299.00, 0);

INSERT INTO order_items
(item_id, order_id, product_id, quantity, unit_price, discount_pct)
VALUES
(5017, 1011, 208, 1, 299.00, 0);

-- Step 3: Update Product Stock

UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 206;

UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 208;

-- Step 4: Save Changes

COMMIT;

/*
If any statement fails before COMMIT,
the transaction should be rolled back:

ROLLBACK;
*/








































	















































































	


























	






	










	


























