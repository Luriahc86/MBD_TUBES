USE cleaning_db;

-- Simulasi dengan LOCKING (AMAN)

-- Transaksi A
START TRANSACTION;
SELECT * FROM pegawai WHERE id = 1 FOR UPDATE;
-- baris dikunci oleh A

-- Update oleh Transaksi A
UPDATE pegawai SET nama = 'Faqih Update A (AMAN)' WHERE id = 1;
COMMIT;

-- Transaksi B (baru bisa jalan setelah A commit)
START TRANSACTION;
SELECT * FROM pegawai WHERE id = 1 FOR UPDATE;
UPDATE pegawai SET nama = 'Faqih Update B (AMAN)' WHERE id = 1;
COMMIT;
