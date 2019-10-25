package blog.Jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connect {
	
	public static Connection connection() throws SQLException {
		String driver = "jdbc:mysql://localhost:3307/blog?useSSL=false";
		String id = "root";
		String pw = "1234";
		Connection conn = DriverManager.getConnection(driver,id,pw);
		return conn;
	}

}
