<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
int a = 100;
int b = 90;
int total = a+b;
// * JSP : JAVA 언어로 작성 → HTML 코드로 출력됨
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
hello world.
<p></p>

<%out.println(total+"<br>");%> 

</body>
</html>