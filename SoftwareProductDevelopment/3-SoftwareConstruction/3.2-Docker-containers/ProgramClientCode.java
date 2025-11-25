// ProgramClientCode.java
import java.sql.*;

public class ProgramClientCode {
    public static void main(String[] args) {
        String url = "jdbc:oracle:thin:@alexberlimenko-oracle:1521/XEPDB1";
        String user = "software_dev";
        String password = "devpass";

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            System.out.println("✅ Успішне підключення до Oracle XE у Docker!");

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id, snidanok, kaloriynist FROM PLAN_HARCHUVANNIA");

            while (rs.next()) {
                System.out.printf("ID: %d, Сніданок: %s, Калорії: %d%n",
                        rs.getInt("id"),
                        rs.getString("snidanok"),
                        rs.getInt("kaloriynist"));
            }
        } catch (SQLException e) {
            System.err.println("❌ Помилка підключення: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
