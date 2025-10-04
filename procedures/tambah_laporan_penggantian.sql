USE cleaning_db;

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
