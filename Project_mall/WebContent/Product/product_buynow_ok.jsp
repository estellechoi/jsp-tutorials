<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	// DB 연결 (Connect 클래스 connection_static() 메소드 실행)
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();

	// session 값 가져오기
	String email = session.getAttribute("email").toString();
	String username = session.getAttribute("username").toString(); // 가능 ?

	// POST 전송값 가져오기
	request.setCharacterEncoding("UTF-8");	
	String product_code = request.getParameter("product_code");
	String size = request.getParameter("size");
	String qty = request.getParameter("qty");
	String get_point = request.getParameter("get_point"); // 적립 포인트
	String r_msg = ""; // 배송 메세지
		if (request.getParameter("r_msg") != null) {
			r_msg = request.getParameter("r_msg");
		}
	
	String pay = request.getParameter("pay"); // 결제수단
	String pay_keychain = ""; // 결제정보 키체인
		if (request.getParameter("pay_keychain") == null) {
			pay_keychain = "0";
		} else {
			pay_keychain = "1";
		}
	String confirm = request.getParameter("confirm"); // 구매 진행 동의
	String amount_buy = request.getParameter("amount_buy_hidden"); // 콤마 없는 값이 넘어오도록 이전 페이지에서 컨트롤했어야 ...
	String amount_discount = request.getParameter("amount_discount_hidden");
	String amount_pay = request.getParameter("amount_pay_hidden");
	
	// 무통장입금/계좌이체의 경우
	String sender = "";
	if (request.getParameter("sender") != null) {
		sender = request.getParameter("sender");
	}
	else {
		sender = "null";
	}

	// address table에 없는 배송지인 경우 (새로운 배송지 입력한 경우)
	String r = request.getParameter("recipient"); // "0" vs "1"
	String id_address = null;
	
	// 새로운 배송지인 경우
	if (r.equals("1")) {
		// 배송지 정보 → address 테이블에 저장
		String recipient = request.getParameter("r_username");
		String destination = request.getParameter("r_username");
		String r_zip = request.getParameter("r_zip");
		String r_address1 = request.getParameter("r_address1");
		String r_address2 = request.getParameter("r_address2");
		String cell = request.getParameter("r_cell1")+"-"+request.getParameter("r_cell2")+"-"+request.getParameter("r_cell3");
		
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
		pstmt.executeUpdate();
		
		// 방금 저장한 레코드의 id 값 가져오기 (중복방지를 위해 email 값 추가)
		sql = "select max(id) as id_address from address where email='"+email+"'";
		ResultSet rs = stmt.executeQuery(sql);
		rs.next();
		id_address = rs.getString("id_address");
	}
	else {
		// input text 의 값이 없으면 null 이 아닌 "" 값이 넘어온다 !!!!
		if (request.getParameter("id_address") != "") {
			id_address = request.getParameter("id_address");
			// product_buynow.jsp 에서 script로 값 부여

		}
		else {
			// member 테이블 id_address 값 가져와야 한다 ! (주문자 정보와 동일)
			String sql = "select * from member where email='" + email + "'";
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			id_address = rs.getString("id_address");
		}
	}

	
// 	String sql = "insert into ordered(username, email, product_code, size, qty, id_address, get_point, amount_buy, amount_discount, amount_pay, pay, pay_keychain, sender, confirm, r_msg)";
// 	sql = sql + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
// 	PreparedStatement pstmt = conn.prepareStatement(sql);
// 	pstmt.setString(1, username);
// 	pstmt.setString(2, email);
// 	pstmt.setString(3, product_code);
// 	pstmt.setString(4, size);	
// 	pstmt.setString(5, qty);
// 	pstmt.setString(6, id_address);
// 	pstmt.setString(7, get_point);
// 	pstmt.setString(8, amount_buy);
// 	pstmt.setString(9, amount_discount);
// 	pstmt.setString(10, amount_pay);
// 	pstmt.setString(11, pay);
// 	pstmt.setString(12, pay_keychain);
// 	pstmt.setString(13, sender);
// 	pstmt.setString(14, confirm);
// 	pstmt.setString(15, r_msg);
// 	pstmt.executeUpdate();
	
// 	// table ordered 추가 후 방금 추가한 레코드의 id 값 가져가자 !
// 	sql = "select max(id) as id from ordered where email='"+email+"'";
// 	ResultSet rs = stmt.executeQuery(sql);
// 	rs.next();
	
// 	// 페이지 이동 (마이오더 페이지)
// 	response.sendRedirect("../Member/order.jsp?id=" + rs.getInt("id"));
	
// 	// 종료
// 	pstmt.close();
// 	conn.close();
%>