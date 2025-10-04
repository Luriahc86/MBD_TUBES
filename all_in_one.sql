-- ==========================================================
-- RESET DATABASE
-- ==========================================================
DROP DATABASE IF EXISTS cleaning_db;
CREATE DATABASE cleaning_db;
USE cleaning_db;

-- ==========================================================
-- SCHEMA (TABEL)
-- ==========================================================
CREATE TABLE lokasi (
    id_lokasi INT AUTO_INCREMENT PRIMARY KEY,
    nama_lokasi VARCHAR(100) NOT NULL,
    deskripsi TEXT
);

CREATE TABLE pegawai (
    id_pegawai INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    shift ENUM('Pagi','Siang','Malam'),
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE dispenser (
    id_dispenser INT AUTO_INCREMENT PRIMARY KEY,
    id_lokasi INT,
    kode_dispenser VARCHAR(20) UNIQUE NOT NULL,
    status ENUM('AKTIF','RUSAK') DEFAULT 'AKTIF',
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_lokasi) REFERENCES lokasi(id_lokasi)
);

CREATE TABLE laporan_penggantian (
    id_laporan INT AUTO_INCREMENT PRIMARY KEY,
    id_pegawai INT,
    id_dispenser INT,
    waktu TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    jumlah_tisu INT NOT NULL,
    FOREIGN KEY (id_pegawai) REFERENCES pegawai(id_pegawai),
    FOREIGN KEY (id_dispenser) REFERENCES dispenser(id_dispenser)
);

CREATE TABLE admin (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100)
);

CREATE TABLE login (
    id_login INT AUTO_INCREMENT PRIMARY KEY,
    id_admin INT,
    waktu_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_admin) REFERENCES admin(id_admin)
);

-- ==========================================================
-- SEED DATA DUMMY
-- ==========================================================
INSERT INTO admin (username, password) VALUES
('admin1', '12345'),
('admin2', 'password');

INSERT INTO pegawai (nama, shift) VALUES
('Andi', 'Pagi'),
('Budi', 'Siang'),
('Citra', 'Malam'),
('Dewi', 'Pagi'),
('Eko', 'Siang'),
('Fajar', 'Malam'),
('Gina', 'Pagi');

INSERT INTO lokasi (nama_lokasi, deskripsi) VALUES
('Gedung A - Lantai 1', 'Dekat lobby utama'),
('Gedung A - Lantai 2', 'Dekat ruang rapat'),
('Gedung B - Lantai 1', 'Dekat kantin'),
('Gedung B - Lantai 3', 'Dekat musholla'),
('Gedung C - Lantai 5', 'Dekat toilet pria');

INSERT INTO dispenser (id_lokasi, kode_dispenser, status) VALUES
(1, 'DSP-001', 'AKTIF'),
(1, 'DSP-002', 'AKTIF'),
(2, 'DSP-003', 'AKTIF'),
(3, 'DSP-004', 'RUSAK'),
(4, 'DSP-005', 'AKTIF'),
(5, 'DSP-006', 'AKTIF'),
(5, 'DSP-007', 'AKTIF');

INSERT INTO login (id_admin) VALUES (1), (2);

-- ==========================================================
-- FUNCTION
-- ==========================================================
DROP FUNCTION IF EXISTS total_tisu_by_pegawai;
DELIMITER $$

CREATE FUNCTION total_tisu_by_pegawai(p_id_pegawai INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(jumlah_tisu) INTO total
    FROM laporan_penggantian
    WHERE id_pegawai = p_id_pegawai;
    RETURN IFNULL(total, 0);
END$$

DELIMITER ;

-- ==========================================================
-- PROCEDURE TAMBAH LAPORAN
-- ==========================================================
DROP PROCEDURE IF EXISTS tambah_laporan_penggantian;
DELIMITER $$

CREATE PROCEDURE tambah_laporan_penggantian(
    IN p_id_pegawai INT,
    IN p_id_dispenser INT,
    IN p_jumlah_tisu INT
)
BEGIN
    INSERT INTO laporan_penggantian(id_pegawai, id_dispenser, jumlah_tisu)
    VALUES (p_id_pegawai, p_id_dispenser, p_jumlah_tisu);

    UPDATE dispenser
    SET last_update = NOW()
    WHERE id_dispenser = p_id_dispenser;
END$$

DELIMITER ;

-- ==========================================================
-- PROCEDURE GENERATE 100 DUMMY LAPORAN
-- ==========================================================
DROP PROCEDURE IF EXISTS generate_dummy_laporan;
DELIMITER $$

CREATE PROCEDURE generate_dummy_laporan(IN jumlah INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_pegawai INT;
    DECLARE max_dispenser INT;

    SELECT COUNT(*) INTO max_pegawai FROM pegawai;
    SELECT COUNT(*) INTO max_dispenser FROM dispenser;

    WHILE i <= jumlah DO
        INSERT INTO laporan_penggantian(id_pegawai, id_dispenser, jumlah_tisu, waktu)
        VALUES (
            FLOOR(1 + RAND() * max_pegawai),   -- pegawai random
            FLOOR(1 + RAND() * max_dispenser), -- dispenser random
            FLOOR(50 + RAND() * 50),           -- jumlah tisu antara 50-100
            NOW() - INTERVAL FLOOR(RAND()*30) DAY -- waktu random 30 hari terakhir
        );
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- Jalankan langsung generate 100 dummy laporan
CALL generate_dummy_laporan(100);

-- ==========================================================
-- TRIGGER
-- ==========================================================
DROP TRIGGER IF EXISTS update_dispenser_timestamp;
DELIMITER $$

CREATE TRIGGER update_dispenser_timestamp
BEFORE UPDATE ON dispenser
FOR EACH ROW
BEGIN
    SET NEW.last_update = NOW();
END$$

DELIMITER ;

-- ==========================================================
-- VIEW
-- ==========================================================
CREATE OR REPLACE VIEW v_laporan_penggantian AS
SELECT 
    l.id_laporan,
    p.nama AS petugas,
    d.kode_dispenser,
    lo.nama_lokasi,
    l.waktu,
    l.jumlah_tisu,
    d.status
FROM laporan_penggantian l
JOIN pegawai p ON l.id_pegawai = p.id_pegawai
JOIN dispenser d ON l.id_dispenser = d.id_dispenser
JOIN lokasi lo ON d.id_lokasi = lo.id_lokasi;

-- ==========================================================
-- TESTING QUERY
-- ==========================================================
-- Test procedure
CALL tambah_laporan_penggantian(1, 3, 77);

-- Test function
SELECT total_tisu_by_pegawai(1) AS total_tisu_Andi;

-- Test view
SELECT * FROM v_laporan_penggantian LIMIT 20;

-- Test trigger (update dispenser -> last_update berubah)
UPDATE dispenser SET status='RUSAK' WHERE id_dispenser=5;
SELECT * FROM dispenser WHERE id_dispenser=5;

-- Cek total laporan
SELECT COUNT(*) AS total_laporan FROM laporan_penggantian;
