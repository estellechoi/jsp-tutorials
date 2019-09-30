<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%> <!-- mall.Jdbc 패키지 Connect 클래스 임포트 (Java resource file) -->

<%
	Connection conn = Connect.connection_static(); // Connect 클래스 connection_static() 리턴함수
	request.setCharacterEncoding("UTF-8");

	// MultipartRequest 객체 생성
	
	// 그림파일 저장 경로
	String path="C://users/alfo1-2/jspwork_git/Project_mall/WebContent/Product";
	int max = 1024*1024*10;
	MultipartRequest multi = new MultipartRequest(request, path, max, "UTF-8", new DefaultFileRenamePolicy());
	
	// 상품코드 (대분류/중분류/제조국/제조사)
	String product_code = request.getParameter("product_code");
	
	// DB 쿼리
	// 4리수 상품 id 만들기
	// product 테이블에서 가장 최근 id 값 조회하고, "num" 이라는 필드로 보이기
	String sql = "select max(id) as num from product";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	rs.next(); //null 값을 getInt()로 부르면 0값을 가져온다.
	
	// 1 증가 왜시키지 ? 새로운 아이템 등록시 최근 id + 1 값으로 저장되니까
	String id = rs.getInt("num") + 1 + "";
	
	if (id.length() == 1) {
		id = "000" + id;
	}
	if (id.length() == 2) {
		id = id + "00" + id;
	}
	if (id.length() == 3) {
		id = id + "0" + id;
	}
	
	product_code = product_code + id;
	
	// 상품이름, 가격, 세탁정보
	String name = multi.getParameter("name");
	String price = multi.getParameter("price");
	String laundry = multi.getParameter("laundry");
	
	// 생산일자
	String yy = multi.getParameter("yy");
	String mm = multi.getParameter("mm");
	String dd = multi.getParameter("dd");
	String manufactured_date = yy + "-" + mm + "-" + dd;
	
	// 입고수량
	String quantity_order = multi.getParameter("quantity_order");
	
	// 상품 이미지 (리스트, 메인, 상세)
	String product_list = multi.getParameter("product_list");
	String product_main = multi.getParameter("product_main");
	String product_detail = multi.getParameter("product_detail");
	
	// DB 쿼리
	sql = "insert into product(product_code, name, price, laundry, manufactured_date, quantity_order, quantity_sales, product_list, product_main, product_detail, product_recommend, writeday)";
	sql = sql + " values(?,?,?,?,?,?,?,?,?,?,?,now())";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, product_code);
	pstmt.setString(2, name);
	pstmt.setString(3, price);
	pstmt.setString(4, laundry); 
	pstmt.setString(5, manufactured_date);
	pstmt.setString(6, quantity_order);
	pstmt.setString(7, "0"); // 판매량 초기값 0
	pstmt.setString(8, product_list);
	pstmt.setString(9, product_main);
	pstmt.setString(10, product_detail);
	pstmt.setString(11, ""); // 관련상품 추후 처리
	
	pstmt.executeUpdate();
	
	pstmt.close();
	rs.close();
	conn.close();
	
	response.sendRedirect("product_list.jsp");
%>