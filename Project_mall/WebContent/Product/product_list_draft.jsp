<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.text.DecimalFormat" %>

<%
	DecimalFormat df = new DecimalFormat("#,###");

	Connection conn = Connect.connection_static(); // Connect 클래스 connection_static() 리턴함수
	Statement stmt = conn.createStatement();

	// 0 ~ 24 이전 인덱스 레코드만 출력하기
	String sql = "select*from product where product_code like 'p03%' limit 0, 24";
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
		<caption><h2>상품 03</h2></caption>
		<tr>

			<%
				int i = 0;
				while(rs.next()) {
					if (i % 4 == 0) {
			%>
				</tr>
				<tr>
			<%
					}
			%>
				<td align="center">
					<img src="Image/<%=rs.getString("product_list")%>" alt="no image" width="250"> <p></p>
					<%=rs.getString("name")%> <br>
					￦<%=df.format(rs.getInt("price"))%>
				</td>
			<%
					i++;
				}
			%>
		</tr>
	</table>

</body>
</html>