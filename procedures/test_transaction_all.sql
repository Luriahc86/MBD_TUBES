USE cleaning_db;

DROP PROCEDURE IF EXISTS test_transaction_all;
DELIMITER $$

CREATE PROCEDURE test_transaction_all()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SELECT 'Error terjadi, transaksi dibatalkan (Failure & Recovery)' AS info;
    END;

    -- TRANSACTION
    START TRANSACTION;
        INSERT INTO laporan_penggantian (id_pegawai, id_dispenser, jumlah_tisu)
        VALUES (2, 4, 88);
        UPDATE dispenser 
        SET status = 'AKTIF' 
        WHERE id_dispenser = 4;
    COMMIT;
    SELECT 'Transaction sukses (Commit)' AS info;

    -- FAILURE AND RECOVERY
    START TRANSACTION;
        INSERT INTO laporan_penggantian (id_pegawai, id_dispenser, jumlah_tisu)
        VALUES (3, 5, 77);
        -- Simulasi error
        INSERT INTO laporan_penggantian (id_pegawai, id_dispenser, jumlah_tisu)
        VALUES (999, 1, 55);
    COMMIT;
    SELECT 'Baris ini tidak akan dieksekusi jika terjadi error' AS info;

    -- CONCURRENCY CONTROL (LOCKING)
    START TRANSACTION;
        SELECT * FROM dispenser WHERE id_dispenser = 2 FOR UPDATE;
        UPDATE dispenser 
        SET status = 'RUSAK' 
        WHERE id_dispenser = 2;
    COMMIT;
    SELECT 'Locking berhasil dijalankan' AS info;
    
DELIMITER ;
