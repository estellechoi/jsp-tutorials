package mall.Dao;

import java.sql.*;
import mall.Dto.Member;
import mall.Jdbc.Connect;
import java.util.ArrayList;

public class Account_dao {

	// 1) 값을 입력하는 메소드 (리턴 X)
	// JSP 페이지에서 jsp:useBean 액션태그를 사용하여 DTO 클래스에 값을 전달
	// 전달된 값을 가진 DTO 객체를 매개변수로 사용하여 값을 불러오자 (getter 사용)
	public void Edit(Connection conn, Member dto) throws SQLException {
		
		// 쿼리
		String sql = "update member set username=?, email=?, zip=?, address1=?, address2=?, cell=?, sex=?, birth=?, agree_SMS=?, agree_email=? where id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString (1, dto.getUsername());
		pstmt.setString(2, dto.getEmail());
		pstmt.setInt(3, dto.getZip());
		pstmt.setString(4, dto.getAddress1());
		pstmt.setString(5, dto.getAddress2());
		pstmt.setString(6, dto.getCell());
		pstmt.setInt(7, dto.getSex());
		pstmt.setString(8, dto.getBirth());
		pstmt.setString(9, dto.getAgree_SMS());
		pstmt.setString(10, dto.getAgree_email());
		pstmt.setInt(11, dto.getId());
		pstmt.execute();
		pstmt.close();
		conn.close();
	}
}
