<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	// DB 연결
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	// 금액 표시 객체
	DecimalFormat df = new DecimalFormat("#,###");
	
	// ordered, product 2개 테이블의 데이터를 동시에 조회
	// product_code 가 여러개 일 때 ? 추 후 수정 ...
	String sql = "select*from ordered,product where ordered.product_code=product.product_code and ordered.email='" + session.getAttribute("email") + "'";
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/myorder.css?ver=1">
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
				<%
					while(rs.next()) {
						String writeday = rs.getString("writeday");
						String writedaySplit[] = writeday.split(" ");
				%>
				<table>
					<caption>주문일 <%=writedaySplit[0]%></caption>
					<tr>
						<td><img src="../Product/Image/<%=rs.getString("product_list")%>" alt="no image" width="100"></td>
						<td>
							<%=rs.getString("name")%><p></p>
							<%=df.format(rs.getInt("amount_buy"))%> 원 <p></p>
							<%=rs.getString("qty")%> 개
						</td>
						<td>
							배송중 <p></p>
							<a href="#">배송 조회</a><p></p>
							<a href="#">주문 취소</a>
						</td>
					</tr>
				</table>
				<%
					}
				%>
			</section>
		</div>
	</div>

</body>
</html>