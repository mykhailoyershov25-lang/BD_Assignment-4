import psycopg2
from psycopg2.extras import execute_values
import random

HOST = 'localhost'
USER = 'postgres'
PASSWORD = '1'
DATABASE = 'asigment4'
PORT = '5432'


def insert_bulk_data():
    conn = psycopg2.connect(host=HOST, port=PORT, user=USER, password=PASSWORD, dbname=DATABASE)
    cursor = conn.cursor()

    print("Генеруємо постачальників...")
    suppliers = [
        ("Dark Project", "Cyprus"),
        ("Gateron", "China"),
        ("Cherry", "Germany")
    ]
    execute_values(cursor, "insert into suppliers (name, country) values %s", suppliers)

    print("Генеруємо товары...")
    products = [
        ("ALU81 Terra Nova Base", "Base", 150.00, 100, random.randint(1, 3)),
        ("Dark Project KS-22", "Keyboard", 120.00, 50, random.randint(1, 3)),
        ("Gateron Milky Yellow Pro", "Switch", 0.30, 10000, random.randint(1, 3)),
        ("Cherry MX Brown", "Switch", 0.50, 5000, random.randint(1, 3)),
        ("GMK Botanical", "Keycaps", 110.00, 20, random.randint(1, 3))
    ]
    execute_values(cursor, "insert into products (name, category, price, stock, supplier_id) values %s", products)

    print("Генеруємо 10,000 користувачів...")
    users = [(f"user{i}@gmail.com",) for i in range(1, 10001)]
    execute_values(cursor, "insert into users (email) values %s", users)

    print("Генеруємо 100,000 замовлень...")
    orders = [(random.randint(1, 10000),) for _ in range(100000)]
    execute_values(cursor, "insert into orders (user_id) values %s", orders)

    print("Генеруємо 500,000 деталей замовлень...")
    order_items_set = set()
    while len(order_items_set) < 500000:
        order_items_set.add((random.randint(1, 100000), random.randint(1, 5), random.randint(1, 100)))

    execute_values(cursor, "insert into order_items (order_id, product_id, quantity) values %s on conflict do nothing",
                   list(order_items_set))

    conn.commit()
    cursor.close()
    conn.close()
    print("Успішно додано більше 500,000 записів!")


if __name__ == "__main__":
    insert_bulk_data()
