DROP SCHEMA IF EXISTS portfolio;
CREATE SCHEMA portfolio;
USE portfolio;


--@block COMMENT Table structure for User
CREATE TABLE user ( -- Verified
  user_id SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(45) NOT NULL UNIQUE,
  passwrd VARCHAR(50) NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  phone_number BIGINT UNSIGNED,
  pan_number BIGINT UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--@block COMMENT Table structure for Investment
CREATE TABLE investment ( -- Verified
  symbol VARCHAR(10) NOT NULL,
  name VARCHAR(45) NOT NULL,
  type ENUM ('val1','val2'),
  current_price DOUBLE(10,2),
  PRIMARY KEY  (symbol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--@block COMMENT Table Structure for market_data
CREATE TABLE market_data ( -- Verified
  symbol VARCHAR(10) NOT NULL,
  on_date TIMESTAMP NOT NULL,
  volume DOUBLE(10,2) NOT NULL,
  open DOUBLE(10,2) NOT NULL,
  close DOUBLE(10,2) NOT NULL,
  high DOUBLE(10,2) NOT NULL,
  low DOUBLE(10,2) NOT NULL,
  vwap DOUBLE(10,2) NOT NULL,
  PRIMARY KEY (symbol,on_date),
  CONSTRAINT imd_user_md_symbol
    FOREIGN KEY (symbol) 
    REFERENCES investment (symbol)
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--@block COMMENT table for Performance Metrics


--@block COMMENT Table structure for RELATION invests_in
CREATE TABLE invests_in ( -- Not Done
  user_id SMALLINT UNSIGNED NOT NULL,
  symbol VARCHAR(10) NOT NULL,
  quantity BIGINT NOT NULL,
  entry_price DOUBLE(10,2),
  entry_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  percent_weight DOUBLE(5,2) NOT NULL, -- Check this one out, has a function
  ----------------------------
  PRIMARY KEY  (user_id,symbol),
  CONSTRAINT ui_user_investment_user 
    FOREIGN KEY (user_id) 
    REFERENCES user (user_id) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE,
  CONSTRAINT ui_user_investment_invest 
    FOREIGN KEY (symbol) 
    REFERENCES investment (symbol) 
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;