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
INSERT INTO laporan_penggantian (id_pegawai, id_dispenser, jumlah_tisu)
VALUES
(1,1,60),(2,1,55),(3,2,70),(4,3,80),(5,2,65),
(6,4,75),(7,5,90),(1,6,55),(2,7,66),(3,5,77),
(4,6,88),(5,7,99),(6,1,58),(7,2,62),(1,3,73),
(2,4,64),(3,5,85),(4,6,59),(5,7,92),(6,1,61),
(7,2,67),(1,3,72),(2,4,63),(3,5,81),(4,6,54),
(5,7,95),(6,1,77),(7,2,69),(1,3,83),(2,4,71),
(3,5,88),(4,6,79),(5,7,90),(6,1,82),(7,2,91),
(1,3,74),(2,4,66),(3,5,59),(4,6,68),(5,7,73),
(6,1,85),(7,2,97),(1,3,64),(2,4,75),(3,5,82),
(4,6,88),(5,7,69),(6,1,77),(7,2,70),(1,3,95);
