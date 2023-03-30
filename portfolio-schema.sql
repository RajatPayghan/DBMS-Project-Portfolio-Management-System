DROP SCHEMA IF EXISTS portfolio;
CREATE SCHEMA portfolio;
USE portfolio;


--@block COMMENT Table structure for User
CREATE TABLE user ( -- Running
  user_id SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(45) NOT NULL UNIQUE,
  passwrd VARCHAR(50) NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  phone_number BIGINT UNSIGNED,
  pan_number BIGINT UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--@block COMMENT Table structure for Investment
CREATE TABLE investment ( -- Running
  symbol VARCHAR(10) NOT NULL,
  name VARCHAR(45) NOT NULL,
  type ENUM ('val1','val2'),
  current_price DOUBLE(10,2),
  PRIMARY KEY  (symbol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--@block COMMENT Table Structure for market_data
CREATE TABLE market_data ( -- Running
  symbol VARCHAR(10) NOT NULL,
  on_date TIMESTAMP NOT NULL,
  volume DOUBLE(10,2) NOT NULL,
  open DOUBLE(10,2) NOT NULL,
  close DOUBLE(10,2) NOT NULL,
  high DOUBLE(10,2) NOT NULL,
  low DOUBLE(10,2) NOT NULL,
  vwap DOUBLE(10,2) NOT NULL,
  PRIMARY KEY (symbol,on_date),
  FOREIGN KEY (symbol) 
    REFERENCES investment (symbol)
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--@block COMMENT table for Performance Metrics
CREATE TABLE performance( -- Running
  user_id SMALLINT UNSIGNED,
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

--@block COMMENT Table structure for RELATION invests_in
CREATE TABLE invests_in ( -- Running
  user_id SMALLINT UNSIGNED NOT NULL,
  symbol VARCHAR(10) NOT NULL,
  quantity BIGINT NOT NULL,
  entry_price DOUBLE(10,2),
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

--@block COMMENT Table structure for Financial Info
CREATE TABLE financial_info( -- Running
  year_month 
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;