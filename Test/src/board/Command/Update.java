package board.Command;

import board.Dao.Board_dao;
import board.Dto.Board_dto;
import java.util.ArrayList;
import java.sql.SQLException;
import board.Jdbc.Connect;
import java.sql.Connection;

public class Update {
	
	public ArrayList<Board_dto> update(String id) throws SQLException {
	
		// DB 연결
		Connection conn = Connect.connection();
		
		// DAO 객체 생성
		Board_dao dao = new Board_dao();
		
		// DAO update() 리턴 메소드 실행
		ArrayList<Board_dto> Ali = dao.update(conn, id);
		
		// 최종 리턴
		return Ali;

	}
}
