<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	Integer num = (Integer) application.getAttribute("num");
	num++;
	application.setAttribute("num", num);
	
	response.sendRedirect("application_index.jsp");
%>
</body>
</html>