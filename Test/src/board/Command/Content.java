package board.Command;

import java.sql.SQLException;
import board.Jdbc.Connect;
import java.sql.Connection;
import java.util.ArrayList;
import board.Dto.Board_dto;
import board.Dao.Board_dao;


public class Content {

	// ArrayList 값을 반환하는 리턴 메소드
	// 특정 레코드 값을 가져오기 위해 id 값을 매개변수로 함
	public ArrayList<Board_dto> content(int id) throws SQLException {
		
		// DB 연결
		Connection conn = Connect.connection();
		
		// DB 접근을 위해 DAO 객체 생성 (DAO의 메소드를 사용하자 !)
		Board_dao dao = new Board_dao();
		
		// DAO의 리턴 메소드 반환값을 같은 타입의 변수(객체)에 담자
		ArrayList<Board_dto> Ali = dao.content(conn, id);
		
		// 최종 리턴
		return Ali;
	}
}
