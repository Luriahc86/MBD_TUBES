USE cleaning_db;

-- ============================
-- RESET ALL DATA (TRUNCATE)
-- ============================

-- Urutan penting karena ada foreign key
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE laporan_penggantian;
TRUNCATE TABLE dispenser;
TRUNCATE TABLE lokasi;
TRUNCATE TABLE pegawai;
TRUNCATE TABLE admin;

SET FOREIGN_KEY_CHECKS = 1;

-- ============================
-- RE-SEED DATA
-- ============================

-- Admin
INSERT INTO admin (username, password, nama)
VALUES ('admin1', '12345', 'Super Admin');

-- Pegawai
INSERT INTO pegawai (username, password, nama)
VALUES 
  ('pegawai1', 'abc123', 'Faqih Chairul Anam'),
  ('pegawai2', 'xyz456', 'Alya Juniar');

-- Lokasi
INSERT INTO lokasi (nama_lokasi) 
VALUES ('Lobi Utama'), 
       ('Ruang Tunggu A');

-- Dispenser
INSERT INTO dispenser (lokasi_id, status) 
VALUES (1, 'Aktif'), 
       (2, 'Aktif');

-- Laporan awal via procedure
CALL tambah_laporan_penggantian(1, 1, 5, CURDATE());
CALL tambah_laporan_penggantian(2, 2, 3, CURDATE());

-- ============================
-- STATUS
-- ============================
SELECT 'Database sudah di-reset & data awal berhasil dimasukkan.' AS status;
