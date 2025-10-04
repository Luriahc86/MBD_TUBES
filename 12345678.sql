USE cleaning_db;

START TRANSACTION;

INSERT INTO laporan_penggantian (id_pegawai, id_dispenser, jumlah_tisu)
VALUES (2, 5, 90);

UPDATE dispenser
SET last_update = NOW(), status = 'AKTIF'
WHERE id_dispenser = 5;

COMMIT;

SELECT * FROM laporan_penggantian ORDER BY id_laporan DESC LIMIT 3;

START TRANSACTION;
INSERT INTO laporan_penggantian (id_pegawai, id_dispenser, jumlah_tisu)
VALUES (3, 2, 70);

INSERT INTO laporan_penggantian (id_pegawai, id_dispenser, jumlah_tisu)
VALUES (999, 1, 50);

ROLLBACK;

SELECT * FROM laporan_penggantian WHERE id_pegawai = 999;

START TRANSACTION;

UPDATE dispenser SET status = 'RUSAK' WHERE id_dispenser = 1;

COMMIT;

SELECT id_dispenser, status, last_update FROM dispenser WHERE id_dispenser = 1;

START TRANSACTION;

SELECT * FROM dispenser WHERE id_dispenser = 2 FOR UPDATE;

UPDATE dispenser
SET status = 'RUSAK'
WHERE id_dispenser = 2;

COMMIT;

SELECT id_dispenser, status, last_update FROM dispenser WHERE id_dispenser = 2;

SELECT @@TRANSACTION_ISOLATION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

SELECT COUNT(*) FROM laporan_penggantian;

SELECT COUNT(*) FROM laporan_penggantian;

COMMIT;