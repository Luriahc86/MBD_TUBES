-- Test procedure
CALL tambah_laporan_penggantian(1, 3, 77);

-- Test function
SELECT total_tisu_by_pegawai(1) AS total_tisu_Andi;

-- Test view
SELECT * FROM v_laporan_penggantian;

-- Test trigger (update dispenser)
UPDATE dispenser SET status='RUSAK' WHERE id_dispenser=5;

-- Check hasil update
SELECT * FROM dispenser WHERE id_dispenser=5;
