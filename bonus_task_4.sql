create or replace function calculate_order_total()
returns trigger as $$
begin
    update orders
    set total_amount = total_amount + (new.quantity * (
                                                        select price 
                                                        from products 
                                                        where id = new.product_id))
    where id = new.order_id;
    return new;
end;
$$ language plpgsql;

create trigger trg_update_order_total
after insert on order_items
for each row
execute function calculate_order_total();
