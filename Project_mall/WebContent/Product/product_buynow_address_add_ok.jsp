<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	String destination = request.getParameter("destination");
	String recipient = request.getParameter("recipient");
	String zip = request.getParameter("zip");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String cell = request.getParameter("cell");
	
	// 체크박스 값 넘어오나 ?
	String change_member = request.getParameter("change_member");
	int isdefault = 0;
	if (change_member.equals("1")) {
		isdefault = 1;
		// address 테이블의 모든 레코드 isdefault = 0 수정한다
		// 기본배송지 값을 가질 레코드에만 1 값을 다시 부여할 것이므로
		String sql_a = "update address set isdefault=" + 0;
		stmt.executeUpdate(sql_a);
	}


	String sql = "insert into address(email, destination, recipient, zip, address1, address2, cell, isdefault, writeday)";
	sql = sql + " values(?,?,?,?,?,?,?,?,now())";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, email);
	pstmt.setString(2, destination);
	pstmt.setString(3, recipient);
	pstmt.setString(4, zip);
	pstmt.setString(5, address1);
	pstmt.setString(6, address2);
	pstmt.setString(7, cell);
	pstmt.setInt(8, isdefault);
	pstmt.executeUpdate();
	pstmt.close();
	
	// 기본배송지 체크되면 member 테이블의 주소를 바꾼다 !
	
	if (change_member.equals("1")) {
		String sql_m = "update member set zip="+zip+", address1='"+address1+"', address2='"+address2+"' ";
		sql_m = sql_m + " where email='" + email + "'";
		stmt.executeUpdate(sql_m);
	}
	stmt.close();
	conn.close();

	response.sendRedirect("product_buynow_address.jsp?email=" + email);
%>