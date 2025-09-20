-- ===========================================
-- MAIN FILE UNTUK IMPORT LANGSUNG KE MYSQL
-- ===========================================

-- Bersihkan dan buat ulang database
DROP DATABASE IF EXISTS cleaning_db;
CREATE DATABASE cleaning_db;
USE cleaning_db;

-- ===========================================
-- SCHEMA / TABEL
-- ===========================================
/* Copy semua CREATE TABLE dari schema/01_tables.sql di sini */

-- ===========================================
-- PROCEDURES
-- ===========================================
/* Copy isi procedures/tambah_laporan_penggantian.sql di sini */

-- ===========================================
-- FUNCTIONS
-- ===========================================
/* Copy isi functions/total_tisu_by_pegawai.sql di sini */

-- ===========================================
-- TRIGGERS
-- ===========================================
/* Copy isi triggers/update_pegawai_timestamp.sql di sini */
/* Copy isi triggers/update_dispenser_timestamp.sql di sini */

-- ===========================================
-- VIEWS
-- ===========================================
/* Copy isi views/v_laporan_penggantian.sql di sini */

-- ===========================================
-- SEED DATA (Data Awal)
-- ===========================================
/* Copy isi seed/00_reset.sql, 01_admin.sql, 02_pegawai.sql, dst di sini */

-- ===========================================
-- TESTING (seperti yang kamu tulis)
-- ===========================================

USE cleaning_db;

-- Tambah admin
INSERT INTO admin (username, password, nama)
VALUES ('admin1', '12345', 'Super Admin');

-- Tambah pegawai
INSERT INTO pegawai (username, password, nama)
VALUES 
  ('pegawai1', 'abc123', 'Faqih Chairul Anam'),
  ('pegawai2', 'xyz456', 'Alya Juniar');

-- Tambah lokasi
INSERT INTO lokasi (nama_lokasi) 
VALUES ('Lobi Utama'), 
       ('Ruang Tunggu A');

-- Tambah dispenser
INSERT INTO dispenser (lokasi_id, status) 
VALUES (1, 'Aktif'), 
       (2, 'Aktif');

-- Tambah laporan penggantian via procedure
CALL tambah_laporan_penggantian(1, 1, 5, CURDATE());
CALL tambah_laporan_penggantian(2, 2, 3, CURDATE());

-- TEST FUNCTION
SELECT '=== HASIL FUNCTION: total_tisu_by_pegawai ===' AS header;
SELECT 
    1 AS pegawai_id,
    total_tisu_by_pegawai(1) AS total_tisu;

-- TEST VIEW
SELECT '=== HASIL VIEW: v_laporan_penggantian ===' AS header;
SELECT 
    id AS laporan_id,
    nama_pegawai,
    dispenser_id,
    nama_lokasi,
    jumlah,
    DATE_FORMAT(tanggal, '%Y-%m-%d') AS tanggal
FROM v_laporan_penggantian
ORDER BY tanggal DESC
LIMIT 10;

-- TEST TRIGGER
SELECT '=== CEK TRIGGER: update_pegawai_timestamp ===' AS header;
UPDATE pegawai 
SET nama = 'Faqih Anam Updated' 
WHERE id = 1;

SELECT 
    id AS pegawai_id,
    username,
    nama,
    DATE_FORMAT(created_at, '%Y-%m-%d %H:%i:%s') AS created_at,
    DATE_FORMAT(updated_at, '%Y-%m-%d %H:%i:%s') AS updated_at
FROM pegawai
WHERE id = 1;

-- SELESAI TESTING
SELECT '=== SEMUA TEST SUKSES DIJALANKAN ===' AS status;
