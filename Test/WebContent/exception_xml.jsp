<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 예외 발생시 xml 파일에서 처리하기 : xml 파일에 작성 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 500 에러 -->
	<!-- ArithmeticException 등 예외 타입별 처리 -->
	
	<%=10 / 0%>
	
	<!-- 404 에러 -->
	
<%-- 	<% --%>
// 		response.sendRedirect("exist_false.jsp");
<%-- 	%> --%>
	
</body>
</html>