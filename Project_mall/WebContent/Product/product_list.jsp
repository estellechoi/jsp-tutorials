<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*"%>
 <%@ page import="mall.Jdbc.Connect"%>
 
 <%
	Connection conn = Connect.connection_static(); // Connect 클래스 connection_static() 리턴함수
	Statement stmt = conn.createStatement();
	
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
	<tr>
		<td>상품코드</td>
		<td>상품명</td>
		<td>가격</td>
		<td>입고량</td>
		<td>판매량</td>
		<td>재고</td>
		<td>등록일</td>
	</tr>
	<%
	while(rs.next()) {
		int order = rs.getInt("quantity_order");
		int sales = rs.getInt("quantity_sales");
	%>
	<tr>
		<td><%=rs.getString("product_code")%></td>
		<td><%=rs.getString("name")%></td>
		<td><%=rs.getString("price")%></td>
		<td><%=order%></td>
		<td><%=sales%></td>
		<td><%=order-sales%></td>
		<td><%=rs.getString("writeday")%></td>
	</tr>
	<%
	}
	%>
</table>

</body>
</html>