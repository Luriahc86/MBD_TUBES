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
