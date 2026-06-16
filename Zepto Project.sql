create database zepto_sql_project1;
use zepto_sql_project1;
drop table if exists zepto1;
create table zepto1(
sku_id serial primary key,
category varchar(40),
name varchar(150) not null,
mrp numeric(8,2),
discount_perc numeric(5,2),
availabe_quantity integer,
discounted_selling_price numeric(8,2),
weight_in_gms integer,
out_of_stock varchar(20),
quantity integer
);
select * from zepto1;
select count(*) from zepto1;
-- data exploration
-- sample data
select * from zepto1
limit 10;

select * from zepto1
where name is null 
or
category is null
or
mrp is null
or
discount_perc is null
or
discounted_selling_price is null
or
availabe_quantity is null
or
availabe_quantity is null
or
availabe_quantity is null
or
quantity is null;
select distinct category
from zepto1
order by category;

-- products in stock
select out_of_stock, count(sku_id)
from zepto1
group by out_of_stock;
-- product names presents multiple times
select name, count(sku_id) as Number_of_skus
from zepto1
group by name 
having count(sku_id) >1
order by Number_of_skus desc;

-- Data Cleaning
-- products price check for 0

select *
from zepto1
where mrp = 0
group by sku_id;
SET SQL_SAFE_UPDATES = 0;
delete from zepto1
where mrp = 0;
-- converting mrp from paise to rps
update zepto1
set mrp = mrp/100.0,
discounted_selling_price = discounted_selling_price/100.0;
select mrp, discounted_selling_price
from zepto1;

-- 1. find the top 10 best value product based on discount perc
select distinct name, mrp, discount_perc
from zepto1
order by discount_perc desc
limit 10;

-- 2.what are the product with high mrp but outof stock
select distinct name, mrp
from zepto1
where out_of_stock = 'True'
order by mrp desc;

-- 3.calculate estimate revenue for each category
select category, sum(availabe_quantity * discounted_selling_price) as revenue
from zepto1
group by category
order by revenue;

-- 4.find all prodcuts which mrp is greater than 500 and discountis less than 10%

select distinct name
from zepto1 
where mrp > 500 and
discount_perc < 10
group by name;
-- 5. idnetify the top 5 categories offering the highest avg discount perc.

select category, avg(discount_perc) as avg_discount
from zepto1
group by category
order by avg_discount desc
limit 5;
 
-- 6. find the price per gram for products above 100 g and sort by higehst values
select distinct name, round((discounted_selling_price / weight_in_gms),2) as price_per_gram
from zepto1
where weight_in_gms >=100 
order by price_per_gram;

-- 7. group the products in to categories like low medium and bulk
select distinct(name), weight_in_gms,
 case when weight_in_gms < 1000 then 'Low'
	  when weight_in_gms < 5000 then 'Medium'
else 'Bulk' end as weight_catogery
from zepto1;

-- 8 . what is the total inventory wight per category
select category, sum(weight_in_gms * availabe_quantity) as total_weight
from zepto1
group by category
order by total_weight;





