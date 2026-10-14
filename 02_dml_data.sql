-- ============================================================
-- PEKAN 2: DML - INSERT DATA MASTER
-- ============================================================
USE db_farmasi_pplg2_kelX;

-- 1. tb_pengguna (3 akun)
INSERT INTO tb_pengguna VALUES
('USR00001','admin_apotek','$2y$10$hash1','Hendra Yuni Irawan','ADMIN'),
('USR00002','admin_obat','$2y$10$hash2','Budi Santoso','ADMIN_OBAT'),
('USR00003','kasir_apotek','$2y$10$hash3','Siti Aminah','KASIR');

-- 2. tb_golongan_obat (4 golongan)
INSERT INTO tb_golongan_obat VALUES
('GOL00001','Antibiotik'),
('GOL00002','Analgesik'),
('GOL00003','Vitamin'),
('GOL00004','Antasida');

-- 3. tb_pemasok_pbf (4 pemasok)
INSERT INTO tb_pemasok_pbf VALUES
('PBF00001','PT Kimia Farma','Jakarta','0215551001'),
('PBF00002','PT Kalbe Farma','Jakarta','0215551002'),
('PBF00003','PT Sanbe Farma','Bandung','0225551003'),
('PBF00004','PT Dexa Medica','Palembang','0711551004');

-- 4. tb_obat (10 obat, beberapa mengandung 'FORTE')
INSERT INTO tb_obat VALUES
('OBT00001','GOL00001','PBF00001','Amoxicillin 500mg',15000,100),
('OBT00002','GOL00001','PBF00002','Cefadroxil FORTE',25000,80),
('OBT00003','GOL00002','PBF00003','Paracetamol 500mg',5000,200),
('OBT00004','GOL00002','PBF00004','Ibuprofen FORTE 400mg',12000,150),
('OBT00005','GOL00003','PBF00001','Vitamin C 1000mg',8000,120),
('OBT00006','GOL00003','PBF00002','Vitamin B Complex FORTE',18000,90),
('OBT00007','GOL00004','PBF00003','Antasida Doen',6000,110),
('OBT00008','GOL00004','PBF00004','Omeprazole 20mg',20000,70),
('OBT00009','GOL00001','PBF00001','Azithromycin 500mg',35000,60),
('OBT00010','GOL00002','PBF00002','Aspirin 100mg',7000,130);

-- 5. tb_pasien_pembeli (7 pasien)
INSERT INTO tb_pasien_pembeli 
(id_pasien, nama_pasien, jenis_kelamin, alamat, no_telepon, tanggal_daftar) VALUES
('PSN00001','Andi Wijaya','L','Jl. Merdeka No.1 Samarinda','0811111111','2026-10-01'),
('PSN00002','Sari Dewi','P','Jl. Sudirman No.2 Samarinda','0822222222','2026-10-02'),
('PSN00003','Budi Hartono','L','Jl. Ahmad Yani No.3 Samarinda','0833333333','2026-10-03'),
('PSN00004','Maryam Putri','P','Jl. Gajah Mada No.4 Samarinda','0844444444','2026-10-04'),
('PSN00005','Rizky Pratama','L','Jl. Pahlawan No.5 Samarinda','0855555555','2026-10-05'),
('PSN00006','Nina Sari','P','Jl. Diponegoro No.6 Samarinda','0866666666','2026-10-06'),
('PSN00007','Fajar Nugroho','L','Jl. Hayam Wuruk No.7 Samarinda','0877777777','2026-10-07');

-- 6. tb_transaksi_obat (5 transaksi)
INSERT INTO tb_transaksi_obat VALUES
('TRX00001','PSN00001','OBT00001','2026-10-10',2,30000,'SELESAI'),
('TRX00002','PSN00002','OBT00002','2026-10-11',1,25000,'SELESAI'),
('TRX00003','PSN00003','OBT00003','2026-10-12',5,25000,'SELESAI'),
('TRX00004','PSN00004','OBT00004','2026-10-13',3,36000,'SELESAI'),
('TRX00005','PSN00005','OBT00006','2026-10-14',2,36000,'SELESAI');