create database superstore;
use superstore;
select * from order_file3 limit 10;

ALTER TABLE order_file3
MODIFY COLUMN order_date DATE;

ALTER TABLE order_file3
MODIFY COLUMN ship_date DATE;

alter table order_file3
modify profit decimal(10,2);

alter table order_file3
modify shipping_cost decimal(10,2);

alter table order_file3
modify discount decimal(10,2);

-- Q1: Total Sales kitni hui?
select * from order_file3;
select sum(sales) as total_sales from order_file3;

-- Q2: Top 5 highest selling products
select product_id, sum(sales) as total_sales from order_file3 group by product_id order by total_sales desc limit 5;

-- Q3: Kis region me sabse zyada profit hai?
select region, sum(profit) as total_profit from order_file3 group by region order by total_profit desc limit 1;

-- Q4: Monthly sales trend dikhao
select * from order_file3;
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month_name,
    SUM(sales) AS total_sales
FROM order_file3
GROUP BY month_name
ORDER BY month_name;

SHOW TABLES FROM superstore;

SELECT DATABASE();
USE superstore;
SHOW TABLES;

-- Q5: Loss wale orders (negative profit)
select * from order_file3 where profit < 0;

-- Q6: total kitne loss-making orders
select count(*) as total_orders from order_file3 where profit < 0;
-- Q7: total loss amount
select sum(profit) as total_loss from order_file3 where profit <0;

-- Q6: Top customers by revenue
SELECT
    customer_name,
    SUM(sales) AS total_revenue
FROM order_file3
GROUP BY customer_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Q7: Category-wise performance
select category,sum(sales) as total_sales,
sum(profit) as total_profit from order_file3 group by category ;

-- Q8: Discount ka profit par impact
select discount, round(avg(profit),2) as avg_profit from order_file3 group by discount order by discount;

-- Q9: Sabse zyada quantity kis product ki bikti hai?
select * from order_file3;
select product_id, sum(quantity) as total_quantity from order_file3 group by product_id order by total_quantity desc limit 1;

-- Q10: Country-wise sales ranking
select * from order_file3;

select country,sum(sales) as total_sales from order_file3 group by country order by total_sales desc;

-- WINDOW FUNCTION
select country,sum(sales) as total_sales, row_number() over(order by sum(sales) desc) as sales_rank from order_file3 group by country limit 5; 

-- Q11: Top 3 products in each category
select * from order_file3;
select * from (select category,product_id,sum(sales) as total_sales, rank() over(partition by category order by sum(sales) desc ) as rank_no from order_file3 group by category,product_id) t where rank_no <=3;

-- Q12: Running total of sales (Cumulative Sales)
select order_date, sum(sales) as daily_sales,sum(sum(sales)) over(order by order_date) as cumulative_sales from order_file3 group by order_date order by order_date;

-- Q13: Repeat vs New Customers
select * from order_file3;
select customer_name,count(order_id) as total_orders from order_file3 group by customer_name having count(order_id)>1;

-- Q14: Profit ratio (Profit / Sales)
select category, sum(profit) / sum(sales) as profit_ratio from order_file3 group by category;

-- Q15: Most profitable sub-category in each region
select * from order_file3;
select * from (select region,sub_category,sum(profit) as total_profit, rank() over(partition by region order by sum(profit) desc) as rnk from order_file3 group by region, sub_category) t where rnk = 1;

















