<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function() {
			$("#goSignup").click(function() {
				location.href = "signup.jsp";
			});
	});
</script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<button id="goSignup">회원가입</button>
	</section>
</body>
</html>