-- Active: 1747977627544@@127.0.0.1@3306@cleaning_db
USE cleaning_db;

DROP TRIGGER IF EXISTS update_dispenser_timestamp;
DELIMITER $$

CREATE TRIGGER update_dispenser_timestamp
BEFORE UPDATE ON dispenser
FOR EACH ROW
BEGIN
    SET NEW.last_update = NOW();
END$$

DELIMITER ;
