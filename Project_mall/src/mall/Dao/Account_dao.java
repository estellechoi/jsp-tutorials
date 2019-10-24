package mall.Dao;

import java.sql.*;
import mall.Dto.Member;
import mall.Jdbc.Connect;
import java.util.ArrayList;

public class Account_dao {

	// 1) 값을 수정하는 메소드 (리턴 X)
	// JSP 페이지에서 jsp:useBean 액션태그를 사용하여 DTO 클래스에 값을 전달
	// 전달된 값을 가진 DTO 객체를 매개변수로 사용하여 값을 불러오자 (getter 사용)
	public void Edit(Connection conn, Member dto) throws SQLException {
		
		// 새로 입력한 주소가 기존 address 테이블에 있는 주소인지 검사
		String id_address = null;
		String sql = "select*from address where email='" + dto.getEmail() + "' and address1='" + dto.getAddress1() + "'";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		
		// 이미 있다면 id_address 값을 가져온다
		if (rs.next()) {
			id_address = rs.getString("id_address");
		}
		// 없다면 address 테이블에 새 주소를 추가하고, 그 id 값을 가져와서 id_address 값으로 삼는다.
		else {
			sql = "insert into address(email, recipient, zip, address1, address2, cell, writeday, destination)";
			sql = " values('"+dto.getEmail()+"', '"+dto.getUsername()+"', '"+dto.getZip()+"', '"+dto.getAddress1()+"', '"+dto.getAddress2()+"', '"+dto.getCell()+"', now(), '집')";
			stmt.executeUpdate(sql);
			
			// 방금 address 테이블에 추가한 주소의 id값
			sql = "select max(id) as id from address";
			rs = stmt.executeQuery(sql);
			rs.next();
			id_address = rs.getString("id");
		}
		// member 테이블 수정 쿼리
		sql = "update member set username=?, email=?, zip=?, address1=?, address2=?, cell=?, sex=?, birth=?, agree_SMS=?, agree_email=?, id_address=? where id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString (1, dto.getUsername());
		pstmt.setString(2, dto.getEmail());
		pstmt.setString(3, dto.getZip());
		pstmt.setString(4, dto.getAddress1());
		pstmt.setString(5, dto.getAddress2());
		pstmt.setString(6, dto.getCell());
		pstmt.setInt(7, dto.getSex());
		pstmt.setString(8, dto.getBirth());
		pstmt.setString(9, dto.getAgree_SMS());
		pstmt.setString(10, dto.getAgree_email());
		pstmt.setString(11, id_address);
		pstmt.setInt(12, dto.getId());
		pstmt.execute();
		// 종료
		stmt.close();
		pstmt.close();
		conn.close();
	}
}
