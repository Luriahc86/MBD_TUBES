START TRANSACTION;
INSERT INTO lokasi (nama_lokasi, deskripsi) VALUES ('Gedung D - Lantai 2', 'Dekat pantry');
INSERT INTO dispenser (id_lokasi, kode_dispenser) VALUES (999, 'DSP-099'); -- Error (foreign key tidak ada)
ROLLBACK; -- Semua perubahan dibatalkan
