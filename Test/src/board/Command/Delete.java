package board.Command;

import board.Jdbc.Connect;
import java.sql.Connection;
import java.sql.SQLException;
import board.Dao.Board_dao;

public class Delete {
	
	public void delete(String id) throws SQLException {
		// DB 연결
		Connection conn = Connect.connection();
		
		// DAO 메소드 사용을 위해 DAO 객체 생성
		Board_dao dao = new Board_dao();
		
		// 메소드 실행
		dao.delete(conn, id);
		
	}

}
