DROP VIEW IF EXISTS v_laporan_penggantian;
CREATE VIEW v_laporan_penggantian AS
SELECT 
  lpt.id,
  p.nama AS nama_pegawai,
  d.id AS dispenser_id,
  l.nama_lokasi,
  lpt.jumlah,
  lpt.tanggal
FROM laporan_penggantian_tissue lpt
JOIN pegawai p ON lpt.pegawai_id = p.id
JOIN dispenser d ON lpt.dispenser_id = d.id
JOIN lokasi l ON d.lokasi_id = l.id;
