START TRANSACTION;
INSERT INTO lokasi (nama_lokasi, deskripsi) VALUES ('Gedung X - Lantai 1', 'Dummy lokasi');
INSERT INTO dispenser (id_lokasi, kode_dispenser) VALUES (999, 'DSP-999'); -- error
ROLLBACK; -- semua perubahan dibatalkan
