<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	// table ordered 의 id (주문 완료와 함께 id값 GET 전송)
	String id = request.getParameter("id");

	// DB 연결
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	// ordered, product 2개 테이블의 데이터를 동시에 조회
	String sql = "select*from ordered, product where ordered.product_code = product.product_code and ordered.id=" + id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/myorder.css">
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div> 
		<div id="grid_right">
			<section class="myorder_section">
				<div id="myorder_header">MY ORDER</div>
				<div>
					<table>
					
					</table>
				</div>
			</section>
		</div>
	</div>

</body>
</html>