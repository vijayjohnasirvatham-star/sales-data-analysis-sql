1. Total Revenue Generated

SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.id;


2. Revenue per Product

SELECT p.product_name,
       SUM(p.price * oi.quantity) AS revenue
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id, p.product_name;


3. Most Sold Product (by quantity)

SELECT p.product_name,
       SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY p.id, p.product_name
ORDER BY total_quantity DESC
LIMIT 1;


4. Orders with Total Amount

SELECT o.id AS order_id,
       SUM(p.price * oi.quantity) AS total_amount
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY o.id;


5. Total Orders per Customer

SELECT c.id, c.name,
       COUNT(o.id) AS total_orders
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name;


6. Top 5 Customers by Spending

SELECT c.id, c.name,
       SUM(p.price * oi.quantity) AS total_spending
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY c.id, c.name
ORDER BY total_spending DESC
LIMIT 5;


7. Customers Who Never Placed Orders

SELECT c.id, c.name
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
WHERE o.id IS NULL;


8. Repeat Customers (More than 1 Order)

SELECT c.id, c.name,
       COUNT(o.id) AS total_orders
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING COUNT(o.id) > 1;


9. Monthly Sales Trend

SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
       SUM(p.price * oi.quantity) AS revenue
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY month
ORDER BY month;


10. Highest Spending Customer

SELECT c.name,
       SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY c.id, c.name
ORDER BY total_spent DESC
LIMIT 1;


11. Customers Who Spent Above Average

SELECT c.name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY c.id, c.name
HAVING SUM(p.price * oi.quantity) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(p.price * oi.quantity) AS total_spent
        FROM orders o
        JOIN order_items oi ON o.id = oi.order_id
        JOIN products p ON oi.product_id = p.id
        GROUP BY o.customer_id
    ) t
);


12. Second Highest Product Price

SELECT price
FROM (
    SELECT price,
           DENSE_RANK() OVER (ORDER BY price DESC) AS rank_no
    FROM products
) t
WHERE rank_no = 2;


13. Total Quantity Sold per Product

SELECT p.product_name,
       SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id, p.product_name;


14. Average Order Value

SELECT AVG(total_amount) AS avg_order_value
FROM (
    SELECT o.id,
           SUM(p.price * oi.quantity) AS total_amount
    FROM orders o
    JOIN order_items oi ON o.id = oi.order_id
    JOIN products p ON oi.product_id = p.id
    GROUP BY o.id
) t;