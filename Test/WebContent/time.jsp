<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	시간 <%=new java.util.Date()%>
	
	<%
		Calendar cal = Calendar.getInstance();
	%>
	
	<%=cal.get(Calendar.YEAR)%>
	<%=cal.get(Calendar.MONTH)+1%>
	<%=cal.get(Calendar.DATE)%>

</body>
</html>