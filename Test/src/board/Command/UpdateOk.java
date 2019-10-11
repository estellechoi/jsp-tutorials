package board.Command;

import board.Dao.Board_dao;
import board.Dto.Board_dto;
import board.Jdbc.Connect;
import java.sql.SQLException;
import java.sql.Connection;

public class UpdateOk {

	// 값을 넣어야 할 때는 dto 객체가 필요합니다.
	public void updateok(Board_dto dto) throws SQLException {
		
		// DB 연결
		Connection conn = Connect.connection();
		
		// DAO 객체 생성
		Board_dao dao = new Board_dao();
		
		// DAO 메소드 실행
		dao.updateok(conn, dto);
	}
}
