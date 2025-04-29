## To see total number of oders in months of the year
select 
extract(month from order_date)as order_month, 
count(*) as total_orders from orders
group by order_month;

## To see top 5 months that has highest number of orders
select
extract(month from order_date)as order_month,
count(*) as total_orders from orders
group by order_month
order by total_orders desc
limit 5;

## Total revenue generated from the orders
select
Round(sum(quantity * list_price *(1-discount)), 2)as total_revenue
from order_items;

## Total revenue per product of top 5
select
product_id,
Round(sum(quantity * list_price *(1-discount)) )as product_revenue	
from order_items
group by product_id
order by product_revenue desc
limit 5;

## how many unique orders exist 
SELECT 
  COUNT(DISTINCT order_id) AS total_orders
FROM order_items;


