-- ============================================================
-- goit-rdb-hw-02 | Нормалізація до 3НФ + створення таблиць
-- ============================================================

-- 1НФ: розбиваємо "Назва_товару і кількість" на атомарні поля,
--       кожен товар — окремий рядок.
-- Ключ: (order_id, product_name) — складений.

-- 2НФ: виносимо атрибути замовлення (дата, клієнт, адреса),
--       що залежать лише від order_id, в окрему таблицю.
-- Залишаємо: order_items(order_id, product_name, quantity).

-- 3НФ: address_client залежить від client (транзитивна залежність).
--       Виносимо клієнтів в окрему таблицю.
--       Виносимо товари в окрему таблицю (усуваємо повтори назв).

-- ============================================================
-- ФІНАЛЬНА СХЕМА (3НФ)
-- ============================================================

CREATE DATABASE IF NOT EXISTS hw02_orders;
USE hw02_orders;

-- Таблиця клієнтів
CREATE TABLE clients (
    client_id   INT          NOT NULL AUTO_INCREMENT,
    client_name VARCHAR(100) NOT NULL,
    address     VARCHAR(255) NOT NULL,
    PRIMARY KEY (client_id)
);

-- Таблиця товарів
CREATE TABLE products (
    product_id   INT          NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (product_id)
);

-- Таблиця замовлень
CREATE TABLE orders (
    order_id    INT  NOT NULL,
    client_id   INT  NOT NULL,
    order_date  DATE NOT NULL,
    PRIMARY KEY (order_id),
    CONSTRAINT fk_orders_client FOREIGN KEY (client_id) REFERENCES clients (client_id)
);

-- Таблиця позицій замовлення
CREATE TABLE order_items (
    order_item_id INT NOT NULL AUTO_INCREMENT,
    order_id      INT NOT NULL,
    product_id    INT NOT NULL,
    quantity      INT NOT NULL,
    PRIMARY KEY (order_item_id),
    CONSTRAINT fk_items_order   FOREIGN KEY (order_id)   REFERENCES orders   (order_id),
    CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES products (product_id)
);
