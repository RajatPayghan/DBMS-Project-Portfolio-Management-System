DROP SCHEMA IF EXISTS portfolio;
CREATE SCHEMA portfolio;
USE portfolio;

--
-- Table structure for table `user`
--

CREATE TABLE user (
  user_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  email VARCHAR(45) NOT NULL,
  passwrd VARCHAR(50) NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  phone_number BIGINT UNSIGNED,
  pan_number BIGINT UNSIGNED,
  PRIMARY KEY  (user_id),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



--
-- Table structure for table `invests_in`
--

CREATE TABLE invests_in (
  user_id SMALLINT UNSIGNED NOT NULL,
  symbol VARCHAR(10) NOT NULL,
  quantity BIGINT NOT NULL,
  entry_price DOUBLE(10,2),
  PRIMARY KEY  (user_id,symbol),
  CONSTRAINT ui_user_investment_user FOREIGN KEY (user_id) REFERENCES user (user_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ui_user_investment_invest FOREIGN KEY (symbol) REFERENCES investment (symbol) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;