<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

	function move() {
		var name = "유진";
		name = encodeURIComponent(name);
		location = "Encoding_ok.jsp?name="+name+"";
	}
</script>
</head>
<body>
<%
	String name = "유진";
	name = URLEncoder.encode(name);
%>

<a href="Encoding_ok.jsp?name=<%=name%>">JAVA 인코딩</a>
<button onclick="move()">Javascript 인코딩</button>
</body>
</html>