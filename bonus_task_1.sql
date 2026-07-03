do $$
begin
    if not exists (select 1 from pg_roles where rolname = 'keeb_admin') then
        create role keeb_admin login password 'admin123';
        create role keeb_analyst login password 'analyst123';
        create role keeb_customer login password 'cust123';
    end if;
end
$$;

grant all privileges on all tables in schema public to keeb_admin;
grant select on all tables in schema public to keeb_analyst;
grant select, insert on orders, order_items to keeb_customer;
