<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css">
<link rel="stylesheet" href="../Image/signinStyle.css">
<script>
	function locateToFindAccount() {
		location = "../SignUp/findAccount.jsp";
	}
	function locateToSignup() {
		location = "../SignUp/signup.jsp";
	}
</script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<article></article>
		<article>
			<form action="signin_ok.jsp" method="post">
				<div id="captionSignin">로그인</div>
				<div id="formSignin">
					회원아이디
					<p></p>
					<input type="text" name="userid">
					<p></p>
					비밀번호
					<p></p>
					<input type="password" name="password">
					<p></p>
					<input type="submit" value="로그인">
					<p></p>
					<input type="checkbox"> 자동로그인
					<p></p>
				</div>
			</form>
			<div id="infoSignin">
				<b>회원로그인 안내</b>
				<p></p>
				회원아이디 및 비밀번호가 기억 안나실 때는 아이디/비밀번호 찾기를 <br> 이용하십시오. <br> 아직
				회원이 아니시라면 회원으로 가입 후 이용해 주십시오.
				<p></p>
				<input id="buttonFind" type="button" value="아이디/비밀번호 찾기"
					onclick="locateToFindAccount()"> <input id="buttonSignup"
					type="button" value="회원가입" onclick="locateToSignup()">
			</div>
			<div id="backToMain">
				<a href="../Home/home.jsp">메인으로 돌아가기</a>
			</div>
		</article>
	</section>

	<%@ include file="../Common/footer.jsp"%>
</body>
</html>