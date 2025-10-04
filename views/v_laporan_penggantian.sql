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
