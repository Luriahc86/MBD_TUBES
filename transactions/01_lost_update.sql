USE cleaning_db;

-- Simulasi Lost Update (TANPA LOCK)

-- Transaksi A
START TRANSACTION;
SELECT * FROM pegawai WHERE id = 1;
-- hasil: misalnya "Faqih Chairul Anam"

-- Update oleh Transaksi A
UPDATE pegawai SET nama = 'Faqih Update A' WHERE id = 1;
-- (belum commit)

-- Transaksi B
START TRANSACTION;
SELECT * FROM pegawai WHERE id = 1;
-- hasil masih "Faqih Chairul Anam"

-- Update oleh Transaksi B (menimpa A)
UPDATE pegawai SET nama = 'Faqih Update B' WHERE id = 1;
COMMIT; -- Transaksi B commit

-- Sekarang Transaksi A commit
COMMIT; -- Hasil update A hilang!
