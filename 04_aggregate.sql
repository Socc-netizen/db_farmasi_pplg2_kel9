-- =========================================================
-- PEKAN 3: FUNGSI AGREGASI & GROUPING
-- File: 04_aggregate.sql
-- Database: db_farmasi_pplg2_kel9_2
-- =========================================================

USE db_farmasi_pplg2_kel9_2;

-- =========================================================
-- A. FUNGSI AGREGASI DASAR (SUM, COUNT, AVG, MIN, MAX)
-- =========================================================

-- 1. Menghitung total aset apotek (harga_jual * stok dari semua obat)
SELECT SUM(harga_jual * stok) AS total_aset_apotek FROM tb_obat;

-- 2. Menghitung jumlah jenis obat, rata-rata, termurah, dan termahal
SELECT 
    COUNT(*) AS jumlah_jenis_obat,
    AVG(harga_jual) AS rata_rata_harga,
    MIN(harga_jual) AS harga_termurah,
    MAX(harga_jual) AS harga_termahal
FROM tb_obat;

-- 3. Total pendapatan dari transaksi yang berstatus 'LUNAS'
SELECT SUM(total_bayar) AS total_pendapatan_lunas 
FROM tb_transaksi_obat 
WHERE status_transaksi = 'LUNAS';

-- =========================================================
-- B. GROUP BY (Pengelompokan Data)
-- =========================================================

-- 4. Menghitung jumlah obat dan total aset per golongan obat
SELECT id_golongan, 
       COUNT(*) AS jumlah_obat, 
       SUM(harga_jual * stok) AS total_aset
FROM tb_obat
GROUP BY id_golongan;

-- 5. Menghitung total stok yang dipasok oleh masing-masing PBF
SELECT id_pemasok, SUM(stok) AS total_stok_dipasok
FROM tb_obat
GROUP BY id_pemasok;

-- =========================================================
-- C. HAVING (Filter untuk Hasil Agregasi)
-- =========================================================

-- 6. Menampilkan golongan yang total asetnya di atas Rp 1.000.000
SELECT id_golongan, SUM(harga_jual * stok) AS total_aset
FROM tb_obat
GROUP BY id_golongan
HAVING total_aset > 1000000;

-- 7. Menampilkan pasien yang total belanjanya (LUNAS) lebih dari Rp 20.000
SELECT id_pasien, SUM(total_bayar) AS total_belanja
FROM tb_transaksi_obat
WHERE status_transaksi = 'LUNAS'
GROUP BY id_pasien
HAVING total_belanja > 20000;

-- =========================================================
-- D. DISTINCT (Menghilangkan Duplikasi)
-- =========================================================

-- 8. Menampilkan daftar kota asal PBF yang unik (tanpa duplikat)
SELECT DISTINCT kota_asal FROM tb_pemasok_pbf;

-- 9. Menampilkan status transaksi yang ada di database (unik)
SELECT DISTINCT status_transaksi FROM tb_transaksi_obat;

-- =========================================================
-- E. KOMBINASI LENGKAP (WHERE + GROUP BY + HAVING + ORDER BY)
-- =========================================================

-- 10. Total aset per golongan, HANYA untuk obat berstok > 50, 
--     dan asetnya > 500.000, diurutkan dari terbesar
SELECT id_golongan, 
       COUNT(*) AS jumlah_obat,
       SUM(harga_jual * stok) AS total_aset
FROM tb_obat
WHERE stok > 50
GROUP BY id_golongan
HAVING total_aset > 500000
ORDER BY total_aset DESC;