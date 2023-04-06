use portfolio;

DELIMITER //
DROP PROCEDURE IF EXISTS addUser;
CREATE PROCEDURE addUser(
                          IN in_email VARCHAR(45),
                          IN in_passwrd VARCHAR(50),
                          IN in_first_name VARCHAR(45),
                          IN in_last_name VARCHAR(45),
                          IN in_phone_number BIGINT,
                          IN in_pan_number VARCHAR(10)
                        )
BEGIN
  insert into user(email, passwrd, first_name, last_name, phone_number, pan_number) 
  values (in_email, in_passwrd, in_first_name, in_last_name, in_phone_number, in_pan_number);
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS addPerformance;
CREATE PROCEDURE addPerformance(IN in_user_id BIGINT)
BEGIN
  insert into performance(user_id) 
  values (in_user_id);
END //
DELIMITER ;

DELIMITER //
DROP TRIGGER IF EXISTS addPerformanceReport;
CREATE TRIGGER addPerformanceReport
AFTER INSERT ON user FOR EACH ROW
BEGIN 
  CALL addPerformance(NEW.user_id);
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS viewUserInvestment;
CREATE PROCEDURE viewUserInvestment(IN input_user_id BIGINT UNSIGNED)
BEGIN
  SELECT 
    invests_in.symbol AS Symbol,
    investment.name AS Symbol_Name,
    invests_in.quantity AS Quantity,
    invests_in.entry_price AS Entry_Price,
    investment.current_price AS Current_Price,
    invests_in.quantity*(investment.current_price-invests_in.entry_price) AS Invst_return
  FROM invests_in
  INNER JOIN investment USING (symbol)
  WHERE invests_in.user_id = input_user_id;
END //
DELIMITER ;

DELIMITER //
DROP FUNCTION IF EXISTS totalReturn;
CREATE FUNCTION totalReturn(input_user_id BIGINT UNSIGNED) returns DOUBLE(10,2)
DETERMINISTIC
BEGIN
  DECLARE var_total_return DOUBLE(10,2);
  
  SELECT SUM(invests_in.quantity*(investment.current_price-invests_in.entry_price))
  INTO var_total_return
  FROM invests_in
  INNER JOIN investment USING (symbol)
  WHERE invests_in.user_id = input_user_id;

  RETURN var_total_return;
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
  DECLARE cursor_i CURSOR FOR SELECT user_id FROM performance;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cursor_i;
  read_loop: LOOP
    FETCH cursor_i INTO cursor_ID;
    IF done THEN
      LEAVE read_loop;
    END IF;
    UPDATE performance SET total_return = totalReturn(cursor_ID) WHERE user_id = cursor_ID;
  END LOOP;
  CLOSE cursor_i;
END //
DELIMITER ;

UPDATE investment SET current_price=current_price;

-- Views

DROP VIEW IF EXISTS viewAllReturns;
CREATE VIEW viewAllReturns AS
SELECT 
  user.user_id, user.first_name, totalReturn(user_id)
FROM user;