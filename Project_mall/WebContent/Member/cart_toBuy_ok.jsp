<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%
	// DB 연결 (Connect 클래스 connection_static() 메소드 실행)
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();

	// session 값 가져오기
	String email = session.getAttribute("email").toString();
	String username = session.getAttribute("username").toString(); // 가능 ?

	// POST 전송값 가져오기
	request.setCharacterEncoding("UTF-8");	
	String product_code[] = request.getParameterValues("product_code");
	String size[] = request.getParameterValues("size");
	String qty[] = request.getParameterValues("qty");
	String get_point[] = request.getParameterValues("get_point"); // 적립 포인트
	String delivery_fee = request.getParameter("delivery_fee");
// 	String r_msg = ""; // 배송 메세지
// 		if (!(request.getParameter("r_msg").equals(""))) {
// 			r_msg = request.getParameter("r_msg");
// 		}
	// 배송 메세지 이렇게 해줘야 하나 ? 자동으로 "" 처리되지 않나 ?
	String r_msg = request.getParameter("r_msg");
	
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
	if (request.getParameter("sender") != "" && request.getParameter("sender") != null) {
		sender = request.getParameter("sender");
	}
	else {
		sender = "null";
	}
	
	// product_code, qty, size 를 상품별로 세트로 묶어 ArrayList에 넣어주기
	ArrayList<String[]> P = new ArrayList<String[]>();
	// ArrayList의 각 요소는 상품 1개당 코드, qty, size를 요소로 하는 배열
	// product[] = {product_code[0], size[0], qty[0]};
	for (int i = 0; i < product_code.length; i++) {
		String product[] = {product_code[i], size[i], qty[i]};
		// ArrayList의 요소로 추가
		P.add(product);
	}

// **** 위시리스트나 장바구니에서 넘어온 상품의 경우, 구매 완료 후 해당 데이터베이스 테이블에서 레코드를 삭제해야 한다 !
	// 위시리스트에서 온 경우
	if (request.getParameter("IfFromWish").equals("y")) {
		for (int i = 0; i < product_code.length; i++) {
			String sql = "delete from wishlist where product_code='" + product_code[i] + "' and email='" + email + "'";
			stmt.executeUpdate(sql);			
		}
	}

	// 장바구니에서 온 경우
	if (request.getParameter("IfFromCart").equals("y")) {
		for (int i = 0; i < product_code.length; i++) {
			String sql = "delete from cart where product_code='" + product_code[i] + "' and email='" + email + "'";
			stmt.executeUpdate(sql);
		}
	}

		
// 쿼리 시작 !

	// member table에 적립포인트 누적시키기
	int get_point_total = 0;
	// 상품별 포인트 int 로 변환
	int points[] = new int[product_code.length];
	for (int i=0; i<product_code.length; i++) {
		points[i] = Integer.parseInt(get_point[i]); // int 변환
		get_point_total = get_point_total + points[i]; // 누적 포인트 계산
	}
	
	String sql = "update member set point=point+" + get_point_total + " where email='" + email + "'";
	stmt.executeUpdate(sql);
	
	// address table에 없는 배송지인 경우 (새로운 배송지 입력한 경우)
	String same_address = request.getParameter("same_address"); // "0" vs "1"
	String id_address = null;
	
	// 새로운 배송지인 경우
	if (same_address.equals("1")) {
		// 배송지 정보 → address 테이블에 저장
		String recipient = request.getParameter("recipient");
		String destination = request.getParameter("recipient");
		String zip = request.getParameter("r_zip");
		String address1 = request.getParameter("r_address1");
		String address2 = request.getParameter("r_address2");
		String cell = request.getParameter("r_cell1")+"-"+request.getParameter("r_cell2")+"-"+request.getParameter("r_cell3");
		
		sql = "insert into address(email, recipient, zip, address1, address2, cell, destination, writeday)";
		sql = sql + " values(?,?,?,?,?,?,?,now())";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setString(2, recipient);
		pstmt.setString(3, zip);
		pstmt.setString(4, address1);
		pstmt.setString(5, address2);
		pstmt.setString(6, cell);
		pstmt.setString(7, destination);
		pstmt.executeUpdate();
		
		// 방금 저장한 레코드의 id 값 가져오기 (중복방지를 위해 email 값 추가)
		sql = "select max(id) as id_address from address where email='"+email+"'";
		ResultSet rs = stmt.executeQuery(sql);
		rs.next();
		id_address = rs.getString("id_address");
	}
	// 주소록에서 선택 경우
	// input text 의 값이 없으면 null 이 아닌 "" 값이 넘어온다 !!!!
	// 여기서 equals() 로 하지 않아도 되는 이유는 ?
	else if (same_address.equals("2")) {
		id_address = request.getParameter("id_address");
		// product_buynow.jsp (opener)에서 팝업창 선택값을 Javascript로 받음 (input hidden에 저장)
		// 주소록 팝업창에서 아무런 이벤트 없이 '취소' 버튼 눌렀다면, 자동으로 새배송지로 선택값 변경하는 것이 필요 !!
		// same_address 값은 2인데, id_address 값이 없는 오류 발생하기 때문 !
	}
	// 주문자 정보와 동일
	else {
		// member 테이블 id_address 값 가져와야 한다 !
		// 회원가입시 주소정보를 입력하면 id_address 값, table address에도 레코드 등록돼야 함
		// 회원가입시 주소정보 미입력하면 주문자정보에도 주소가 없기 때문에 <주문자 정보와 동일> 체크 불가
			sql = "select * from member where email='" + email + "'";
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			id_address = rs.getString("id_address");
	}

	
	sql = "insert into ordered(username, email, product_code, size, qty, delivery_fee, id_address, get_point, amount_buy, amount_discount, amount_pay, pay, pay_keychain, sender, confirm, r_msg)";
	sql = sql + " values(?,?,?,?,?,?,?,?, ?, ?,?,?,?,?,?,?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, username);
	pstmt.setString(2, email);
	// ArrayList로 바꾼 부분 → MySQL 테이블 필드 수정해야 .... 
	pstmt.setString(3, product_code);
	pstmt.setString(4, size);	
	pstmt.setString(5, qty);
	pstmt.setString(6, delivery_fee);
	pstmt.setString(7, id_address);
	pstmt.setInt(8, get_point_total);
	pstmt.setString(9, amount_buy);
	pstmt.setString(10, amount_discount);
	pstmt.setString(11, amount_pay);
	pstmt.setString(12, pay);
	pstmt.setString(13, pay_keychain);
	pstmt.setString(14, sender);
	pstmt.setString(15, confirm);
	pstmt.setString(16, r_msg);
	pstmt.executeUpdate();
	
	// table ordered 추가 후 방금 추가한 레코드의 id 값 가져가자 !
	sql = "select max(id) as id from ordered where email='"+email+"'";
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	
	// 페이지 이동 (마이오더 페이지)
	response.sendRedirect("../Product/product_buynow_view.jsp?id=" + rs.getInt("id"));
	
	// 종료
	stmt.close();
	pstmt.close();
	conn.close();
%>