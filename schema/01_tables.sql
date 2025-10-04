DROP TABLE IF EXISTS laporan_penggantian_tissue;
DROP TABLE IF EXISTS login;
DROP TABLE IF EXISTS dispenser;
DROP TABLE IF EXISTS lokasi;
DROP TABLE IF EXISTS pegawai;
DROP TABLE IF EXISTS admin;

CREATE TABLE admin (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50),
  password VARCHAR(255),
  nama VARCHAR(100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE pegawai (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50),
  password VARCHAR(255),
  nama VARCHAR(100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Lokasi (tempat dispenser)
CREATE TABLE lokasi (
    id_lokasi SERIAL PRIMARY KEY,
    nama_lokasi VARCHAR(100) NOT NULL,
    deskripsi TEXT
);

-- Dispenser (alat tisu)
CREATE TABLE dispenser (
    id_dispenser SERIAL PRIMARY KEY,
    id_lokasi INT REFERENCES lokasi(id_lokasi),
    kode_dispenser VARCHAR(20) UNIQUE NOT NULL,
    status VARCHAR(20) DEFAULT 'AKTIF',
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Laporan penggantian tisu
CREATE TABLE laporan_penggantian (
    id_laporan SERIAL PRIMARY KEY,
    id_pegawai INT REFERENCES pegawai(id_pegawai),
    id_dispenser INT REFERENCES dispenser(id_dispenser),
    waktu TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    jumlah_tisu INT NOT NULL
);

CREATE TABLE login (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  role ENUM('admin','pegawai'),
  waktu_login DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE laporan_penggantian_tissue (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pegawai_id INT,
  dispenser_id INT,
  jumlah INT,
  tanggal DATE,
  FOREIGN KEY (pegawai_id) REFERENCES pegawai(id),
  FOREIGN KEY (dispenser_id) REFERENCES dispenser(id)
);
