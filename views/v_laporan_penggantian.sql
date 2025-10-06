-- Active: 1747977627544@@127.0.0.1@3306@cleaning_db
USE cleaning_db;

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
