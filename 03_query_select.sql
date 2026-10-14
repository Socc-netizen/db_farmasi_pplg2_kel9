-- ============================================================
-- PEKAN 2: QUERY SELECT - Pattern Matching & Filter
-- ============================================================
USE db_farmasi_pplg2_kelX;

-- 1. LIKE: cari obat dengan nama mengandung 'FORTE'
SELECT id_obat, nama_obat, harga_jual, stok
FROM tb_obat
WHERE nama_obat LIKE '%FORTE%';

-- 2. NOT LIKE: obat yang tidak mengandung 'FORTE'
SELECT id_obat, nama_obat
FROM tb_obat
WHERE nama_obat NOT LIKE '%FORTE%';

-- 3. LIKE dengan wildcard awal: nama diawali 'Vita'
SELECT * FROM tb_obat WHERE nama_obat LIKE 'Vita%';

-- 4. BETWEEN: obat dengan harga 10000 - 25000
SELECT id_obat, nama_obat, harga_jual
FROM tb_obat
WHERE harga_jual BETWEEN 10000 AND 25000;

-- 5. BETWEEN tanggal: transaksi Oktober 2026
SELECT * FROM tb_transaksi_obat
WHERE tanggal_transaksi BETWEEN '2026-10-01' AND '2026-10-31';

-- 6. ORDER BY ASC: obat termurah
SELECT nama_obat, harga_jual FROM tb_obat ORDER BY harga_jual ASC;

-- 7. ORDER BY DESC: obat termahal
SELECT nama_obat, harga_jual FROM tb_obat ORDER BY harga_jual DESC;

-- 8. Kombinasi LIKE + ORDER BY
SELECT nama_obat, stok FROM tb_obat
WHERE nama_obat LIKE '%FORTE%'
ORDER BY stok DESC;

-- 9. UPDATE bersyarat: naikkan harga obat FORTE 10%
UPDATE tb_obat SET harga_jual = harga_jual * 1.10
WHERE nama_obat LIKE '%FORTE%';

-- 10. DELETE bersyarat: hapus transaksi batal
DELETE FROM tb_transaksi_obat WHERE status_transaksi = 'BATAL';

-- 11. Verifikasi
SELECT * FROM tb_obat;