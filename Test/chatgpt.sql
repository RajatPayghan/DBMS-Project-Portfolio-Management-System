DROP SCHEMA IF EXISTS investments_db;
CREATE DATABASE investments_db;
USE investments_db;

CREATE TABLE investments (
  id INT PRIMARY KEY,
  name VARCHAR(255) UNIQUE,
  type VARCHAR(255),
  shares_held INT
);

CREATE TABLE performance_metrics (
  id INT,
  total_return FLOAT,
  annualized_return FLOAT,
  risk_level FLOAT,
  FOREIGN KEY (id) REFERENCES investments(id)
);

CREATE TABLE market_data (
  id INT,
  date DATE,
  price FLOAT,
  FOREIGN KEY (id) REFERENCES investments(id)
);

CREATE TABLE other_financial_information (
  date DATE UNIQUE,
  interest_rates FLOAT,
  inflation_rates FLOAT,
  gdp_growth_rates FLOAT
);

INSERT INTO investments (investment_id, name, type, shares_held) VALUES (1, 'ABC', 'Stocks', 1000);

UPDATE investments SET shares_held = 2000 WHERE investment_id = 1;

DELETE FROM investments WHERE investment_id = 1;

SELECT investments.name, performance_metrics.total_return FROM investments JOIN performance_metrics ON investments.id = performance_metrics.id;

--@block
SELECT market_data.price FROM investments INNER JOIN market_data ON investments.name = 'nihil' AND market_data.date = '2023-04-04';

--@block
SELECT investments.type, AVG(performance_metrics.annualized_return) FROM investments JOIN performance_metrics ON investments.investment_id = performance_metrics.investment_id GROUP BY investments.type;

SELECT investments.name, performance_metrics.total_return FROM investments JOIN performance_metrics ON investments.investment_id = performance_metrics.investment_id WHERE performance_metrics.risk_level = 'High' ORDER BY performance_metrics.total_return DESC;

SELECT SUM(investments.shares_held * market_data.stock_prices) AS total_value FROM investments JOIN market_data ON investments.name = 'ABC' AND market_data.date = '2023-04-06';

SELECT SUM(investments.shares_held * performance_metrics.annualized_return) / SUM(investments.shares_held) AS portfolio_annualized_return FROM investments JOIN performance_metrics ON investments.investment_id = performance_metrics.investment_id;

SELECT CORR(pm1.total_return, pm2.total_return) AS correlation FROM performance_metrics pm1 JOIN performance_metrics pm2 ON pm1.investment_id = 1 AND pm2.investment_id = 2;

SELECT inflation_rates FROM other_financial_information ORDER BY date DESC LIMIT 1;

SELECT market_data.stock_prices FROM investments JOIN market_data ON investments.name = 'ABC' AND market_data.date BETWEEN '2023-04-01' AND '2023-04-06';

SELECT (MAX(market_data.stock_prices) - MIN(market_data.stock_prices)) / MIN(market_data.stock_prices) * 100 AS percentage_change FROM investments JOIN market_data ON investments.name = 'ABC' AND market_data.date BETWEEN '2023-04-01' AND '2023-04-06';

SELECT SQRT(AVG(performance_metrics.total_return - (SUM(performance_metrics.total_return) / COUNT(*))) ^ 2) AS volatility FROM investments JOIN performance_metrics ON investments.investment_id = performance_metrics.investment_id WHERE investments.name = 'ABC';

SELECT investments.name, performance_metrics.annualized_return, performance_metrics.risk_level FROM investments JOIN performance_metrics ON investments.investment_id = performance_metrics.investment_id ORDER BY performance_metrics.annualized_return DESC, performance_metrics.risk_level ASC;

SELECT investments.type, SUM(investments.shares_held) AS total_shares_held FROM investments GROUP BY investments.type;


--@block
