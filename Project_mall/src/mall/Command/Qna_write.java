package mall.Command;

import java.sql.Connection;
import java.sql.SQLException;
import mall.Jdbc.Connect;
import mall.Dao.Qna_dao;
import mall.Dto.Qna_dto;

public class Qna_write {

	// 커맨드 실행 메소드 (변수를 담은 Dto 객체)
	public void write(Qna_dto dto) throws SQLException {
		
		// DB 연결
		Connection conn = Connect.connection_static();
		
		// 쿼리실행 메소드를 가진 Dao 객체 생성
		Qna_dao dao = new Qna_dao();
		
		// Dao의 메소드 실행
		dao.insert(conn, dto);
	}
}
