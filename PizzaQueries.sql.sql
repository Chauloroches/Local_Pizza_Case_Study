CREATE DATABASE Pizza;
USE Pizza;

-- Create the 4 tables(orders,orders_detail,pizza_type and pizzas) and import the CSV files
CREATE TABLE Orders(
	orders_id INT,
    orders_Date DATE,
    orders_Time TIME
);

CREATE TABLE Pizzas(
	pizza_id VARCHAR(50),
    pizza_type_id VARCHAR(50),
    size CHAR,
    prize FLOAT
);

CREATE TABLE Pizza_type(
	pizza_type_id VARCHAR(50),
    pizza_name VARCHAR(100),
    category VARCHAR(50),
    ingredients TEXT
);

CREATE TABLE Orders_detail(
	orders_detail_id INT,
    order_id INT,
    pizza_id VARCHAR(50),
    quatity INT
);

-- 1.Total number of orders placed
SELECT DISTINCT COUNT( orders_id) 'Total Orders'
FROM orders;

-- 2.List the top 5 most ordered pizza types along with their quantities.
SELECT pt.pizza_name, COUNT(*) AS Quatity
FROM pizzas p
JOIN orders_detail od
ON p.pizza_id = od.pizza_id
JOIN pizza_type pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.pizza_name
ORDER BY Quatity DESC;

-- 3.Prices of Pizzas DESC
SELECT pt.pizza_name,p.prize
FROM pizzas p
JOIN pizza_type pt
ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.prize DESC;

-- 4.Highest price of pizza using join
SELECT pt.pizza_name,p.prize
FROM pizzas p
JOIN pizza_type pt
ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.prize DESC
LIMIT 1;

-- 4.1.Highest price of pizza using  join and subquey
SELECT pt.pizza_name,p.prize
FROM pizzas p
JOIN pizza_type pt
ON p.pizza_type_id = pt.pizza_type_id
WHERE prize = (SELECT MAX(prize) FROM pizzas);

-- 5.Identify the most common pizza size ordered
SELECT p.size, COUNT(*) AS CountOfOrders,pt.pizza_name
FROM pizzas p
JOIN orders_detail od
ON p.pizza_id = od.pizza_id
JOIN pizza_type pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY p.size,pt.pizza_name
ORDER BY CountOfOrders DESC;

-- 6.Total revenue for Pizza Sales using cast
-- We joins orders table with pizzas on pizza_id 
SELECT CAST(SUM(od.quatity * p.prize) AS DECIMAL(10,2)) AS TotalRevenue
FROM orders_detail od
JOIN pizzas p
ON od.pizza_id = p.pizza_id;

-- 6.1.Total revenue for Pizza Sales using round
SELECT ROUND(SUM(od.quatity * p.prize),2) AS TotalRevenue
FROM orders_detail od
JOIN pizzas p
ON od.pizza_id = p.pizza_id;

