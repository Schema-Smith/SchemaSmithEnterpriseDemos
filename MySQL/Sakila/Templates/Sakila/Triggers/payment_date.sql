DROP TRIGGER IF EXISTS `payment_date`;
DELIMITER //
CREATE TRIGGER `payment_date`
  BEFORE INSERT
  ON `payment` 
  FOR EACH ROW 
BEGIN
SET NEW.payment_date = NOW();
END //
DELIMITER ;