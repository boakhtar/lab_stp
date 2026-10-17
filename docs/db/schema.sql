/* Схема базы данных: Система складского учёта магазина (СУМ) */
/* СУБД: SQLite. Лабораторная работа 3 */

PRAGMA foreign_keys = ON;

/* Пользователи системы */
CREATE TABLE users (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    login         TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    full_name     TEXT NOT NULL,
    role          TEXT NOT NULL CHECK (role IN ('admin', 'storekeeper', 'seller', 'manager')),
    is_active     INTEGER NOT NULL DEFAULT 1
);

/* Категории товаров */
CREATE TABLE categories (
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

/* Поставщики */
CREATE TABLE suppliers (
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    name    TEXT NOT NULL,
    contact TEXT,
    api_url TEXT
);

/* Товары (quantity: текущий остаток) */
CREATE TABLE products (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    sku         TEXT NOT NULL UNIQUE,
    name        TEXT NOT NULL,
    category_id INTEGER NOT NULL REFERENCES categories(id),
    supplier_id INTEGER REFERENCES suppliers(id),
    price       REAL NOT NULL CHECK (price >= 0),
    unit        TEXT NOT NULL DEFAULT 'шт',
    quantity    INTEGER NOT NULL DEFAULT 0 CHECK (quantity >= 0),
    min_stock   INTEGER NOT NULL DEFAULT 0 CHECK (min_stock >= 0),
    is_archived INTEGER NOT NULL DEFAULT 0,
    updated_at  TEXT NOT NULL DEFAULT (datetime('now'))
);

/* Движение товаров: поступления, продажи, списания */
CREATE TABLE stock_movements (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id    INTEGER NOT NULL REFERENCES products(id),
    movement_type TEXT NOT NULL CHECK (movement_type IN ('receipt', 'sale', 'write_off')),
    quantity      INTEGER NOT NULL CHECK (quantity > 0),
    price         REAL,
    doc_number    TEXT,
    source        TEXT NOT NULL DEFAULT 'manual' CHECK (source IN ('manual', 'cash', 'supplier')),
    user_id       INTEGER REFERENCES users(id),
    created_at    TEXT NOT NULL DEFAULT (datetime('now'))
);

/* Заявки поставщику */
CREATE TABLE supplier_orders (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id  INTEGER NOT NULL REFERENCES products(id),
    supplier_id INTEGER NOT NULL REFERENCES suppliers(id),
    quantity    INTEGER NOT NULL CHECK (quantity > 0),
    status      TEXT NOT NULL DEFAULT 'new' CHECK (status IN ('new', 'sent', 'confirmed')),
    created_at  TEXT NOT NULL DEFAULT (datetime('now'))
);

/* Индексы для поиска и отчётов */
CREATE INDEX idx_products_name ON products(name);
CREATE INDEX idx_movements_product_date ON stock_movements(product_id, created_at);
