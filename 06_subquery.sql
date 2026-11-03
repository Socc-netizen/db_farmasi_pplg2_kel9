-- =========================================================
-- PEKAN 5: SUBQUERY (Kueri Bersarang)
-- File: 06_subquery.sql
-- Database: db_farmasi_pplg2_kel9_2
-- =========================================================

USE db_farmasi_pplg2_kel9_2;

-- =========================================================
-- A. SCALAR SUBQUERY (Menghasilkan 1 Nilai)
-- =========================================================

-- 1. Mencari obat yang harganya DI ATAS rata-rata harga semua obat
SELECT id_obat, nama_obat, harga_jual
FROM tb_obat
WHERE harga_jual > (SELECT AVG(harga_jual) FROM tb_obat);

-- 2. Mencari transaksi yang total bayarnya LEBIH BESAR dari transaksi tertentu (TRX001)
SELECT id_transaksi, id_pasien, total_bayar
FROM tb_transaksi_obat
WHERE total_bayar > (SELECT total_bayar FROM tb_transaksi_obat WHERE id_transaksi = 'TRX001');

-- =========================================================
-- B. MULTIPLE-ROW SUBQUERY (Menghasilkan Banyak Nilai - pakai IN / NOT IN)
-- =========================================================

-- 3. Mencari pasien yang PERNAH melakukan transaksi (pakai IN)
SELECT id_pasien, nama_pasien 
FROM tb_pasien_pembeli
WHERE id_pasien IN (SELECT id_pasien FROM tb_transaksi_obat);

-- 4. Mencari pasien yang BELUM PERNAH melakukan transaksi (pakai NOT IN)
SELECT id_pasien, nama_pasien 
FROM tb_pasien_pembeli
WHERE id_pasien NOT IN (SELECT id_pasien FROM tb_transaksi_obat);

-- =========================================================
-- C. SUBQUERY KOMPARASI (ANY / ALL)
-- =========================================================

-- 5. Mencari obat yang harganya lebih mahal dari ANY (salah satu) obat golongan GOL002
--    (Artinya: lebih mahal dari obat termurah di GOL002)
SELECT nama_obat, harga_jual, id_golongan
FROM tb_obat
WHERE id_golongan != 'GOL002' 
  AND harga_jual > ANY (SELECT harga_jual FROM tb_obat WHERE id_golongan = 'GOL002');

-- 6. Mencari obat yang harganya lebih mahal dari ALL (semua) obat golongan GOL002
--    (Artinya: lebih mahal dari obat termahal di GOL002)
SELECT nama_obat, harga_jual, id_golongan
FROM tb_obat
WHERE harga_jual > ALL (SELECT harga_jual FROM tb_obat WHERE id_golongan = 'GOL002');

-- =========================================================
-- D. CORRELATED SUBQUERY (EXISTS / NOT EXISTS)
-- =========================================================

-- 7. Mencari golongan obat yang PUNYA setidaknya 1 obat terdaftar (pakai EXISTS)
SELECT g.id_golongan, g.nama_golongan
FROM tb_golongan_obat g
WHERE EXISTS (
    SELECT 1 FROM tb_obat o 
    WHERE o.id_golongan = g.id_golongan
);

-- 8. Mencari golongan obat yang TIDAK PUNYA obat sama sekali (pakai NOT EXISTS)
--    (Cocok untuk cek golongan baru yang masih kosong)
SELECT g.id_golongan, g.nama_golongan
FROM tb_golongan_obat g
WHERE NOT EXISTS (
    SELECT 1 FROM tb_obat o 
    WHERE o.id_golongan = g.id_golongan
);