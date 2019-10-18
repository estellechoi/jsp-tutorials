package mall.Command;

import mall.Jdbc.Connect;
import java.sql.Connection;
import java.sql.SQLException;
import mall.Dao.Address_dao;

public class Address_del {

	public void Del(String id) throws SQLException {
		// DB 연결
		Connection conn = Connect.connection_static();
		
		// DAO 객체 생성
		Address_dao dao = new Address_dao();
		
		// 메소드 실행
		// 체크된 레코드의 id 값 (,로 연결된 문자열)
		dao.Delete(conn, id);
	}
}
