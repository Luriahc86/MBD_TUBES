-- Active: 1747977627544@@127.0.0.1@3306@cleaning_db
START TRANSACTION;
INSERT INTO lokasi (nama_lokasi, deskripsi) VALUES ('Gedung X - Lantai 1', 'Dummy lokasi');
INSERT INTO dispenser (id_lokasi, kode_dispenser) VALUES (999, 'DSP-999'); -- error
ROLLBACK; -- semua perubahan dibatalkan
