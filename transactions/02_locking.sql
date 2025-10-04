-- Session A
BEGIN;
UPDATE dispenser SET status = 'RUSAK' WHERE id_dispenser = 2;

-- Session B → akan menunggu sampai Session A selesai
BEGIN;
UPDATE dispenser SET status = 'AKTIF' WHERE id_dispenser = 2;
