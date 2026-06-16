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





