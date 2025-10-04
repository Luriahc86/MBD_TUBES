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
