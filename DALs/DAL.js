const mysql = require('mysql');

const dbConnection = mysql.createConnection({
  host: 'localhost',
  user: 'username',
  password: 'password',
  database: 'portfolio_management'
});

// Connect to the database
dbConnection.connect((err) => {
  if (err) {
    console.error('Error connecting to database: ', err);
    return;
  }
  console.log('Connected to database');
});

// Function to retrieve a list of investments
function getInvestments(callback) {
  const query = 'SELECT * FROM investments';
  dbConnection.query(query, (err, results) => {
    if (err) {
      console.error('Error retrieving investments: ', err);
      return callback(err);
    }
    callback(null, results);
  });
}

// Function to add a new investment
function addInvestment(name, type, sharesHeld, purchasePrice, purchaseDate, callback) {
  const query = 'INSERT INTO investments (name, type, shares_held, purchase_price, purchase_date) VALUES (?, ?, ?, ?, ?)';
  const values = [name, type, sharesHeld, purchasePrice, purchaseDate];
  dbConnection.query(query, values, (err, result) => {
    if (err) {
      console.error('Error adding investment: ', err);
      return callback(err);
    }
    callback(null, result);
  });
}

// Function to update an existing investment
function updateInvestment(investmentId, name, type, sharesHeld, purchasePrice, purchaseDate, callback) {
  const query = 'UPDATE investments SET name = ?, type = ?, shares_held = ?, purchase_price = ?, purchase_date = ? WHERE investment_id = ?';
  const values = [name, type, sharesHeld, purchasePrice, purchaseDate, investmentId];
  dbConnection.query(query, values, (err, result) => {
    if (err) {
      console.error('Error updating investment: ', err);
      return callback(err);
    }
    callback(null, result);
  });
}

// Function to delete an investment
function deleteInvestment(investmentId, callback) {
  const query = 'DELETE FROM investments WHERE investment_id = ?';
  dbConnection.query(query, investmentId, (err, result) => {
    if (err) {
      console.error('Error deleting investment: ', err);
      return callback(err);
    }
    callback(null, result);
  });
}

// Function to generate a portfolio performance report
function generatePortfolioPerformanceReport(portfolioId, callback) {
  // Query the database to retrieve the necessary data
  const query = `
    SELECT 
      i.name, 
      pm.total_return, 
      pm.annualized_return, 
      pm.risk_level
    FROM 
      portfolio_investments pi
      JOIN investments i ON i.investment_id = pi.investment_id
      JOIN performance_metrics pm ON pm.investment_id = i.investment_id
    WHERE
      pi.portfolio_id = ?`;
  const values = [portfolioId];
  dbConnection.query(query, values, (err, results) => {
    if (err) {
      console.error('Error generating portfolio performance report: ', err);
      return callback(err);
    }
    callback(null, results);
  });
}

// Export the functions for use in other modules
module.exports = {
  getInvestments,
  addInvestment,
  updateInvestment,
  deleteInvestment,
  generatePortfolioPerformanceReport
};
