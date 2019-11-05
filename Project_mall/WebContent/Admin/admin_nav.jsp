<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#admin_nav {
		text-align: center;
	}
	#admin_nav ul {
		list-style-type: none;
	}
	#admin_nav li {
		margin-top: 20px;
	}
	
	#admin_nav a {
		text-decoration: none;
		color: #3A4050;
		font-weight: bold;
	}
</style>
</head>
<body>
	<div id="admin_nav">
		<ul>
			<li><a href="admin_product.jsp">상품 관리</a></li>
			<li><a href="admin_member.jsp">회원 관리</a></li>
			<li><a href="admin_order.jsp">오더 관리</a></li>
		</ul>
	</div>
</body>
</html>