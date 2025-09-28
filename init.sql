-- ========================================
--  INIT DATABASE CLEANING_DB
-- ========================================

-- Buat database & gunakan
CREATE DATABASE IF NOT EXISTS cleaning_db;
USE cleaning_db;

-- ========== SCHEMA ==========
SOURCE schema/01_tables.sql;

-- ========== SEED DATA ==========
SOURCE seed/01_admin.sql;
SOURCE seed/02_pegawai.sql;
SOURCE seed/03_lokasi.sql;
SOURCE seed/04_dispenser.sql;
SOURCE seed/05_login.sql;
SOURCE seed/06_laporan.sql;

-- ========== FUNCTIONS ==========
SOURCE functions/total_tisu_by_pegawai.sql;

-- ========== PROCEDURES ==========
SOURCE procedures/tambah_laporan_penggantian.sql;

-- ========== TRIGGERS ==========
SOURCE triggers/update_dispenser_timestamp.sql;
SOURCE triggers/update_pegawai_timestamp.sql;

-- ========== VIEWS ==========
SOURCE views/v_laporan_penggantian.sql;
SOURCE views/combined.sql;
SOURCE views/main.sql;

-- ========== CEK HASIL ==========
SHOW TABLES;
SHOW FULL TABLES IN cleaning_db WHERE TABLE_TYPE LIKE 'VIEW';
SHOW FUNCTION STATUS WHERE Db = 'cleaning_db';
SHOW PROCEDURE STATUS WHERE Db = 'cleaning_db';
SHOW TRIGGERS;
