-- =========================================================
-- PEKAN 7: TRIGGER & AUDIT TRAIL
-- File: 08_triggers.sql
-- Database: db_farmasi_pplg2_kel9_2
-- =========================================================

USE db_farmasi_pplg2_kel9_2;

DELIMITER //

-- ---------------------------------------------------------
-- 1. TRIGGER DISKON RESEP (BEFORE INSERT)
--    Jika beli >= 50, otomatis dapat diskon 10%
-- ---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_diskon_resep //

CREATE TRIGGER trg_diskon_resep
BEFORE INSERT ON tb_transaksi_obat
FOR EACH ROW
BEGIN
    IF NEW.jumlah_beli >= 50 THEN
        SET NEW.total_bayar = NEW.total_bayar * 0.90; -- Diskon 10%
    END IF;
END //

-- ---------------------------------------------------------
-- 2. TRIGGER POTONG STOK (AFTER INSERT) & LOGGING
--    Stok otomatis berkurang saat ada transaksi baru
-- ---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_potong_stok //

CREATE TRIGGER trg_potong_stok
AFTER INSERT ON tb_transaksi_obat
FOR EACH ROW
BEGIN
    -- Potong stok obat
    UPDATE tb_obat 
    SET stok = stok - NEW.jumlah_beli 
    WHERE id_obat = NEW.id_obat;
    
    -- Catat ke audit log
    INSERT INTO tb_log_farmasi (nama_operasi, rincian, waktu_eksekusi)
    VALUES ('INSERT_TRANSAKSI', 
            CONCAT('Transaksi ', NEW.id_transaksi, ' memotong stok obat ', NEW.id_obat, ' sebanyak ', NEW.jumlah_beli, ' unit'), 
            NOW());
END //

-- ---------------------------------------------------------
-- 3. TRIGGER PEMULIHAN STOK (AFTER DELETE) & LOGGING
--    Stok otomatis kembali jika transaksi dibatalkan/dihapus
-- ---------------------------------------------------------
DROP TRIGGER IF EXISTS trg_pemulihan_stok //

CREATE TRIGGER trg_pemulihan_stok
AFTER DELETE ON tb_transaksi_obat
FOR EACH ROW
BEGIN
    -- Kembalikan stok obat
    UPDATE tb_obat 
    SET stok = stok + OLD.jumlah_beli 
    WHERE id_obat = OLD.id_obat;
    
    -- Catat ke audit log
    INSERT INTO tb_log_farmasi (nama_operasi, rincian, waktu_eksekusi)
    VALUES ('DELETE_TRANSAKSI', 
            CONCAT('Transaksi ', OLD.id_transaksi, ' dibatalkan. Stok obat ', OLD.id_obat, ' dikembalikan sebanyak ', OLD.jumlah_beli, ' unit'), 
            NOW());
END //

DELIMITER ;