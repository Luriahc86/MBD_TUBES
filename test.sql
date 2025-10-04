USE cleaning_db;

-- Test Procedure
CALL tambah_laporan_penggantian(1, 3, 77);

-- Test Function
SELECT total_tisu_by_pegawai(1) AS total_tisu_Andi;
select total_tisu_by_pegawai(2) AS total_tisu_Budi;
select total_tisu_by_pegawai(3) AS total_tisu_Caca;
select total_tisu_by_pegawai(4) AS total_tisu_Deni;
select total_tisu_by_pegawai(5) AS total_tisu_Eka;
select total_tisu_by_pegawai(6) AS total_tisu_Fani;
select total_tisu_by_pegawai(7) AS total_tisu_Gina;

-- Test View
SELECT * FROM v_laporan_penggantian;

-- Test Trigger (update dispenser → last_update otomatis berubah)
UPDATE dispenser SET status='RUSAK' WHERE id_dispenser=5;
SELECT * FROM dispenser WHERE id_dispenser=5;

-- Cek data laporan
SELECT * FROM laporan_penggantian;
