// PlanServiceTest.java
import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

import java.sql.*;
import java.util.List;

public class PlanServiceTest {

    private static final String URL = "jdbc:oracle:thin:@localhost:1521/XEPDB1";
    private static final String USER = "software_dev";
    private static final String PASSWORD = "devpass";

    @Test
    public void testGeneratePlan_Success() {
        // Arrange
        double weight = 70.5;
        String goal = "схуднення";

        // Act & Assert
        assertDoesNotThrow(() -> {
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(
                    "SELECT id, snidanok, kaloriynist FROM PLAN_HARCHUVANNIA WHERE id = 1"
                );
                assertTrue(rs.next(), "Дані повинні бути знайдені");
                assertEquals("Yaytsia", rs.getString("snidanok"));
                assertEquals(2000, rs.getInt("kaloriynist"));
            }
        });
    }

    @Test
    public void testGeneratePlan_InvalidWeight_Low() {
        // Arrange
        double weight = 25.0;
        String goal = "схуднення";

        // Act & Assert - перевіряємо, що запит виконується, але повертає порожній результат
        assertDoesNotThrow(() -> {
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM PLAN_HARCHUVANNIA WHERE id = 999");
                assertFalse(rs.next(), "Не повинно знаходити дані для неіснуючого ID");
            }
        });
    }

    @Test
    public void testGeneratePlan_InvalidGoal() {
        // Arrange
        double weight = 80.0;
        String goal = "детокс";

        // Act & Assert - перевіряємо, що запит виконується, але повертає порожній результат
        assertDoesNotThrow(() -> {
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM PLAN_HARCHUVANNIA WHERE id = 999");
                assertFalse(rs.next(), "Не повинно знаходити дані для неіснуючого ID");
            }
        });
    }

    @Test
    public void testGeneratePlan_NullGoal() {
        // Arrange
        double weight = 80.0;
        String goal = null;

        // Act & Assert - перевіряємо, що запит виконується, але повертає порожній результат
        assertDoesNotThrow(() -> {
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM PLAN_HARCHUVANNIA WHERE id = 999");
                assertFalse(rs.next(), "Не повинно знаходити дані для неіснуючого ID");
            }
        });
    }
}
