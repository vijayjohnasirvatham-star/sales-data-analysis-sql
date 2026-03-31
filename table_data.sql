-- Customers
INSERT INTO customers VALUES
(1,'Alice','Chennai'),
(2,'Bob','Bangalore'),
(3,'Charlie','Hyderabad'),
(4,'David','Chennai'),
(5,'Eva','Mumbai'),
(6,'Frank','Delhi'),
(7,'Grace','Pune');

-- Products
INSERT INTO products VALUES
(1,'Laptop',50000),
(2,'Phone',20000),
(3,'Tablet',15000),
(4,'Headphones',2000),
(5,'Monitor',12000);

-- Orders
INSERT INTO orders VALUES
(1,1,'2024-01-10'),
(2,2,'2024-01-15'),
(3,1,'2024-02-10'),
(4,3,'2024-02-12'),
(5,4,'2024-03-01'),
(6,5,'2024-03-05'),
(7,1,'2024-03-10'),
(8,6,'2024-04-01');

-- Order Items
INSERT INTO order_items VALUES
(1,1,1,1),
(2,1,4,2),
(3,2,2,1),
(4,3,3,2),
(5,4,1,1),
(6,5,2,3),
(7,6,5,1),
(8,7,2,2),
(9,7,3,1),
(10,8,4,5);
