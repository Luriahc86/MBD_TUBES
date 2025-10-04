-- Session A
BEGIN;
UPDATE dispenser SET status = 'RUSAK' WHERE id_dispenser = 1;

-- Session B (belum commit)
BEGIN;
UPDATE dispenser SET status = 'AKTIF' WHERE id_dispenser = 1;
COMMIT;

-- Session A commit → Lost update (perubahan A hilang)
COMMIT;
