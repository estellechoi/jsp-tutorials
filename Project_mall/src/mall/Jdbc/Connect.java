package mall.Jdbc;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connect {
	
	public Connection connection() throws SQLException {
		String host = "jdbc:mysql://localhost:3307/mall?useSSL=false";
		String id ="root";
		String pw = "1234";
		
		Connection conn = DriverManager.getConnection(host, id, pw);
		return conn;
	}
	
	
	// static ?
	public static Connection connection_static() throws SQLException {
		String host = "jdbc:mysql://localhost:3307/mall?useSSL=false";
		String id ="root";
		String pw = "1234";
		
		Connection conn = DriverManager.getConnection(host, id, pw);
		return conn;		
	}

}
