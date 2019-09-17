<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Test.test"%>
<%
	test t = new test();

	out.print(t.print());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%!
	// 변수,메소드 선언시 ! 사용 ??
	String name = "유진";
	int kor = 100;

	public int test(int a, int b) {
		return a * b;
	}%>
	
	<%
		test(1,3);
	%>
</body>
</html>

