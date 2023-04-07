
/* Queries asked */

/* This table is already Created
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
*/

/*
CREATE TABLE investment ( -- Running
  symbol VARCHAR(10) NOT NULL,
  name VARCHAR(45) NOT NULL,
  type ENUM ('Equity','Currency Futures','Commodity Futures','Mutual Funds'),
  current_price DOUBLE(10,2) NOT NULL,
  PRIMARY KEY  (symbol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
*/

/*
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
*/



