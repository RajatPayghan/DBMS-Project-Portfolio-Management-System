DELIMITER //
  DROP TRIGGER IF EXISTS addPerformanceReport;
  CREATE TRIGGER addPerformanceReport
  AFTER INSERT ON user FOR EACH ROW
  BEGIN 
    CALL addPerformance(NEW.user_id);
  END //
DELIMITER ;

DELIMITER //
  DROP TRIGGER IF EXISTS updateTotalRevenue;
  CREATE TRIGGER updateTotalRevenue
  AFTER UPDATE ON investment FOR EACH ROW
  BEGIN 
    DECLARE cursor_ID BIGINT;
    DECLARE var_total_return DOUBLE(10,2);
    DECLARE done INT DEFAULT FALSE;
    DECLARE cursor_i CURSOR FOR SELECT user_id FROM portfolio_returns;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cursor_i;
    read_loop: LOOP
      FETCH cursor_i INTO cursor_ID;
      IF done THEN
        LEAVE read_loop;
      END IF;
      UPDATE portfolio_returns SET total_return = totalReturn(cursor_ID) WHERE user_id = cursor_ID;
    END LOOP;
    CLOSE cursor_i;
  END //
DELIMITER ;

DELIMITER //
  DROP TRIGGER IF EXISTS chk_risk;
  CREATE TRIGGER chk_risk
  BEFORE INSERT ON investment FOR EACH ROW
  BEGIN 
    IF NEW.risk_level < 0 THEN
      SET NEW.risk_level = -(NEW.risk_level) ;
    END IF;
  END //
DELIMITER ;