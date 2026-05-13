show databases;

use day1;

show tables;

select * from order_items;
select * from orders;
select * from products;

-- Get product names for each order item 

SELECT 
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.price
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id; 


/* Calculate Revenue Per Order

Revenue = quantity × price */
SELECT 
    order_id,
    SUM(quantity * price) AS order_revenue
FROM order_items	
GROUP BY order_id; 

-- Revenue by City (Real Interview Question)

SELECT 
    o.city,
    SUM(oi.quantity * oi.price) AS city_revenue
FROM  order_items oi
JOIN orders o ON oi.order_id = o.order_id -- Now we must JOIN all three tables.
GROUP BY o.city;

-- Revenue by Product Category

SELECT 
    p.category,
    SUM(oi.quantity * oi.price) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category;

-- Q1. Total quantity sold per product

select 
	p.product_name,
    SUM(quantity) as total_quantity		
from  order_items oi
join products p ON oi.product_id = p.product_id
group by product_name;

-- Q2. Top selling product by revenue

select
	p.product_name,
    SUM(oi.quantity * oi.price) as total_revenue
from order_items oi
join products p ON oi.product_id = p.product_id
group by p.product_name
order by total_revenue desc
limit 1;

-- Q3. Total number of items sold in each city

select 
	o.city,
	sum(quantity) as total_no_of_orders
from order_items oi
join orders o ON o.order_id = oi.order_id
group by city;

-- Q4. Number of orders per city

select 
	o.city,
    count(distinct oi.order_id) as No_of_Orders
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
group by o.city;

select 
	o.city,
    count(distinct oi.product_id) as No_of_Orders
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
group by o.city;

-- Q5. Total revenue for Delhi only

select 
	o.city,
    sum(oi.quantity * oi.price) as revenue
from orders o
JOIN order_items oi ON o.order_id = oi.order_id
where city = 'Delhi'
group by city;
    