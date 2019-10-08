package mall.Command;

import java.sql.Connection;
import java.sql.SQLException;
import mall.Jdbc.Connect;
import mall.Dao.Qna_insert;
import mall.Dto.Qna;

public class Qna_write {

	// 커맨드 실행 메소드 (변수를 담은 Dto 객체)
	public void write(Qna dto) throws SQLException {
		
		// DB 연결
		Connection conn = Connect.connection_static();
		
		// 쿼리실행 메소드를 가진 Dao 객체 생성
		Qna_insert dao = new Qna_insert();
		
		// Dao 클래스의 쿼리실행 메소드
		dao.insert(conn, dto);
	}
}
