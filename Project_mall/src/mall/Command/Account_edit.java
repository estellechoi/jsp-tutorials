package mall.Command;

import mall.Jdbc.Connect;
import mall.Dto.Member;
import mall.Dao.Account_dao;
import java.sql.SQLException;
import java.sql.Connection;

public class Account_edit {
	
	// 값을 넣어야 할 때는 dto 객체가 필요합니다.
	public void Edit(Member dto) throws SQLException {
		
		// DB 연결
		Connection conn = Connect.connection_static();
		
		// DB 엑세스
		Account_dao dao = new Account_dao();
		
		// Edit() 메소드 실행
		dao.Edit(conn, dto);
	}

}
