Revenue Analysis

Query 1:

What is the total revenue generated from all sales?

SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p 
ON oi.product_id = p.id;

query 2:

How much revenue does each product generate?

SELECT p.product_name,
       SUM(p.price * oi.quantity) AS revenue
FROM products p
JOIN order_items oi 
ON p.id = oi.product_id
GROUP BY p.id, p.product_name;


Query 3:

What percentage of total revenue is contributed by each product?

SELECT p.product_name,
       ROUND(SUM(p.price * oi.quantity) * 100.0 /
       (SELECT SUM(p.price * oi.quantity)
        FROM order_items oi
        JOIN products p 
        ON oi.product_id = p.id), 2) AS revenue_percent
FROM products p
JOIN order_items oi 
ON p.id = oi.product_id
GROUP BY p.id, p.product_name;


Customer Analysis:

Ouery 4:

How many orders has each customer placed?

SELECT c.id AS customer_id,
       c.name AS customer_name,
       COUNT(DISTINCT o.id) AS total_orders
FROM customers c
LEFT JOIN orders o 
ON c.id = o.customer_id
GROUP BY c.id, c.name;

Query 5:

Who are the top customers based on total spending?

SELECT c.id AS customer_id,
       c.name AS customer_name,
       SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o 
ON c.id = o.customer_id
JOIN order_items oi 
ON o.id = oi.order_id
JOIN products p 
ON oi.product_id = p.id
GROUP BY c.id, c.name
ORDER BY total_spent DESC;

Query 6:

How can customers be segmented based on their spending behavior?

WITH customer_spending AS (
    SELECT c.id AS customer_id,
           c.name AS customer_name,
           SUM(p.price * oi.quantity) AS total_spent
    FROM customers c
    JOIN orders o 
    ON c.id = o.customer_id
    JOIN order_items oi 
    ON o.id = oi.order_id
    JOIN products p 
    ON oi.product_id = p.id
    GROUP BY c.id, c.name
)

SELECT *,
       CASE
           WHEN total_spent >= (SELECT AVG(total_spent) FROM customer_spending)
                THEN 'High Value'
           ELSE 'Low Value'
       END AS segment
FROM customer_spending;


Query 7:

Which customers have never placed any orders?

SELECT c.id AS customer_id,
       c.name AS customer_name
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE o.id IS NULL;

Query 8:

Which customers have placed more than one order?

SELECT 
    c.id AS customer_id,
    c.name AS customer_name,
    COUNT(o.id) AS total_orders
FROM customers c
JOIN orders o 
ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING COUNT(o.id) > 1;


Product Analysis:

Query 9:

What are the top 3 revenue-generating products?

SELECT *
FROM (
    SELECT p.product_name,
           SUM(p.price * oi.quantity) AS revenue,
           DENSE_RANK() OVER (ORDER BY SUM(p.price * oi.quantity) DESC) AS rank_no
    FROM products p
    JOIN order_items oi 
    ON p.id = oi.product_id
    GROUP BY p.product_name
) t
WHERE rank_no <= 3;


Order Analysis:

Query 10:

What is the total value of each order?

SELECT o.id AS order_id,
       SUM(p.price * oi.quantity) AS total_amount
FROM orders o
JOIN order_items oi 
ON o.id = oi.order_id
JOIN products p 
ON oi.product_id = p.id
GROUP BY o.id;

Query 11:

What is the average order value across all orders?

SELECT AVG(total_amount) AS avg_order_value
FROM (
    SELECT o.id,
           SUM(p.price * oi.quantity) AS total_amount
    FROM orders o
    JOIN order_items oi 
    ON o.id = oi.order_id
    JOIN products p 
    ON oi.product_id = p.id
    GROUP BY o.id
) t;

Query 12:

Which orders have a value higher than the average order value?

WITH order_values AS (
    SELECT o.id AS order_id,
           SUM(p.price * oi.quantity) AS total_amount
    FROM orders o
    JOIN order_items oi 
    ON o.id = oi.order_id
    JOIN products p 
    ON oi.product_id = p.id
    GROUP BY o.id
)

SELECT *
FROM order_values
WHERE total_amount > (SELECT AVG(total_amount) FROM order_values);

Time Analysis:

Query 13:

How does revenue vary month by month?

SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
       SUM(p.price * oi.quantity) AS revenue
FROM orders o
JOIN order_items oi 
ON o.id = oi.order_id
JOIN products p 
ON oi.product_id = p.id
GROUP BY month
ORDER BY month;

Query 14:

What is the month-over-month growth rate in revenue?

SELECT month,
       revenue,
       prev_month,
       CASE 
           WHEN prev_month IS NULL THEN NULL
           ELSE ROUND(((revenue - prev_month) / prev_month) * 100, 2)
       END AS growth_percent
FROM (
    SELECT month,
           revenue,
           LAG(revenue) OVER (ORDER BY month) AS prev_month
    FROM (
        SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
               SUM(p.price * oi.quantity) AS revenue
        FROM orders o
        JOIN order_items oi 
        ON o.id = oi.order_id
        JOIN products p 
        ON oi.product_id = p.id
        GROUP BY month
    ) t1
) t2;
