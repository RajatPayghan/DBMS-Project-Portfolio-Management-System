--@block COMMENT Procedures : 
DELIMITER //
CREATE PROCEDURE viewAllInvestments(IN input_user BIGINT UNSIGNED)
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
  WHERE invests_in.user_id = input_user;
END //
DELIMITER ;