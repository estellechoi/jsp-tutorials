package board.Command;

import java.sql.SQLException;
import board.Jdbc.Connect;
import java.sql.Connection;
import java.util.ArrayList;
import board.Dto.Board_dto;
import board.Dao.Board_dao;

public class List {

	// ArrayList 값을 반환하는 리턴 메소드 
	public ArrayList<Board_dto> list() throws SQLException {
		// DB 연결 객체
		Connection conn = Connect.connection();
		
		// DB 접근을 위해 DAO 객체 생성 (DAO의 메소드를 사용하자 !)
		Board_dao dao = new Board_dao();
		
		// DAO 메소드의 ArrayList 반환값을 객체변수에 담자 (값을 담는 변수와 반환값 자료형 일치)
		// DAO 메소드는 ArrayList 반환값은 ? 모든 rs 레코드 값을 담은 dto 객체를 요소로 하는 ArrayList
		ArrayList<Board_dto> Ali = dao.select(conn);
		
		// 최종 리턴
		return Ali;
	}
}
