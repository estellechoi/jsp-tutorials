<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#img {
		height: 330px;
		background-image: url("../Img/jelly.jpg");
		background-size: 500px;
		/* 텍스트 스타일 */
		color: white;
		text-align: center;
	}
	
	#img span {
		font-size: 50px;
		font-style: italic;
		font-weight: bold;
	}
	
	#link {
		height: 300px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	#link input[type=button] {
		width: 140px;
		height: 50px;
		border: 3px solid #eeeeee;
		border-radius: 15px;
		background: #A01226;
		color: white;
		font-size: 16px;
		cursor: pointer;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function() {
		$("#link input").click(function() {
			location.href = "signup_form.jsp";
		});
	});
</script>
</head>
<body>
	<%@ include file="../Common/header.jsp" %>
	<section>
	<div id="img">
	<span>¡ WELCOME !</span>
	<p></p>
	하우스에 오신걸 환영합니다.
	<br>
	※ 회원으로 가입되더라도 정보 제공 및 약관 동의가 되지 않은 제휴 브랜드에는 개인정보가 제공되지 않습니다.
	</div>
	<div id="link"><input type="button" value="회원가입"></div>
	</section>
</body>
</html>