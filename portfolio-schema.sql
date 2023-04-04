DROP SCHEMA IF EXISTS portfolio;
CREATE SCHEMA portfolio;
USE portfolio;


--@block COMMENT Table structure for User
CREATE TABLE user ( -- Running
  user_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(45) NOT NULL UNIQUE,
  passwrd VARCHAR(50) NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45),
  phone_number BIGINT UNSIGNED,
  pan_number VARCHAR(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--@block COMMENT Table structure for Investment
CREATE TABLE investment ( -- Running
  symbol VARCHAR(10) NOT NULL,
  name VARCHAR(45) NOT NULL,
  type ENUM ('Equity','Currency Futures','Commodity Futures'),
  current_price DOUBLE(10,2) NOT NULL,
  PRIMARY KEY  (symbol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--@block COMMENT Table structure for RELATION invests_in
CREATE TABLE invests_in ( -- Running
  user_id BIGINT UNSIGNED NOT NULL,
  symbol VARCHAR(10) NOT NULL,
  quantity BIGINT NOT NULL,
  entry_price DOUBLE(10,2) NOT NULL,
  entry_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  percent_weight DOUBLE(5,2) NOT NULL,
  PRIMARY KEY  (user_id,symbol),
  FOREIGN KEY (user_id) 
    REFERENCES user (user_id) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE,
  FOREIGN KEY (symbol) 
    REFERENCES investment (symbol) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--@block COMMENT Table Structure for market_data
CREATE TABLE market_data ( -- Running
  symbol VARCHAR(10) NOT NULL,
  on_date TIMESTAMP NOT NULL,
  volume DOUBLE(10,2),
  open DOUBLE(10,2),
  close DOUBLE(10,2) NOT NULL,
  high DOUBLE(10,2),
  low DOUBLE(10,2),
  vwap DOUBLE(10,2),
  PRIMARY KEY (symbol,on_date),
  FOREIGN KEY (symbol) 
    REFERENCES investment (symbol)
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--@block COMMENT table for Performance Metrics
CREATE TABLE performance( -- Running
  user_id BIGINT UNSIGNED,
  beta DOUBLE(5,2),
  total_return DOUBLE(10,2) DEFAULT 0,
  annual_return DOUBLE(10,2) DEFAULT 0,
  risk DOUBLE(10,2),
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) 
    REFERENCES user(user_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--@block COMMENT Table structure for Financial Info
CREATE TABLE financial_info( -- Running
  date_of_data TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  interest DOUBLE(5,2),
  inflation DOUBLE(5,2),
  gdp DOUBLE(5,2),
  PRIMARY KEY (date_of_data) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


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