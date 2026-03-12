DROP TRIGGER IF EXISTS `customer_create_date`;
DELIMITER //
CREATE TRIGGER `customer_create_date`
  BEFORE INSERT
  ON `customer` 
  FOR EACH ROW 
BEGIN
SET NEW.create_date = NOW();
END //
DELIMITER ;