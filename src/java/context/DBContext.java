
package context;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

    // JDBC driver cho SQL Server
    public static String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    // URL kết nối đến database Wish
    public static String dbURL = "jdbc:sqlserver://localhost:1433;databaseName=Wish";

    // Thông tin đăng nhập SQL Server
    public static String userDB = "sa";
    public static String passDB = "123";

    // Phương thức tạo kết nối
    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName(driverName); // Nạp driver
            con = DriverManager.getConnection(dbURL, userDB, passDB); // Kết nối
        } catch (Exception ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return con;
    }

    // Kiểm tra kết nối
    public static void main(String[] args) {
        try (Connection con = getConnection()) {
            if (con != null) {
                System.out.println("Kết nối tới database thành công!");
            } else {
                System.out.println("Kết nối thất bại!");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}

 