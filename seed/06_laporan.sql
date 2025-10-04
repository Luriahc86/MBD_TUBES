INSERT INTO laporan_penggantian (id_pegawai, id_dispenser, waktu, jumlah_tisu)
SELECT 
    (RANDOM()*6 + 1)::INT, 
    (RANDOM()*6 + 1)::INT, 
    NOW() - (RANDOM() * (interval '30 days')),
    (RANDOM()*50 + 50)::INT
FROM generate_series(1,50);