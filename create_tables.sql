drop table if exists order_items cascade;
drop table if exists orders cascade;
drop table if exists products cascade;
drop table if exists suppliers cascade;
drop table if exists user_profiles cascade;
drop table if exists users cascade;

create table suppliers (
    id serial primary key,
    name varchar(255) not null,
    country varchar(100)
);

create table users (
    id serial primary key,
    email varchar(255) unique not null,
    registered_at timestamp default current_timestamp
);

create table user_profiles (
    user_id int primary key,
    full_name varchar(255) not null,
    shipping_address text not null,
    foreign key (user_id) references users(id) 
);

create table products (
    id serial primary key,
    name varchar(255) not null,
    category varchar(50) not null,
    price decimal(10, 2) not null check (price >= 0),
    stock int default 0 check (stock >= 0),
    supplier_id int,
    foreign key (supplier_id) references suppliers(id) 
);

create table orders (
    id serial primary key,
    user_id int,
    order_date timestamp default current_timestamp,
    total_amount decimal(10, 2) default 0 check (total_amount >= 0),
    foreign key (user_id) references users(id) 
);

create table order_items (
    order_id int,
    product_id int,
    quantity int not null check (quantity > 0),
    primary key (order_id, product_id),
    foreign key (order_id) references orders(id),
    foreign key (product_id) references products(id) 
);
