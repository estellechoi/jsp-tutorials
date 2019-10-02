<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%
	String name = URLEncoder.encode("유진", "UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 동적 JSP 인클루드 : 웹브라우저가 해석한 <html> 코드 인클루드 (Java 코드는 해석되어 사라짐) -->
<jsp:include page="decoder.jsp" flush="false">
	<jsp:param name="name" value="<%=name%>"/>
	<jsp:param name="age" value="27"/>
	<jsp:param name="address" value="Seoul"/>
</jsp:include>
</body>
</html>