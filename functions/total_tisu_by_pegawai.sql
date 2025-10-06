-- Active: 1747977627544@@127.0.0.1@3306@cleaning_db
USE cleaning_db;

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
