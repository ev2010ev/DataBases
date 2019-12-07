
use shop;
-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
select*from users;
select*from orders;
select*from orders_products;

select u.name, o.id
from users as u
join
orders as o
on u.id = o.user_id
order by u.name;
-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
select*from products;
select*from catalogs;
-- v1
select products.id, products.name,
(select catalogs.name from catalogs where catalogs.id = products.catalog_id) as catalog 
from products
WHERE products.id = 2
;
-- v2
select products.id, products.name, catalogs.name as catalog
from products
join
catalogs 
on catalogs.id = products.catalog_id
WHERE products.id = 2;
