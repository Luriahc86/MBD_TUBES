-- Auto-generated combined SQL file

DROP DATABASE IF EXISTS cleaning_db;
CREATE DATABASE cleaning_db;
USE cleaning_db;



-- ========================
-- File: 01_tables.sql
-- ========================

DROP TABLE IF EXISTS laporan_penggantian_tissue;
DROP TABLE IF EXISTS login;
DROP TABLE IF EXISTS dispenser;
DROP TABLE IF EXISTS lokasi;
DROP TABLE IF EXISTS pegawai;
DROP TABLE IF EXISTS admin;

CREATE TABLE admin (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50),
  password VARCHAR(255),
  nama VARCHAR(100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE pegawai (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50),
  password VARCHAR(255),
  nama VARCHAR(100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE lokasi (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama_lokasi VARCHAR(100)
);

CREATE TABLE dispenser (
  id INT AUTO_INCREMENT PRIMARY KEY,
  lokasi_id INT,
  status VARCHAR(50),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (lokasi_id) REFERENCES lokasi(id)
);

CREATE TABLE login (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  role ENUM('admin','pegawai'),
  waktu_login DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE laporan_penggantian_tissue (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pegawai_id INT,
  dispenser_id INT,
  jumlah INT,
  tanggal DATE,
  FOREIGN KEY (pegawai_id) REFERENCES pegawai(id),
  FOREIGN KEY (dispenser_id) REFERENCES dispenser(id)
);




-- ========================
-- File: tambah_laporan_penggantian.sql
-- ========================

DROP PROCEDURE IF EXISTS tambah_laporan_penggantian;
DELIMITER //
CREATE PROCEDURE tambah_laporan_penggantian (
  IN p_pegawai_id INT,
  IN p_dispenser_id INT,
  IN p_jumlah INT,
  IN p_tanggal DATE
)
BEGIN
  INSERT INTO laporan_penggantian_tissue (pegawai_id, dispenser_id, jumlah, tanggal)
  VALUES (p_pegawai_id, p_dispenser_id, p_jumlah, p_tanggal);
END //
DELIMITER ;




-- ========================
-- File: total_tisu_by_pegawai.sql
-- ========================

DROP FUNCTION IF EXISTS total_tisu_by_pegawai;
DELIMITER //
CREATE FUNCTION total_tisu_by_pegawai(p_pegawai_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT SUM(jumlah) INTO total
  FROM laporan_penggantian_tissue
  WHERE pegawai_id = p_pegawai_id;
  RETURN IFNULL(total, 0);
END //
DELIMITER ;




-- ========================
-- File: update_pegawai_timestamp.sql
-- ========================

DROP TRIGGER IF EXISTS update_pegawai_timestamp;
DELIMITER //
CREATE TRIGGER update_pegawai_timestamp
BEFORE UPDATE ON pegawai
FOR EACH ROW
BEGIN
  SET NEW.updated_at = CURRENT_TIMESTAMP;
END //
DELIMITER ;




-- ========================
-- File: update_dispenser_timestamp.sql
-- ========================

DROP TRIGGER IF EXISTS update_dispenser_timestamp;
DELIMITER //
CREATE TRIGGER update_dispenser_timestamp
BEFORE UPDATE ON dispenser
FOR EACH ROW
BEGIN
  SET NEW.updated_at = CURRENT_TIMESTAMP;
END //
DELIMITER ;




-- ========================
-- File: v_laporan_penggantian.sql
-- ========================

DROP VIEW IF EXISTS v_laporan_penggantian;
CREATE VIEW v_laporan_penggantian AS
SELECT 
  lpt.id,
  p.nama AS nama_pegawai,
  d.id AS dispenser_id,
  l.nama_lokasi,
  lpt.jumlah,
  lpt.tanggal
FROM laporan_penggantian_tissue lpt
JOIN pegawai p ON lpt.pegawai_id = p.id
JOIN dispenser d ON lpt.dispenser_id = d.id
JOIN lokasi l ON d.lokasi_id = l.id;




-- ========================
-- File: 00_reset.sql
-- ========================

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




-- ========================
-- File: 01_admin.sql
-- ========================

INSERT INTO admin (username, password, nama)
VALUES ('admin1', '12345', 'Super Admin');




-- ========================
-- File: 02_pegawai.sql
-- ========================

INSERT INTO pegawai (username, password, nama)
VALUES 
  ('pegawai1', 'abc123', 'Faqih Chairul Anam'),
  ('pegawai2', 'xyz456', 'Alya Juniar');




-- ========================
-- File: 03_lokasi.sql
-- ========================

INSERT INTO lokasi (nama_lokasi) 
VALUES ('Lobi Utama'), ('Ruang Tunggu A');




-- ========================
-- File: 04_dispenser.sql
-- ========================

INSERT INTO dispenser (lokasi_id, status) 
VALUES (1, 'Aktif'), (2, 'Aktif');




-- ========================
-- File: 05_login.sql
-- ========================

INSERT INTO login (user_id, role)
VALUES 
  (1, 'admin'),
  (1, 'pegawai'),
  (2, 'pegawai');




-- ========================
-- File: 06_laporan.sql
-- ========================

CALL tambah_laporan_penggantian(1, 1, 5, CURDATE());
CALL tambah_laporan_penggantian(2, 2, 3, CURDATE());




-- ========================
-- File: 01_lost_update.sql
-- ========================

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




-- ========================
-- File: 02_locking.sql
-- ========================

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




-- ========================
-- File: 03_failure_recovery.sql
-- ========================

USE cleaning_db;

-- Simulasi FAILURE & RECOVERY dengan ROLLBACK

START TRANSACTION;
INSERT INTO laporan_penggantian_tissue (admin_id, pegawai_id, dispenser_id, jumlah, keterangan)
VALUES (1, 1, 1, 10, 'Simulasi gagal');

-- Anggap ada error di sini → maka rollback
ROLLBACK;

-- Cek hasil (seharusnya data gagal tidak masuk)
SELECT * FROM laporan_penggantian_tissue WHERE keterangan = 'Simulasi gagal';




-- ========================
-- File: test.sql
-- ========================

USE cleaning_db;

-- ====================================
-- SEED DATA (UNTUK PENGUJIAN)
-- ====================================

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


-- ====================================
-- TEST FUNCTION
-- ====================================
SELECT '=== HASIL FUNCTION: total_tisu_by_pegawai ===' AS header;

SELECT 
    1 AS pegawai_id,
    total_tisu_by_pegawai(1) AS total_tisu;


-- ====================================
-- TEST VIEW
-- ====================================
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


-- ====================================
-- TEST TRIGGER
-- ====================================
SELECT '=== CEK TRIGGER: update_pegawai_timestamp ===' AS header;

-- Update nama pegawai → seharusnya updated_at ikut berubah
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


-- ====================================
-- SELESAI TESTING
-- ====================================
SELECT '=== SEMUA TEST SUKSES DIJALANKAN ===' AS status;


