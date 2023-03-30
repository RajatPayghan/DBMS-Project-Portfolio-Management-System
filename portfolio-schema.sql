DROP SCHEMA IF EXISTS portfolio;
CREATE SCHEMA portfolio;
USE portfolio;

--
-- Table structure for table `user`
--

CREATE TABLE user ( -- Done
  user_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  email VARCHAR(45) NOT NULL UNIQUE,
  passwrd VARCHAR(50) NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  phone_number BIGINT UNSIGNED,
  pan_number BIGINT UNSIGNED NOT NULL,
  --------------------------
  PRIMARY KEY  (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `investment`
--

CREATE TABLE investment ( --Done
  symbol VARCHAR(10) NOT NULL,
  name VARCHAR(45) NOT NULL,
  type ENUM ('value1','value2','value3'),
  current_price DOUBLE(10,2),
  ----------------------------
  PRIMARY KEY  (symbol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Table structure for table `market_data`
--

CREATE TABLE market_data ( -- Not Done
  symbol VARCHAR(10) NOT NULL,
  on_date TIMESTAMP NOT NULL,
  volume DOUBLE(10,2) NOT NULL,
  open DOUBLE(10,2) NOT NULL,
  close DOUBLE(10,2) NOT NULL,
  high DOUBLE(10,2) NOT NULL,
  low DOUBLE(10,2) NOT NULL,
  vwap DOUBLE(10,2) NOT NULL,
  ----------------------------
  PRIMARY KEY (symbol,on_date),
  CONSTRAINT imd_user_md_symbol
    FOREIGN KEY (symbol) 
    REFERENCES investment (symbol)
    ON DELETE RESTRICT 
    ON UPDATE CASCADE,
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `invests_in`
--

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