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
DELIMITER ;CREATE OR REPLACE FUNCTION tambah_laporan_penggantian(
    p_id_pegawai INT,
    p_id_dispenser INT,
    p_jumlah_tisu INT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO laporan_penggantian(id_pegawai, id_dispenser, jumlah_tisu)
    VALUES (p_id_pegawai, p_id_dispenser, p_jumlah_tisu);

    -- Update dispenser timestamp
    UPDATE dispenser
    SET last_update = NOW()
    WHERE id_dispenser = p_id_dispenser;
END;
$$ LANGUAGE plpgsql;
