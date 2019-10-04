<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String name1 = request.getParameter("name1");
	String name2 = request.getParameter("name2");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	JSP:forward 포워딩 페이지에 파라미터 값이 전송되었습니다 ! <p></p>
	값 1 : <%=name1%>
	값 2 : <%=name2%>
</body>
</html>