-- Active: 1747977627544@@127.0.0.1@3306@cleaning_db
-- Session A
START TRANSACTION;
UPDATE dispenser SET status = 'RUSAK' WHERE id_dispenser = 2;

-- Session B -> akan nunggu Session A selesai
START TRANSACTION;
UPDATE dispenser SET status = 'AKTIF' WHERE id_dispenser = 2;
