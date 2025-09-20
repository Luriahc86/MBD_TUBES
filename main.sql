-- ===========================================
-- MAIN FILE UNTUK IMPORT LANGSUNG KE MYSQL
-- ===========================================

DROP DATABASE IF EXISTS cleaning_db;
CREATE DATABASE cleaning_db;
USE cleaning_db;

-- ===========================================
-- TABEL
-- ===========================================

-- Tabel admin
CREATE TABLE admin (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  nama VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabel pegawai
CREATE TABLE pegawai (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  nama VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabel lokasi
CREATE TABLE lokasi (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama_lokasi VARCHAR(100) NOT NULL
);

-- Tabel dispenser
CREATE TABLE dispenser (
  id INT AUTO_INCREMENT PRIMARY KEY,
  lokasi_id INT NOT NULL,
  status VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (lokasi_id) REFERENCES lokasi(id)
);

-- Tabel laporan_penggantian
CREATE TABLE laporan_penggantian (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pegawai_id INT NOT NULL,
  dispenser_id INT NOT NULL,
  jumlah INT NOT NULL,
  tanggal DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (pegawai_id) REFERENCES pegawai(id),
  FOREIGN KEY (dispenser_id) REFERENCES dispenser(id)
);

-- ===========================================
-- PROCEDURE
-- ===========================================

DELIMITER $$

CREATE PROCEDURE tambah_laporan_penggantian (
    IN p_pegawai_id INT,
    IN p_dispenser_id INT,
    IN p_jumlah INT,
    IN p_tanggal DATE
)
BEGIN
    INSERT INTO laporan_penggantian (pegawai_id, dispenser_id, jumlah, tanggal)
    VALUES (p_pegawai_id, p_dispenser_id, p_jumlah, p_tanggal);
END$$

DELIMITER ;

-- ===========================================
-- FUNCTION
-- ===========================================

DELIMITER $$

CREATE FUNCTION total_tisu_by_pegawai(p_pegawai_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COALESCE(SUM(jumlah),0) INTO total
    FROM laporan_penggantian
    WHERE pegawai_id = p_pegawai_id;
    RETURN total;
END$$

DELIMITER ;

-- ===========================================
-- VIEW
-- ===========================================

CREATE OR REPLACE VIEW v_laporan_penggantian AS
SELECT 
    lp.id,
    p.nama AS nama_pegawai,
    lp.dispenser_id,
    l.nama_lokasi,
    lp.jumlah,
    lp.tanggal
FROM laporan_penggantian lp
JOIN pegawai p ON lp.pegawai_id = p.id
JOIN dispenser d ON lp.dispenser_id = d.id
JOIN lokasi l ON d.lokasi_id = l.id;

-- ===========================================
-- TRIGGER (contoh: update_pegawai_timestamp)
-- ===========================================

DELIMITER $$

CREATE TRIGGER update_pegawai_timestamp
BEFORE UPDATE ON pegawai
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END$$

CREATE TRIGGER update_dispenser_timestamp
BEFORE UPDATE ON dispenser
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END$$

DELIMITER ;

-- ===========================================
-- SELESAI
-- ===========================================

SELECT '=== SCMS DB SETUP COMPLETE ===' AS status;
