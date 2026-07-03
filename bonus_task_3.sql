create or replace procedure restock_product(p_product_id int, p_amount int)
language plpgsql as $$
begin
    update products
    set stock = stock + p_amount
    where id = p_product_id;
end;
$$;
