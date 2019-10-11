package board.Jdbc;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;

public class Connect {

	
	// 리턴함수 connection();
	public static Connection connection() throws SQLException {
		String host = "jdbc:mysql://localhost:3307/board?useSSL=false";
		String id = "root";
		String pw = "1234";
		
		Connection conn = DriverManager.getConnection(host, id, pw);
		return conn;
	}
}
