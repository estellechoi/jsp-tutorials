package mall.Dao;

import java.sql.*;
//import java.sql.Statement;
import mall.Dto.Address;

public class Address_dao {
	
	// 값을 입력하는 메소드 (리턴 X)
	public void Add(Connection conn, Address dto) throws SQLException {
		
		// 쿼리
		String sql = "insert into address(email, recipient, zip, address1, address2, cell, writeday, destination)";
		sql = sql + " values(?,?,?,?,?,?,now(),?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getEmail());
		pstmt.setString(2, dto.getRecipient());
		pstmt.setString(3, dto.getZip());
		pstmt.setString(4, dto.getAddress1());
		pstmt.setString(5, dto.getAddress2());
		pstmt.setString(6, dto.getCell());
		pstmt.setString(7, dto.getDestination());
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	// 레코드 삭제 메소드
	public void Delete(Connection conn, String id) throws SQLException {
		// 체크된 레코드의 id 값 (,로 연결된 문자열)
		// 쿼리
		String sql = "delete from address where id=" + id;
		Statement stmt = conn.createStatement();
		stmt.executeUpdate(sql);
		stmt.close();
		conn.close();
	}
	
}
