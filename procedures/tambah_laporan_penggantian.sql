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
