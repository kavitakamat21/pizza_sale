CREATE DATABASE pizza_hut;
use pizza_hut;

select * from orders;
DESCRIBE orders;
select * from order_details;
select * from pizza_types;
DESCRIBE pizza_types;
select * from pizzas;
DESCRIBE pizzas;

-- BASIC:
-- 1.Retrieve the total number of orders placed.
select count(*)  as 'Total_orders' 
from orders;

-- 2.Calculate the total revenue generated from pizza sales.
-- Total revenue calculate = price * unit 
SELECT 
    ROUND(SUM((quantity * price)), 2) AS 'Total_revenue'
FROM
    order_details AS o
JOIN   
     pizzas AS p 
ON o.pizza_id = p.pizza_id;

-- 3.Identify the highest-priced pizza.
SELECT 
    name, price
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- 4.Identify the most common pizza size ordered.
-- count is used  with size to determine the number of pizzas order in which size
SELECT 
    size, COUNT(order_id) AS 'Order_count'
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY size
ORDER BY order_count DESC;

-- With Aggregate function have to use grorup by  else got error 

-- 5.List the top 5 most ordered pizza types along with their quantities.
SELECT 
    name, SUM(quantity) AS 'Quantity'
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY quantity DESC
LIMIT 5;


-- INTERMEDIATE:
-- 1.Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT DISTINCT
    category, SUM(quantity) AS 'Total_quantity'
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY category
ORDER BY total_quantity DESC;

-- 2.Determine the distribution of orders by hour of the day.
-- Orders by hour of the day
-- Step1-  extract hours from order_time
SELECT 
    HOUR(time) AS hours, COUNT(order_id) AS 'Order_count'
FROM
    orders
GROUP BY hours;

-- 3.Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- 4.Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity),0) as 'Average'
FROM
    (SELECT 
         SUM(quantity) as quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY date) AS order_quantity;
    
-- 5.Determine the top 3 most ordered pizza types based on revenue.
-- revenue = price * quantity
SELECT 
    name, SUM((price * quantity)) AS 'Revenue'
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY revenue DESC
LIMIT 3;


-- ADVANCE:
-- 1.Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    category,
    ROUND((SUM(price * quantity) / (SELECT 
                    ROUND(SUM((quantity * price)), 2) AS 'total_revenue'
                FROM
                    order_details AS o
                        JOIN
                    pizzas AS p ON o.pizza_id = p.pizza_id)) * 100,
            2) AS 'revenue'
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY category
ORDER BY revenue DESC;

-- 2.Analyze the cumulative revenue generated over time.
	-- sum of revenue [p*q]
	-- time [date ke based pe]
	-- cumulative means day by day  eg. 1st day is 200 & 2nd day is 300 = 200+300 = 500
select  date, sum(revenue) over (order by date) as 'cum_revenue'
from
(select date ,sum(Quantity * price) as 'revenue'
from order_details 
join pizzas 
on order_details.pizza_id = pizzas.pizza_id
join orders 
on orders.order_id = order_details.order_id
group by date) as sales;

-- 3.Determine the top 3 most ordered pizza types based on revenue for each pizza category 

select name, revenue from
(select category, name, revenue,
rank() over(partition by category order by revenue desc) as rn 
from
(select CATEGORY, name ,
sum((quantity* price)) as 'revenue'
from pizza_types
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by CATEGORY, name) as a ) as b
where rn <=3;



