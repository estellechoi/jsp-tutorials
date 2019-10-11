package mall.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql. SQLException;

import mall.Dto.Qna_dto;

public class Qna_dao {

	// 쿼리실행 메소드 (디비 연결 객체, 변수를 저장한 dto 객체)
	public void insert(Connection conn, Qna_dto dto) throws SQLException {
		
		String sql = "insert into qna(email, username, title, content, writeday)";
		sql = sql + " values(?,?,?,?,now())";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getUsername());
		pstmt.setString(2, dto.getEmail());
		pstmt.setString(3, dto.getTitle());
		pstmt.setString(4, dto.getContent());
		pstmt.execute();
		pstmt.close();
		conn.close();
		/*Jdbc_close.close(conn, pstmt); ? */
	}
}

// * DAO : Date Access Object
// 데이터베이스에 접근해서 데이터 추가, 삭제, 수정 등의 작업을 하는 클래스
