<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!-- DB 접근 필요없음 (session 변수 활성화 상태 이므로) -->
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css">
<link rel="stylesheet" href="../Image/editProfile_checkStyle.css">

</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<article></article>
		<article>
			<div>회원 비밀번호 확인</div>
			<div>
				<b>비밀번호를 한 번 더 입력해주세요.</b>
				<p></p>
				회원님의 정보를 안전하게 보호하기 위해 비밀번호를 한번 더 확인합니다.
			</div>

			<div>
				<form method="post" action="../SignUp/editProfile_check_ok.jsp">
					아이디 &nbsp; &nbsp;&nbsp; <input type="text" name="userid" value="<%=session.getAttribute("userid")%>" disabled>
					<p></p>
					비밀번호 &nbsp; <input type="password" name="password">
					<p></p>
					<input type="submit" value="확인">
				</form>
			</div>

		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>