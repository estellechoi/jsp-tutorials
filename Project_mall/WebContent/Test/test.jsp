<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mall.Test.Test"%>
<%
	// 인스턴트 메소드 사용
	Test t = new Test();
	out.print(t.sum() + "<br>");

	
	// 스태틱 메소드 사용 (객체생성 필요 X)
	out.print(Test.cal());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>