-- Session A
START TRANSACTION;
UPDATE dispenser SET status = 'RUSAK' WHERE id_dispenser = 1;

-- Session B
START TRANSACTION;
UPDATE dispenser SET status = 'AKTIF' WHERE id_dispenser = 1;
COMMIT;

-- Session A commit (lost update terjadi, perubahan Session A hilang)
COMMIT;
