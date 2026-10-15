-- =========================================================
-- TAHAP 0: MANAJEMEN PENGGUNA & HAK AKSES DATABASE (DCL)
-- Mata Pelajaran : Basis Data XI PPLG 2
-- Tema           : Sistem Manajemen Apotek & Transaksi Farmasi
-- Database       : db_farmasi_pplg2_kel9_2
-- =========================================================

-- =========================================================
-- 1. PEMBUATAN 3 AKUN USER DATABASE MARIADB
-- =========================================================

CREATE USER 'admin_apotek'@'localhost' IDENTIFIED BY 'admin123';
CREATE USER 'admin_obat'@'localhost'   IDENTIFIED BY 'obat123';
CREATE USER 'kasir_apotek'@'localhost' IDENTIFIED BY 'kasir123';

-- =========================================================
-- 2. PEMBERIAN HAK AKSES (GRANT) SESUAI PERAN
-- =========================================================

-- ---------------------------------------------------------
-- A. ADMINISTRATOR APOTEK (Hak Akses Penuh / ALL PRIVILEGES)
-- Bisa melakukan semua operasi: DDL, DML, Stored Procedure,
-- Trigger, dan akses ke seluruh tabel.
-- ---------------------------------------------------------
GRANT ALL PRIVILEGES ON db_farmasi_pplg2_kel1.* TO 'admin_apotek'@'localhost';

-- ---------------------------------------------------------
-- B. ADMIN OBAT / GUDANG FARMASI
-- Hanya boleh mengelola data master obat & pemasok.
-- Tabel yang diizinkan: tb_obat, tb_golongan_obat, tb_pemasok_pbf
-- ---------------------------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE 
    ON db_farmasi_pplg2_kel1.tb_obat           TO 'admin_obat'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE 
    ON db_farmasi_pplg2_kel1.tb_golongan_obat  TO 'admin_obat'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE 
    ON db_farmasi_pplg2_kel1.tb_pemasok_pbf    TO 'admin_obat'@'localhost';

-- ---------------------------------------------------------
-- C. KASIR APOTEK / PELAYANAN RESEP
-- Hanya boleh membuat transaksi dan melihat data obat/pasien.
-- Tidak boleh mengubah data master atau tabel user.
-- ---------------------------------------------------------
GRANT SELECT, INSERT 
    ON db_farmasi_pplg2_kel1.tb_transaksi_obat  TO 'kasir_apotek'@'localhost';

GRANT SELECT 
    ON db_farmasi_pplg2_kel1.tb_obat            TO 'kasir_apotek'@'localhost';

GRANT SELECT 
    ON db_farmasi_pplg2_kel1.tb_pasien_pembeli  TO 'kasir_apotek'@'localhost';

-- =========================================================
-- 3. SIMPAN PERUBAHAN HAK AKSES
-- =========================================================
FLUSH PRIVILEGES;

-- =========================================================
-- 4. VERIFIKASI USER YANG SUDAH DIBUAT (Opsional)
-- =========================================================
SELECT USER, HOST FROM mysql.user 
WHERE USER IN ('admin_apotek', 'admin_obat', 'kasir_apotek');

-- Cek hak akses salah satu user:
SHOW GRANTS FOR 'kasir_apotek'@'localhost';