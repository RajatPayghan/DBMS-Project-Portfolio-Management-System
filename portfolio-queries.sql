
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
  id VARCHAR(10) NOT NULL,
  name VARCHAR(45) NOT NULL,
  type ENUM ('Equity','Currency','Commodity','Mutual Funds'),
  current_price DOUBLE(10,2) NOT NULL,
  total_return DOUBLE (5,2),
  annualized_return DOUBLE (5,2),
  risk_level DOUBLE (5,2),
  PRIMARY KEY  (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
*/

/*
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
*/

/*
CREATE TABLE financial_info( -- Running
  date_of_data TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  interest DOUBLE(5,2),
  inflation DOUBLE(5,2),
  gdp DOUBLE(5,2),
  PRIMARY KEY (date_of_data) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
*/

-- Query 5
INSERT INTO investment VALUES ('INFY','Infosys Pvt Ltd','Equity',1244.76,-3.02,-20.44,-0.16);
INSERT INTO invests_in VALUES (1,'INFY',30,200,'2023-04-10 02:22:49',20);

-- To check : select * from invests_in where symbol='INFY';

-- Query 6
UPDATE invests_in
  SET quantity = 50 
  WHERE symbol = 'INFY' AND user_id = '1';

-- Query 7
DELETE FROM investment WHERE symbol = 'INFY';

-- Query 8
SELECT * from viewallinvestments
WHERE user_id = 1;

-- Query 9
SELECT 
  investment.name,
  investment.symbol,
  investment.current_price,
  market_data.on_date,
  market_data.open,
  market_data.close,
  market_data.high,
  market_data.low
FROM investment
INNER JOIN market_data USING(symbol)
WHERE
  symbol = 'bkunp' AND 
  on_date = '2023-04-03 '
;