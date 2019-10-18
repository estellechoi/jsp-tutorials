package mall.Command;

import mall.Jdbc.Connect;
import mall.Dto.Address;
import mall.Dao.Address_dao;
import java.sql.Connection;
import java.sql.SQLException;


public class Address_add {
	
	public void Add(Address dto) throws SQLException {
		// DB 연결
		Connection conn = Connect.connection_static();
		
		// DB 엑세스를 위한 DAO 객체 생성
		Address_dao dao = new Address_dao();
		
		// DAO 메소드 실행
		dao.Add(conn, dto);
	}
}
