USE cleaning_db;

-- Simulasi FAILURE & RECOVERY dengan ROLLBACK

START TRANSACTION;
INSERT INTO laporan_penggantian (admin_id, pegawai_id, dispenser_id, jumlah, keterangan)
VALUES (1, 1, 1, 10, 'Simulasi gagal');

-- Anggap ada error di sini → maka rollback
ROLLBACK;

-- Cek hasil (seharusnya data gagal tidak masuk)
SELECT * FROM laporan_penggantian WHERE keterangan = 'Simulasi gagal';
