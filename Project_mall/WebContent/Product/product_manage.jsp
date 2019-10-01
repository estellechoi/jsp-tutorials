<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*"%>
 <%@ page import="mall.Jdbc.Connect"%>
 <%@ page import="java.text.DecimalFormat" %>
 
 <%
	Connection conn = Connect.connection_static(); // Connect 클래스 connection_static() 리턴함수
	Statement stmt = conn.createStatement();
	
	// 0 ~ 24 인덱스 레코드만 출력하기
	String sql = "select*from product";
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
	<caption>상품 관리</caption>
	<caption><a href="product.jsp">상품등록</a></caption>
	<tr>
		<td>상품코드</td>
		<td>상품명</td>
		<td>가격</td>
		<td>입고량</td>
		<td>판매량</td>
		<td>재고</td>
		<td>이미지</td>
		<td>등록일</td>
	</tr>
	<%
	
	DecimalFormat df = new DecimalFormat("#,###");
	
	while(rs.next()) {
		int order = rs.getInt("quantity_order");
		int sales = rs.getInt("quantity_sales");
	%>
	<tr>
		<td><%=rs.getString("product_code")%></td>
		<td><%=rs.getString("name")%></td>
		<!-- 금액 표시 설정하기 -->
		<td>￦<%=df.format(rs.getInt("price"))%></td>
		<td><%=order%></td>
		<td><%=sales%></td>
		<td><%=order-sales%></td>
		<td><img src="Image/<%=rs.getString("product_list")%>" alt="no image" width="100"></td>
		<td><%=rs.getString("writeday")%></td>
	</tr>
	<%
	}
	%>
</table>

</body>
</html>