--@block COMMENT Procedure for total return
DELIMITER $$
CREATE PROCEDURE getTotalReturn(IN u_id BIGINT)
BEGIN
	SELECT 
		SUM((inv_in.quantity)*(investment.current_price - invests_in.entry_price))
	FROM user AS u
  INNER JOIN invests_in AS inv_in ON u.user_id = inv_in.user_id
  INNER JOIN invests_in AS inv_in ON u.user_id = inv_in.user_id
  WHERE u.user_id = u_id;   
END$$
DELIMITER ;
