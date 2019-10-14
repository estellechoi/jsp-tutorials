<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = Connect.connection_static();

	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email"); // 이메일은 세션값이 있는데 왜 파라미터값이 필요하지 ?
	String username = session.getAttribute("username").toString(); // 야는 ?
	String product_code = request.getParameter("product_code");
	String size = request.getParameter("size");
	String qty = request.getParameter("qty");
	String get_point = request.getParameter("get_point");
	String pay = request.getParameter("pay");
	
	// int 값이 넘어오도록 이전 페이지에서 컨트롤했어야 ...
	String amount_buy = request.getParameter("amount_buy");
	String amount_discount = request.getParameter("amount_discount");
	String amount_pay = request.getParameter("amount_pay");
	String confirm = request.getParameter("confirm");
	
	String id_address = "";
	// 기존 배송지인 경우
	if (request.getParameter("r_id_address") != null) {
		id_address = request.getParameter("r_id_address");
	}
	
	// "0" vs "1"
	String r = request.getParameter("recipient");

	// 새로운 배송지인 경우 주소 정보를 address 테이블에 저장
	// id_address 는 최신값이 되겠찌 ? 어떻게 구하나 여기서 ?
	// 배송지 정보
	String recipient = request.getParameter("r_username");
	String r_zip = request.getParameter("r_zip");
	String r_address1 = request.getParameter("r_address1");
	String r_address2 = request.getParameter("r_address2");
	String cell = request.getParameter("r_cell1")+"-"+request.getParameter("r_cell2")+"-"+request.getParameter("r_cell3");
	String destination = request.getParameter("r_username");
	
	if (r.equals("1")) {
		String sql = "insert into address(email, recipient, zip, address1, address2, cell, destination, writeday)";
		sql = sql + " values(?,?,?,?,?,?,?,now())";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setString(2, recipient);
		pstmt.setString(3, r_zip);
		pstmt.setString(4, r_address1);
		pstmt.setString(5, r_address2);
		pstmt.setString(6, cell);
		pstmt.setString(7, destination);
		
		pstmt.execute();
		pstmt.close();
	}
	

%>