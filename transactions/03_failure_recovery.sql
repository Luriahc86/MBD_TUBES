USE cleaning_db;
SELECT * FROM v_laporan_penggantian ORDER BY id DESC LIMIT 5;

-- Simulasi FAILURE & RECOVERY dengan ROLLBACK
START TRANSACTION;

INSERT INTO v_laporan_penggantian (pegawai_id, dispenser_id, jumlah, tanggal)
VALUES (1, 1, 10, '2025-09-20');

-- Anggap ada error di sini → maka rollback
ROLLBACK;

-- Cek hasil (seharusnya data gagal tidak masuk)
SELECT * FROM v_laporan_penggantian WHERE jumlah = 10 AND tanggal = '2025-09-20';
