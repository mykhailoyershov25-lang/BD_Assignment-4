explain analyze 
select * 
from order_items 
where product_id = 3; -- Час запиту 38


create index idx_order_items_product_id on order_items(product_id);


explain analyze 
select * 
from order_items 
where product_id = 3; -- Час запиту 20
