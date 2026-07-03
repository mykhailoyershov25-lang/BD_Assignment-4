create or replace view summary as
select 
    o.id as order_id, 
    u.email, 
    p.name as product_name, 
    oi.quantity, 
    (oi.quantity * p.price) as position_total,
    o.order_date
from orders o
left join users u 
on o.user_id = u.id
left join order_items oi 
on o.id = oi.order_id
left join products p 
on oi.product_id = p.id;
