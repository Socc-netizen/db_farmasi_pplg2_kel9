-- =========================================================
-- PEKAN 6: STORED PROCEDURE
-- File: 07_stored_procedure.sql
-- Database: db_farmasi_pplg2_kel9_2
-- =========================================================

USE db_farmasi_pplg2_kel9_2;

-- Mengubah delimiter sementara agar bisa menulis blok BEGIN...END
DELIMITER //

-- ---------------------------------------------------------
-- 1. PROCEDURE DENGAN PARAMETER IN & IF-THEN-ELSE
-- ---------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_cek_ketersediaan_stok //

CREATE PROCEDURE sp_cek_ketersediaan_stok(IN p_id_obat VARCHAR(8))
BEGIN
    DECLARE v_stok INT;
    
    -- Ambil stok obat berdasarkan ID yang dimasukkan
    SELECT stok INTO v_stok FROM tb_obat WHERE id_obat = p_id_obat;
    
    -- Logika IF-THEN-ELSE
    IF v_stok IS NULL THEN
        SELECT 'Obat tidak ditemukan di database' AS Status;
    ELSEIF v_stok > 50 THEN
        SELECT CONCAT('Stok Aman. Sisa: ', v_stok, ' unit') AS Status;
    ELSEIF v_stok > 0 THEN
        SELECT CONCAT('Stok Menipis! Segera Restock. Sisa: ', v_stok, ' unit') AS Status;
    ELSE
        SELECT 'Stok Habis!' AS Status;
    END IF;
END //

-- ---------------------------------------------------------
-- 2. PROCEDURE DENGAN PARAMETER OUT
-- ---------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_total_belanja_pasien //

CREATE PROCEDURE sp_total_belanja_pasien(IN p_id_pasien VARCHAR(8), OUT p_total INT)
BEGIN
    SELECT COALESCE(SUM(total_bayar), 0) INTO p_total
    FROM tb_transaksi_obat
    WHERE id_pasien = p_id_pasien AND status_transaksi = 'LUNAS';
END //

-- ---------------------------------------------------------
-- 3. PROCEDURE DENGAN PARAMETER INOUT
-- ---------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_tambah_stok //

CREATE PROCEDURE sp_tambah_stok(IN p_id_obat VARCHAR(8), INOUT p_tambahan INT)
BEGIN
    -- Tambahkan stok
    UPDATE tb_obat SET stok = stok + p_tambahan WHERE id_obat = p_id_obat;
    
    -- Ubah nilai variabel p_tambahan menjadi total stok akhir
    SELECT stok INTO p_tambahan FROM tb_obat WHERE id_obat = p_id_obat;
END //

-- Kembalikan delimiter ke semula
DELIMITER ;