DROP SCHEMA IF EXISTS portfolio;
CREATE SCHEMA portfolio;
USE portfolio;



CREATE TABLE user ( -- Running
  user_id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(45) NOT NULL UNIQUE,
  passwrd VARCHAR(50) NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45),
  phone_number BIGINT UNSIGNED,
  pan_number VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE investment ( -- Running
  symbol VARCHAR(10) NOT NULL,
  name VARCHAR(45) NOT NULL,
  type ENUM ('Equity','Currency Futures','Commodity Futures','Mutual Funds'),
  current_price DOUBLE(10,2) NOT NULL,
  PRIMARY KEY  (symbol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


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


CREATE TABLE investment_performance( -- Running
  symbol VARCHAR(10) NOT NULL,
  beta DOUBLE(5,2) DEFAULT 0,
  total_return DOUBLE(10,2) DEFAULT 0,
  annual_return DOUBLE(10,2) DEFAULT 0,
  risk ENUM ('Low Risk','High Risk','Middle Risk'), ,
  PRIMARY KEY (symbol),
  FOREIGN KEY (symbol) 
    REFERENCES investment(symbol)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE portfolio_performance( -- Running
  user_id BIGINT UNSIGNED,
  beta DOUBLE(5,2) DEFAULT 0,
  total_return DOUBLE(10,2) DEFAULT 0,
  annual_return DOUBLE(10,2) DEFAULT 0,
  risk DOUBLE(10,2),
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) 
    REFERENCES user(user_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE financial_info( -- Running
  date_of_data TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  interest DOUBLE(5,2),
  inflation DOUBLE(5,2),
  gdp DOUBLE(5,2),
  PRIMARY KEY (date_of_data) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
