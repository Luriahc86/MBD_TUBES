-- Bersihkan dan buat ulang database
DROP DATABASE IF EXISTS cleaning_db;
CREATE DATABASE cleaning_db;
USE cleaning_db;

-- =====================
-- 1. Schema (Tabel)
-- =====================
SOURCE schema/01_tables.sql;

-- =====================
-- 2. Procedures
-- =====================
SOURCE procedures/tambah_laporan_penggantian.sql;

-- =====================
-- 3. Functions
-- =====================
SOURCE functions/total_tisu_by_pegawai.sql;

-- =====================
-- 4. Triggers
-- =====================
SOURCE triggers/update_pegawai_timestamp.sql;
SOURCE triggers/update_dispenser_timestamp.sql;

-- =====================
-- 5. Views
-- =====================
SOURCE views/v_laporan_penggantian.sql;

-- =====================
-- 6. Seeds (Data Awal)
-- =====================
SOURCE seed/01_admin.sql;
SOURCE seed/02_pegawai.sql;
SOURCE seed/03_lokasi.sql;
SOURCE seed/04_dispenser.sql;
SOURCE seed/05_login.sql;
SOURCE seed/06_laporan.sql;

-- =====================
-- 7. Testing (Opsional)
-- =====================
-- Agar rapi, semua uji coba aku pisahkan ke file test.sql
-- Jadi kalau mau testing tinggal aktifkan bagian ini.
-- Hapus komentar di bawah untuk jalanin:
-- SOURCE test.sql;
