USE cleaning_db;

-- ==========================================================
-- 1. TRANSACTION
-- ==========================================================
START TRANSACTION;

INSERT INTO laporan_penggantian (id_pegawai, id_dispenser, jumlah_tisu)
VALUES (2, 5, 90);

UPDATE dispenser
SET last_update = NOW(), status = 'AKTIF'
WHERE id_dispenser = 5;

COMMIT;

SELECT * FROM laporan_penggantian ORDER BY id_laporan DESC LIMIT 3;

-- ==========================================================
-- 2. FAILURE AND RECOVERY
-- ==========================================================
START TRANSACTION;

INSERT INTO laporan_penggantian (id_pegawai, id_dispenser, jumlah_tisu)
VALUES (3, 2, 70);

INSERT INTO laporan_penggantian (id_pegawai, id_dispenser, jumlah_tisu)
VALUES (999, 1, 50);

ROLLBACK;

SELECT * FROM laporan_penggantian WHERE id_pegawai = 999;

-- ==========================================================
-- 3. CONCURRENCY PROBLEM (LOST UPDATE)
-- ==========================================================
-- Session A
START TRANSACTION;
UPDATE dispenser SET status = 'RUSAK' WHERE id_dispenser = 1;
-- (Belum commit)

-- Session B (jalankan di tab lain)
-- START TRANSACTION;
-- UPDATE dispenser SET status = 'AKTIF' WHERE id_dispenser = 1;
-- COMMIT;

-- Kembali ke Session A
COMMIT;

SELECT id_dispenser, status, last_update 
FROM dispenser 
WHERE id_dispenser = 1;

-- ==========================================================
-- 4. CONCURRENCY CONTROL (LOCKING)
-- ==========================================================
START TRANSACTION;

SELECT * FROM dispenser WHERE id_dispenser = 2 FOR UPDATE;

UPDATE dispenser
SET status = 'RUSAK'
WHERE id_dispenser = 2;

COMMIT;

SELECT id_dispenser, status, last_update 
FROM dispenser 
WHERE id_dispenser = 2;

-- ==========================================================
-- 5. ISOLATION LEVEL
-- ==========================================================
SELECT @@TRANSACTION_ISOLATION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

SELECT COUNT(*) AS count_before FROM laporan_penggantian;

-- Simulasikan transaksi lain di tab berbeda, lalu jalankan lagi:
SELECT COUNT(*) AS count_after FROM laporan_penggantian;

COMMIT;
