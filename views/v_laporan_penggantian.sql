CREATE OR REPLACE VIEW v_laporan_penggantian AS
SELECT 
    l.id_laporan,
    p.nama AS petugas,
    d.kode_dispenser,
    lo.nama_lokasi,
    l.waktu,
    l.jumlah_tisu
FROM laporan_penggantian l
JOIN pegawai p ON l.id_pegawai = p.id_pegawai
JOIN dispenser d ON l.id_dispenser = d.id_dispenser
JOIN lokasi lo ON d.id_lokasi = lo.id_lokasi;

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

CREATE OR REPLACE VIEW v_laporan_penggantian AS
SELECT 
    l.id_laporan,
    p.nama AS petugas,
    d.kode_dispenser,
    lo.nama_lokasi,
    l.waktu,
    l.jumlah_tisu
FROM laporan_penggantian l
JOIN pegawai p ON l.id_pegawai = p.id_pegawai
JOIN dispenser d ON l.id_dispenser = d.id_dispenser
JOIN lokasi lo ON d.id_lokasi = lo.id_lokasi;

DELIMITER ;
