<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	// DB 연결 (Connect 클래스 connection_static() 메소드 실행)
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	// POST 전송값 가져오기
	request.setCharacterEncoding("UTF-8");
	
	// 주문자정보
	String email = "";
	String username = "";
	
	// 1) 로그인회원  session 값
	if (session.getAttribute("email") != null) {
		email = session.getAttribute("email").toString();
		username = session.getAttribute("username").toString();		
	}
	// 2) 비회원 POST 전송값
	else {
		email = request.getParameter("email");
		username = request.getParameter("username");
	}

	// 상품 가짓수
	int kind = Integer.parseInt(request.getParameter("kind"));
	
	// 주문 상품 정보
	String product_code[];
	String size[];
	int qty[];
	int get_point[];
	
	// 1개 상품만 바로 구매
	if (kind == 1) {
		product_code = new String[kind];
		size = new String[kind];
		qty = new int[kind];
		get_point = new int[kind];
		product_code[0] = request.getParameter("product_code");
		size[0] = request.getParameter("size");
		qty[0] = Integer.parseInt(request.getParameter("qty"));
		get_point[0] = Integer.parseInt(request.getParameter("get_point"));
	}
	// 여러개 선택 상품 구매
	else {
		product_code = request.getParameterValues("product_code");
		size = request.getParameterValues("size");
		String P[] = request.getParameterValues("get_point");
		get_point = new int[kind];
		for(int i=0; i<P.length; i++) {
			get_point[i] = Integer.parseInt(P[i]);
		}
		String Q[] = request.getParameterValues("qty");
		qty = new int[kind];
		for (int i =0; i<Q.length; i++) {
			qty[i] = Integer.parseInt(Q[i]);
		}
	}
	
	int use_point = 0; // 비회원 (사용할 일 없긴 함.)
	if (request.getParameter("use_point") != null) {
		use_point = Integer.parseInt(request.getParameter("use_point")); // 사용한 적립금
	}
	String amount_buy = request.getParameter("amount_buy_hidden"); // 콤마 없는 값이 넘어오도록 이전 페이지에서 컨트롤했어야 ...
	String amount_discount = request.getParameter("amount_discount_hidden");
	String amount_pay = request.getParameter("amount_pay_hidden");
	String delivery_fee = request.getParameter("delivery_fee");
	String r_msg = request.getParameter("r_msg");
	String pay = request.getParameter("pay"); // 결제수단
	String pay_keychain = ""; // 결제정보 키체인
		if (request.getParameter("pay_keychain") == null) {
			pay_keychain = "0";
		} else {
			pay_keychain = "1";
		}
	String confirm = request.getParameter("confirm"); // 구매 진행 동의

	// 무통장입금/계좌이체의 경우
	String sender = "";
	if (request.getParameter("sender") != "" && request.getParameter("sender") != null) {
		sender = request.getParameter("sender");
	}
	else {
		sender = "null";
	}

// **** 위시리스트나 장바구니에서 넘어온 상품의 경우, 구매 완료 후 해당 데이터베이스 테이블에서 레코드를 삭제해야 한다 !
	// 위시리스트에서 온 경우
	if (request.getParameter("wish").equals("y")) {
		String sql = "delete from wishlist where product_code='"+product_code[0]+"' and email='"+email+"'";
		stmt.executeUpdate(sql);
	}

	// 장바구니에서 온 경우
	if (request.getParameter("cart").equals("y")) {
		String sql_code ="";
		for (int i=0; i<kind; i++) {
			sql_code = sql_code + "'" + product_code[i] + "', ";
		}
		int e = sql_code.lastIndexOf(",");
		sql_code = sql_code.substring(0,e);
		String sql = "delete from cart where product_code in(" + sql_code + ") and email='"+email+"'";
		stmt.executeUpdate(sql);
	}

		
// 쿼리 시작 !
	String sql;
	// member table에서 사용포인트 빼고 적립포인트 누적시키기
	if (session.getAttribute("email") != null) {
		int add_point = 0;
		for (int i=0; i<get_point.length; i++) {
			add_point = add_point + get_point[i];
		}
		sql = "update member set point=point+" + add_point + "-" + use_point + " where email='" + email + "'";
		stmt.executeUpdate(sql);		
	}
	
	// product 테이블에 판매량 누적시키기
	for (int i=0; i<product_code.length; i++) {
		sql = "update product set quantity_sales=quantity_sales+" + qty[i] + " where product_code='" + product_code[i] + "'";
		stmt.executeUpdate(sql);
	}
	
	// address table에 없는 배송지인 경우 (새로운 배송지 입력한 경우)
	String same_address = request.getParameter("same_address"); // "0" vs "1"
	String id_address = null;
	
	// 새로운 배송지인 경우 or 비회원
	if (same_address.equals("1") || session.getAttribute("email") == null) {
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
	// 주문자 정보와 동일 (로그인 회원)
	else {
		// member 테이블 id_address 값 가져와야 한다 !
		// 회원가입시 주소정보를 입력하면 id_address 값, table address에도 레코드 등록돼야 함
		// 회원가입시 주소정보 미입력하면 주문자정보에도 주소가 없기 때문에 <주문자 정보와 동일> 체크 불가
			sql = "select * from member where email='" + email + "'";
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			id_address = rs.getString("id_address");			
	}
		
	// ordered 테이블에 레코드 추가하기 전, 가장 최근 레코드의 id 값을 저장해놓자 !
	sql = "select max(id) as id from ordered";
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	int id_max = rs.getInt("id");
	
	// ordered 테이블 에서 같은 오더끼리 조회하기 위한, 오더번호 생성하기
	String order_code = product_code[0] + (id_max + 1);

	// ordered 테이블에 레코드 추가하기
	for (int i=0; i<kind; i++) {
		sql = "insert into ordered(username, email, product_code, size, qty, delivery_fee, id_address, get_point, amount_buy, amount_discount, amount_pay, pay, pay_keychain, sender, confirm, r_msg, order_code)";
		sql = sql + " values(?,?,?,?,?,?,?,?, ?, ?,?,?,?,?,?,?,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, username);
		pstmt.setString(2, email);
		pstmt.setString(3, product_code[i]);
		pstmt.setString(4, size[i]);	
		pstmt.setInt(5, qty[i]);
		pstmt.setString(6, delivery_fee);
		pstmt.setString(7, id_address);
		pstmt.setInt(8, get_point[i]);
		pstmt.setString(9, amount_buy);
		pstmt.setString(10, amount_discount);
		pstmt.setString(11, amount_pay);
		pstmt.setString(12, pay);
		pstmt.setString(13, pay_keychain);
		pstmt.setString(14, sender);
		pstmt.setString(15, confirm);
		pstmt.setString(16, r_msg);
		pstmt.setString(17, order_code);
		pstmt.executeUpdate();
		
		pstmt.close();
	}

	// ordered 테이블에 레코드 추가 후, 방금 추가된 레코드의 id 값들을 불러오자 !
	// 혹은 생성한 order_code만 보내주기 (이걸로 조회 가능하니까)
	sql = "select id from ordered where id>" + id_max;
	rs = stmt.executeQuery(sql);
	String id = "";
	while (rs.next()) {
		id = id + rs.getInt("id") + ",";
	}
	
	// 페이지 이동 (주문완료 페이지)
	response.sendRedirect("../Product/product_buynow_view.jsp?order_code=" + order_code + "&id=" + id);
	
	// 종료
	stmt.close();
	conn.close();
%>