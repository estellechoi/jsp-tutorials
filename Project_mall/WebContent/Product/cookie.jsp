<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();

	Cookie cookies[] = request.getCookies();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#cookie_box {
		border: 1px solid #3A4050;
		border-radius: 5px;
		font-size: 11px;
		text-align: center;
		color: #3A4050;
	}
</style>
</head>
<body>
	<div id="cookie_box">
		<h3>내가 본 상품</h3>
	<%
		// 자동 생성된 쿠키 session id는 배열의 맨 끝에 있음
		for (int i = (cookies.length - 2); i >=0 ; i--) {
			String sql = "select product_list, name from product where product_code='"
					+ cookies[i].getValue() + "'";
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
	%>
		<img id="cookies"
			src="../Product/Image/<%=rs.getString("product_list")%>"
			alt="no image" width="80" height="80">
		<br>
		<%=rs.getString("name")%>
		<p></p>
	<%
		}
	%>
	</div>
</body>