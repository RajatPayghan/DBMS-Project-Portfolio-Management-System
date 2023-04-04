package DALs;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PortfolioManagementSystemDAL {
    private final String url;
    private final String username;
    private final String password;
    private Connection conn;

    public PortfolioManagementSystemDAL(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }

    public void connect() throws SQLException {
        conn = DriverManager.getConnection(url, username, password);
    }

    public void disconnect() throws SQLException {
        if (conn != null) {
            conn.close();
        }
    }

    public void createInvestment(String name, String type, double sharesHeld, double purchasePrice, Date purchaseDate) throws SQLException {
        String query = "INSERT INTO investments (name, type, shares_held, purchase_price, purchase_date) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, name);
            stmt.setString(2, type);
            stmt.setDouble(3, sharesHeld);
            stmt.setDouble(4, purchasePrice);
            stmt.setDate(5, purchaseDate);
            stmt.executeUpdate();
        }
    }

    public List<Investment> getInvestments() throws SQLException {
        String query = "SELECT * FROM investments";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            List<Investment> investments = new ArrayList<>();
            while (rs.next()) {
                Investment investment = new Investment(rs.getInt("investment_id"), rs.getString("name"),
                        rs.getString("type"), rs.getDouble("shares_held"), rs.getDouble("purchase_price"),
                        rs.getDate("purchase_date"));
                investments.add(investment);
            }
            return investments;
        }
    }

    public void updateInvestmentSharesHeld(int investmentId, double newSharesHeld) throws SQLException {
        String query = "UPDATE investments SET shares_held = ? WHERE investment_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDouble(1, newSharesHeld);
            stmt.setInt(2, investmentId);
            stmt.executeUpdate();
        }
    }

    public void deleteInvestment(int investmentId) throws SQLException {
        String query = "DELETE FROM investments WHERE investment_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, investmentId);
            stmt.executeUpdate();
        }
    }

    // similar methods for other tables (performance_metrics, market_data, other_financial_info, portfolio, portfolio_investments)

    public List<PortfolioPerformanceReport> generatePortfolioPerformanceReport(int portfolioId) throws SQLException {
        // implementation of portfolio performance report generation
    }

    public List<InvestmentOpportunityReport> generateInvestmentOpportunityReport() throws SQLException {
        // implementation of investment opportunity report generation
    }

    public List<MarketTrendReport> generateMarketTrendReport() throws SQLException {
        // implementation of market trend report generation
    }
}
