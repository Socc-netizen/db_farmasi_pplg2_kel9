-- =========================================================
-- PRAKTIKUM BASIS DATA XI PPLG 2
-- PEKAN 1: DDL & RELASI (SISTEM MANAJEMEN APOTEK)
-- Database: db_farmasi_pplg2_kel9
-- =========================================================

-- 1. Membuat Database 9
CREATE DATABASE IF NOT EXISTS db_farmasi_pplg2_kel9_2;
USE db_farmasi_pplg2_kel9_2;

-- =========================================================
-- BAGIAN A: CREATE TABLE (Pembuatan Struktur Dasar)
-- =========================================================

-- 2. Tabel tb_pengguna
CREATE TABLE tb_pengguna (
    id_user VARCHAR(8) PRIMARY KEY,
    username VARCHAR(30) UNIQUE NOT NULL,
    password VARCHAR(60) NOT NULL,
    nama_lengkap VARCHAR(50) NOT NULL,
    role ENUM('ADMIN', 'ADMIN_OBAT', 'KASIR') NOT NULL
);

-- 3. Tabel tb_golongan_obat
CREATE TABLE tb_golongan_obat (
    id_golongan VARCHAR(8) PRIMARY KEY,
    nama_golongan VARCHAR(30) NOT NULL
);

-- 4. Tabel tb_pemasok_pbf
CREATE TABLE tb_pemasok_pbf (
    id_pemasok VARCHAR(8) PRIMARY KEY,
    nama_pemasok VARCHAR(50) NOT NULL,
    kota_asal VARCHAR(30),
    kontak VARCHAR(15)
);

-- 5. Tabel tb_obat (dengan Foreign Key)
CREATE TABLE tb_obat (
    id_obat VARCHAR(8) PRIMARY KEY,
    id_golongan VARCHAR(8),
    id_pemasok VARCHAR(8),
    nama_obat VARCHAR(50) NOT NULL,
    harga_satuan INT NOT NULL,
    stok INT NOT NULL,
    CONSTRAINT fk_obat_golongan FOREIGN KEY (id_golongan)
        REFERENCES tb_golongan_obat(id_golongan)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_obat_pemasok FOREIGN KEY (id_pemasok)
        REFERENCES tb_pemasok_pbf(id_pemasok)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 6. Tabel tb_pasien_pembeli
CREATE TABLE tb_pasien_pembeli (
    id_pasien VARCHAR(8) PRIMARY KEY,
    nama_pasien VARCHAR(50) NOT NULL,
    jenis_kelamin CHAR(1) NOT NULL,
    alamat VARCHAR(100),
    tanggal_daftar DATE
);

-- 7. Tabel tb_transaksi_obat
CREATE TABLE tb_transaksi_obat (
    id_transaksi VARCHAR(8) PRIMARY KEY,
    id_pasien VARCHAR(8),
    id_obat VARCHAR(8),
    tanggal_transaksi DATE NOT NULL,
    jumlah_beli INT NOT NULL,
    total_bayar INT NOT NULL,
    status_transaksi VARCHAR(15) NOT NULL,
    CONSTRAINT fk_transaksi_pasien FOREIGN KEY (id_pasien)
        REFERENCES tb_pasien_pembeli(id_pasien)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_transaksi_obat FOREIGN KEY (id_obat)
        REFERENCES tb_obat(id_obat)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 8. Tabel tb_log_farmasi
CREATE TABLE tb_log_farmasi (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    nama_operasi VARCHAR(30) NOT NULL,
    rincian VARCHAR(255),
    waktu_eksekusi DATETIME NOT NULL
);

-- =========================================================
-- BAGIAN B: ALTER TABLE (Modifikasi Struktur - Wajib Pekan 1)
-- =========================================================

-- 9. Menambahkan kolom email pada tb_pengguna (Setelah username)
ALTER TABLE tb_pengguna
    ADD COLUMN email VARCHAR(50) UNIQUE AFTER username;

-- 10. Menambahkan kolom email pada tb_pemasok_pbf (Setelah kontak)
ALTER TABLE tb_pemasok_pbf
    ADD COLUMN email VARCHAR(50) AFTER kontak;

-- 11. Menambahkan kolom email pada tb_pasien_pembeli (Setelah alamat)
ALTER TABLE tb_pasien_pembeli
    ADD COLUMN email VARCHAR(50) AFTER alamat;

-- 12. Menambahkan kolom "nomor_urut" di posisi PALING DEPAN tb_obat (Contoh FIRST)
ALTER TABLE tb_obat
    ADD COLUMN nomor_urut INT NOT NULL FIRST;

-- 13. Mengubah nama kolom "harga_satuan" menjadi "harga_jual" pada tb_obat
ALTER TABLE tb_obat
    CHANGE COLUMN harga_satuan harga_jual INT NOT NULL;

-- 14. Menambahkan kolom "satuan" pada tb_obat (Setelah nama_obat)
ALTER TABLE tb_obat
    ADD COLUMN satuan VARCHAR(10) NOT NULL AFTER nama_obat;

-- 15. Menambahkan kolom "no_telp" pada tb_pasien_pembeli (Setelah email)
ALTER TABLE tb_pasien_pembeli
    ADD COLUMN no_telp VARCHAR(15) AFTER email;