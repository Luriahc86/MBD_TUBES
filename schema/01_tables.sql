CREATE TABLE lokasi (
    id_lokasi INT AUTO_INCREMENT PRIMARY KEY,
    nama_lokasi VARCHAR(100) NOT NULL,
    deskripsi TEXT
);

CREATE TABLE pegawai (
    id_pegawai INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    shift ENUM('Pagi','Siang','Malam')
);

CREATE TABLE dispenser (
    id_dispenser INT AUTO_INCREMENT PRIMARY KEY,
    id_lokasi INT,
    kode_dispenser VARCHAR(20) UNIQUE NOT NULL,
    status ENUM('AKTIF','RUSAK') DEFAULT 'AKTIF',
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_lokasi) REFERENCES lokasi(id_lokasi)
);

CREATE TABLE laporan_penggantian (
    id_laporan INT AUTO_INCREMENT PRIMARY KEY,
    id_pegawai INT,
    id_dispenser INT,
    waktu TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    jumlah_tisu INT NOT NULL,
    FOREIGN KEY (id_pegawai) REFERENCES pegawai(id_pegawai),
    FOREIGN KEY (id_dispenser) REFERENCES dispenser(id_dispenser)
);

CREATE TABLE admin (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100)
);

CREATE TABLE login (
    id_login INT AUTO_INCREMENT PRIMARY KEY,
    id_admin INT,
    waktu_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_admin) REFERENCES admin(id_admin)
);
