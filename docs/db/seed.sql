/* Тестовые данные для эмуляции работы системы */

INSERT INTO users (login, password_hash, full_name, role) VALUES
    ('admin',  'demo_hash_admin',  'Администратор',  'admin'),
    ('store',  'demo_hash_store',  'Кладовщик',      'storekeeper'),
    ('seller', 'demo_hash_seller', 'Продавец',       'seller'),
    ('boss',   'demo_hash_boss',   'Руководитель',   'manager');

INSERT INTO categories (name) VALUES
    ('Электроинструмент'),
    ('Спецодежда и защита'),
    ('Лакокрасочные материалы');

INSERT INTO suppliers (name, contact, api_url) VALUES
    ('ТехноСнаб',     'info@technosnab.example', 'http://localhost:4001/supplier'),
    ('СтройПоставка', 'sales@stroypost.example', 'http://localhost:4001/supplier');

INSERT INTO products (sku, name, category_id, supplier_id, price, unit, quantity, min_stock) VALUES
    ('A-1001', 'Дрель ударная',      1, 1, 4500.00, 'шт', 37,  10),
    ('A-1002', 'Шуруповёрт',         1, 1, 3200.00, 'шт', 35,  8),
    ('B-2001', 'Перчатки рабочие',   2, 2, 150.00,  'пар', 177, 50),
    ('B-2002', 'Каска строительная', 2, 2, 600.00,  'шт', 4,   5),
    ('C-3001', 'Краска белая 10 л',  3, 2, 2800.00, 'шт', 23,  5);

INSERT INTO stock_movements (product_id, movement_type, quantity, price, doc_number, source, user_id, created_at) VALUES
    (1, 'receipt',   50, 4000.00, 'PN-0001', 'manual', 2, '2026-10-05 09:00:00'),
    (2, 'receipt',   40, 2800.00, 'PN-0001', 'manual', 2, '2026-10-05 09:00:00'),
    (3, 'receipt',  200, 100.00,  'PN-0002', 'manual', 2, '2026-10-05 09:10:00'),
    (4, 'receipt',   30, 450.00,  'PN-0002', 'manual', 2, '2026-10-05 09:10:00'),
    (5, 'receipt',   25, 2300.00, 'PN-0002', 'manual', 2, '2026-10-05 09:10:00'),
    (1, 'sale',      13, 4500.00, 'CH-000101', 'cash', NULL, '2026-10-12 12:20:00'),
    (2, 'sale',       5, 3200.00, 'CH-000102', 'cash', NULL, '2026-10-12 13:05:00'),
    (3, 'sale',      20, 150.00,  'CH-000103', 'cash', NULL, '2026-10-13 10:40:00'),
    (4, 'sale',      26, 600.00,  'CH-000104', 'cash', NULL, '2026-10-14 15:15:00'),
    (5, 'sale',       2, 2800.00, 'CH-000105', 'cash', NULL, '2026-10-14 16:30:00'),
    (3, 'write_off',  3, NULL,    'AS-0001', 'manual', 2, '2026-10-15 11:00:00');

INSERT INTO supplier_orders (product_id, supplier_id, quantity, status, created_at) VALUES
    (4, 2, 30, 'new', '2026-10-14 15:20:00');
