-- ============================================================
-- PEKAN 1: INISIALISASI DATABASE & DDL
-- Sistem Manajemen Apotek, Pasokan Obat & Transaksi Farmasi
-- Kelompok: 9
-- ============================================================

-- 1. Buat Database
CREATE DATABASE IF NOT EXISTS db_farmasi_pplg2_kelX;
USE db_farmasi_pplg2_kel9;

-- 2. Tabel tb_pengguna
CREATE TABLE tb_pengguna (
    id_user       VARCHAR(8)  NOT NULL,
    username      VARCHAR(30) NOT NULL UNIQUE,
    password      VARCHAR(60) NOT NULL,
    nama_lengkap  VARCHAR(50) NOT NULL,
    role          ENUM('ADMIN','ADMIN_OBAT','KASIR') NOT NULL,
    PRIMARY KEY (id_user)
) ENGINE=InnoDB;

-- 3. Tabel tb_golongan_obat
CREATE TABLE tb_golongan_obat (
    id_golongan    VARCHAR(8)  NOT NULL,
    nama_golongan  VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_golongan)
) ENGINE=InnoDB;

-- 4. Tabel tb_pemasok_pbf
CREATE TABLE tb_pemasok_pbf (
    id_pemasok   VARCHAR(8)  NOT NULL,
    nama_pemasok VARCHAR(50) NOT NULL,
    kota_asal    VARCHAR(30),
    kontak       VARCHAR(15),
    PRIMARY KEY (id_pemasok)
) ENGINE=InnoDB;

-- 5. Tabel tb_obat
CREATE TABLE tb_obat (
    id_obat      VARCHAR(8)  NOT NULL,
    id_golongan  VARCHAR(8)  NOT NULL,
    id_pemasok   VARCHAR(8)  NOT NULL,
    nama_obat    VARCHAR(50) NOT NULL,
    harga_satuan INT         NOT NULL,
    stok         INT         NOT NULL DEFAULT 0,
    PRIMARY KEY (id_obat),
    CONSTRAINT fk_obat_golongan FOREIGN KEY (id_golongan)
        REFERENCES tb_golongan_obat(id_golongan)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_obat_pemasok FOREIGN KEY (id_pemasok)
        REFERENCES tb_pemasok_pbf(id_pemasok)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 6. Tabel tb_pasien_pembeli
CREATE TABLE tb_pasien_pembeli (
    id_pasien       VARCHAR(8)  NOT NULL,
    nama_pasien     VARCHAR(50) NOT NULL,
    jenis_kelamin   CHAR(1),
    alamat          VARCHAR(100),
    tanggal_daftar  DATE,
    PRIMARY KEY (id_pasien)
) ENGINE=InnoDB;

-- 7. Tabel tb_transaksi_obat
CREATE TABLE tb_transaksi_obat (
    id_transaksi     VARCHAR(8)  NOT NULL,
    id_pasien        VARCHAR(8)  NOT NULL,
    id_obat          VARCHAR(8)  NOT NULL,
    tanggal_transaksi DATE       NOT NULL,
    jumlah_beli      INT         NOT NULL,
    total_bayar      INT         NOT NULL,
    status_transaksi VARCHAR(15) NOT NULL DEFAULT 'SELESAI',
    PRIMARY KEY (id_transaksi),
    CONSTRAINT fk_transaksi_pasien FOREIGN KEY (id_pasien)
        REFERENCES tb_pasien_pembeli(id_pasien)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_transaksi_obat FOREIGN KEY (id_obat)
        REFERENCES tb_obat(id_obat)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 8. Tabel tb_log_farmasi
CREATE TABLE tb_log_farmasi (
    id_log          INT AUTO_INCREMENT NOT NULL,
    nama_operasi    VARCHAR(30),
    rincian         VARCHAR(255),
    waktu_eksekusi  DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_log)
) ENGINE=InnoDB;

-- 9. Modifikasi ALTER TABLE (contoh sesuai instruksi)
ALTER TABLE tb_pasien_pembeli
    ADD COLUMN no_telepon VARCHAR(15) AFTER alamat;

ALTER TABLE tb_obat
    CHANGE COLUMN harga_satuan harga_jual INT NOT NULL;

-- 10. Cek struktur
SHOW TABLES;
DESCRIBE tb_obat;