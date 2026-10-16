-- =========================================================
-- PEKAN 2: DML - INSERT DATA MASTER
-- Database: db_farmasi_pplg2_kel9_2
-- =========================================================

USE db_farmasi_pplg2_kel9_2;

-- ---------------------------------------------------------
-- 1. tb_pengguna (3 akun) — 6 kolom termasuk email
-- ---------------------------------------------------------
INSERT INTO tb_pengguna (id_user, username, email, password, nama_lengkap, role) VALUES
('USR001', 'admin_apotek', 'admin@apotek.com',  'admin123', 'Hendra Yuni Irawan', 'ADMIN'),
('USR002', 'admin_obat',   'gudang@apotek.com', 'obat123',  'Budi Santoso',       'ADMIN_OBAT'),
('USR003', 'kasir_apotek', 'kasir@apotek.com',  'kasir123', 'Siti Aminah',        'KASIR');

-- ---------------------------------------------------------
-- 2. tb_golongan_obat (4 golongan)
-- ---------------------------------------------------------
INSERT INTO tb_golongan_obat (id_golongan, nama_golongan) VALUES
('GOL001', 'Antibiotik'),
('GOL002', 'Analgesik'),
('GOL003', 'Vitamin'),
('GOL004', 'Antasida');

-- ---------------------------------------------------------
-- 3. tb_pemasok_pbf (4 pemasok) — 5 kolom termasuk email
-- ---------------------------------------------------------
INSERT INTO tb_pemasok_pbf (id_pemasok, nama_pemasok, kota_asal, kontak, email) VALUES
('PBF001', 'PT Kimia Farma', 'Jakarta',   '0215551001', 'sales@kimiafarma.co.id'),
('PBF002', 'PT Kalbe Farma', 'Jakarta',   '0215551002', 'order@kalbe.co.id'),
('PBF003', 'PT Sanbe Farma', 'Bandung',   '0225551003', 'cs@sanbe.co.id'),
('PBF004', 'PT Dexa Medica', 'Palembang', '0711551004', 'info@dexa.co.id');

-- ---------------------------------------------------------
-- 4. tb_obat (10 obat) — 8 kolom (nomor_urut + satuan + harga_jual)
-- ---------------------------------------------------------
INSERT INTO tb_obat 
    (nomor_urut, id_obat, id_golongan, id_pemasok, nama_obat, satuan, harga_jual, stok) 
VALUES
(1,  'OBT001', 'GOL001', 'PBF001', 'Amoxicillin 500mg',        'Strip', 15000, 100),
(2,  'OBT002', 'GOL001', 'PBF002', 'Cefadroxil FORTE 500mg',   'Strip', 25000,  80),
(3,  'OBT003', 'GOL002', 'PBF003', 'Paracetamol 500mg',        'Strip',  5000, 200),
(4,  'OBT004', 'GOL002', 'PBF004', 'Ibuprofen FORTE 400mg',    'Strip', 12000, 150),
(5,  'OBT005', 'GOL003', 'PBF001', 'Vitamin C 1000mg',         'Botol',  8000, 120),
(6,  'OBT006', 'GOL003', 'PBF002', 'Vitamin B Complex FORTE',  'Botol', 18000,  90),
(7,  'OBT007', 'GOL004', 'PBF003', 'Antasida Doen',            'Strip',  6000, 110),
(8,  'OBT008', 'GOL004', 'PBF004', 'Omeprazole 20mg',          'Strip', 20000,  70),
(9,  'OBT009', 'GOL001', 'PBF001', 'Azithromycin 500mg',       'Strip', 35000,  60),
(10, 'OBT010', 'GOL002', 'PBF002', 'Aspirin 100mg',            'Strip',  7000, 130);

-- ---------------------------------------------------------
-- 5. tb_pasien_pembeli (7 pasien) — 7 kolom (email + no_telp)
-- ---------------------------------------------------------
INSERT INTO tb_pasien_pembeli 
    (id_pasien, nama_pasien, jenis_kelamin, alamat, email, no_telp, tanggal_daftar) 
VALUES
('PSN001', 'Andi Wijaya',     'L', 'Jl. Merdeka No.1 Samarinda',   'andi@mail.com',   '0811111111', '2026-10-01'),
('PSN002', 'Sari Dewi',       'P', 'Jl. Sudirman No.2 Samarinda',  'sari@mail.com',   '0822222222', '2026-10-02'),
('PSN003', 'Budi Hartono',    'L', 'Jl. Diponegoro No.5 Balikpapan','budi@mail.com',   '0833333333', '2026-10-03'),
('PSN004', 'Maryam Salsabila','P', 'Jl. Gajah Mada No.8 Samarinda', 'maryam@mail.com', '0844444444', '2026-10-04'),
('PSN005', 'Rizky Pratama',   'L', 'Jl. Pahlawan No.12 Bontang',   'rizky@mail.com',  '0855555555', '2026-10-05'),
('PSN006', 'Lina Marlina',    'P', 'Jl. Ahmad Yani No.3 Samarinda', 'lina@mail.com',   '0866666666', '2026-10-06'),
('PSN007', 'Doni Setiawan',   'L', 'Jl. Cendrawasih No.7 Samarinda','doni@mail.com',   '0877777777', '2026-10-07');

-- ---------------------------------------------------------
-- 6. tb_transaksi_obat (5 transaksi)
-- ---------------------------------------------------------
INSERT INTO tb_transaksi_obat 
    (id_transaksi, id_pasien, id_obat, tanggal_transaksi, jumlah_beli, total_bayar, status_transaksi) 
VALUES
('TRX001', 'PSN001', 'OBT001', '2026-10-12', 2, 30000,  'LUNAS'),
('TRX002', 'PSN002', 'OBT003', '2026-10-13', 5, 25000,  'LUNAS'),
('TRX003', 'PSN003', 'OBT005', '2026-10-14', 1, 8000,   'LUNAS'),
('TRX004', 'PSN004', 'OBT009', '2026-10-15', 3, 105000, 'LUNAS'),
('TRX005', 'PSN005', 'OBT008', '2026-10-16', 2, 40000,  'PENDING');

-- ---------------------------------------------------------
-- 7. VERIFIKASI DATA
-- ---------------------------------------------------------
SELECT 'tb_pengguna' AS tabel, COUNT(*) AS jumlah FROM tb_pengguna
UNION ALL SELECT 'tb_golongan_obat',  COUNT(*) FROM tb_golongan_obat
UNION ALL SELECT 'tb_pemasok_pbf',    COUNT(*) FROM tb_pemasok_pbf
UNION ALL SELECT 'tb_obat',           COUNT(*) FROM tb_obat
UNION ALL SELECT 'tb_pasien_pembeli', COUNT(*) FROM tb_pasien_pembeli
UNION ALL SELECT 'tb_transaksi_obat', COUNT(*) FROM tb_transaksi_obat;