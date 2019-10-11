package board.Command;

import board.Jdbc.Connect;
import board.Dto.Board_dto;
import board.Dao.Board_dao;
import java.sql.SQLException;
import java.sql.Connection;

public class Write {
	
	// 값을 넣어야 할 때는 dto 객체가 필요합니다.
	public void write(Board_dto dto) throws SQLException {
		
		// DB 연결 (Connect 클래스)
		Connection conn = Connect.connection();
		
		// DB 엑세스 (Board_dao 클래스)
		Board_dao dao = new Board_dao();
		
		// write 메소드 실행
		dao.write(conn, dto);
		
	}

}
