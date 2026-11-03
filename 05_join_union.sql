-- =========================================================
-- PEKAN 4: RELASI MULTI-TABEL (JOIN & UNION)
-- File: 05_join_union.sql
-- Database: db_farmasi_pplg2_kel9_2
-- =========================================================

USE db_farmasi_pplg2_kel9_2;

-- =========================================================
-- A. INNER JOIN (Menggabungkan Data yang Berelasi)
-- =========================================================

-- 1. Menampilkan nama obat beserta nama golongannya (Eksplisit ON)
SELECT o.id_obat, o.nama_obat, g.nama_golongan
FROM tb_obat o
INNER JOIN tb_golongan_obat g ON o.id_golongan = g.id_golongan;

-- 2. Menampilkan nama obat beserta nama PBF pemasoknya
SELECT o.nama_obat, p.nama_pemasok, p.kota_asal
FROM tb_obat o
INNER JOIN tb_pemasok_pbf p ON o.id_pemasok = p.id_pemasok;

-- 3. Menampilkan detail transaksi (Nama Pasien, Nama Obat, Total Bayar)
--    (Menggabungkan 3 tabel sekaligus!)
SELECT t.id_transaksi, ps.nama_pasien, o.nama_obat, t.jumlah_beli, t.total_bayar
FROM tb_transaksi_obat t
INNER JOIN tb_pasien_pembeli ps ON t.id_pasien = ps.id_pasien
INNER JOIN tb_obat o ON t.id_obat = o.id_obat;

-- 4. INNER JOIN versi implisit (Menggunakan WHERE, bukan ON)
SELECT o.nama_obat, g.nama_golongan
FROM tb_obat o, tb_golongan_obat g
WHERE o.id_golongan = g.id_golongan;

-- =========================================================
-- B. OUTER JOIN (Mencari Data yang Tidak Berelasi)
-- =========================================================

-- 5. LEFT JOIN: Mencari obat yang BELUM PERNAH terjual (tidak ada di tabel transaksi)
SELECT o.id_obat, o.nama_obat
FROM tb_obat o
LEFT JOIN tb_transaksi_obat t ON o.id_obat = t.id_obat
WHERE t.id_transaksi IS NULL;

-- 6. RIGHT JOIN: Menampilkan semua pasien, termasuk yang belum pernah bertransaksi
SELECT ps.id_pasien, ps.nama_pasien, t.id_transaksi, t.total_bayar
FROM tb_transaksi_obat t
RIGHT JOIN tb_pasien_pembeli ps ON t.id_pasien = ps.id_pasien;

-- =========================================================
-- C. UNION & UNION ALL (Menggabungkan Baris Data)
-- =========================================================

-- 7. UNION: Menggabungkan nama Pasien dan nama Pemasok menjadi 1 kolom 
--    (Menghilangkan duplikat jika ada nama yang sama)
SELECT nama_pasien AS daftar_nama FROM tb_pasien_pembeli
UNION
SELECT nama_pemasok AS daftar_nama FROM tb_pemasok_pbf;

-- 8. UNION ALL: Sama seperti UNION, tapi MEMPERTAHANKAN duplikat
--    (Menampilkan semua baris dari kedua tabel tanpa disaring)
SELECT nama_pasien AS daftar_nama, 'Pasien' AS asal_data FROM tb_pasien_pembeli
UNION ALL
SELECT nama_pemasok AS daftar_nama, 'Pemasok' AS asal_data FROM tb_pemasok_pbf;
