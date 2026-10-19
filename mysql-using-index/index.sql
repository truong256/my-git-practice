-- BAI THUC HANH: SU DUNG INDEX TRONG MYSQL
-- Import classicmodels truoc khi chay script nay.
-- Run tung phan de quan sat EXPLAIN va EXPLAIN ANALYZE.
USE classicmodels;

-- Kiem tra so dong: database classicmodels mau thuong kha nho.
SELECT COUNT(*) AS total_customers FROM customers;

-- Don dep index cua lan chay truoc, neu da ton tai thi DROP bang tay:
-- ALTER TABLE customers DROP INDEX idx_customerName;
-- ALTER TABLE customers DROP INDEX idx_full_name;

-- 1. TRUOC KHI TAO INDEX customerName
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';
SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';
-- MySQL 8.0.18+: chay de xem thoi gian thuc thi:
-- EXPLAIN ANALYZE SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- 2. TAO INDEX DON
ALTER TABLE customers ADD INDEX idx_customerName (customerName);
SHOW INDEX FROM customers;
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';
SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';
-- EXPLAIN ANALYZE SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- 3. TAO INDEX GHEP
ALTER TABLE customers ADD INDEX idx_full_name (contactFirstName, contactLastName);
SHOW INDEX FROM customers;
EXPLAIN SELECT * FROM customers
WHERE contactFirstName = 'Jean' OR contactFirstName = 'King';
EXPLAIN SELECT * FROM customers
WHERE contactFirstName = 'Jean' AND contactLastName = 'King';
-- Gia tri trong WHERE co the khong khop du lieu thuc te: khong sao,
-- EXPLAIN van giup quan sat truy cap index.

-- 4. KIEM TRA NGUYEN TAC LEFTMOST PREFIX
-- Index (contactFirstName, contactLastName) phu hop dieu kien cot dau
-- hoac ca hai cot; khong mac dinh phu hop dieu kien chi cot thu hai.
EXPLAIN SELECT * FROM customers WHERE contactFirstName = 'Jean';
EXPLAIN SELECT * FROM customers WHERE contactLastName = 'King';

-- 5. XOA INDEX THEO DE BAI
ALTER TABLE customers DROP INDEX idx_full_name;
SHOW INDEX FROM customers;
EXPLAIN SELECT * FROM customers
WHERE contactFirstName = 'Jean' OR contactFirstName = 'King';

-- 6. DON DEP INDEX DON (TUY CHON, NEU MUON KHOI PHUC)
-- ALTER TABLE customers DROP INDEX idx_customerName;
