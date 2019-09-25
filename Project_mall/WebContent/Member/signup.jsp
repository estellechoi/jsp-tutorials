<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/signup.css">
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div> 
		<div id="grid_right">
			<!-- 회원가입 -->
			<section class="signup_section">
				<div id="signup_main">
						<!-- 회원가입 글자 -->
						<div id="signup_header">SIGN UP</div>
						<!-- 회원가입 폼 grid -->
						<div id="signup_form">
							<form action="signup_ok.jsp">
								<table>
									<tr>
										<th>이메일 * </th>
										<td><input type="text" name="email"></td>
									</tr>
									<tr>
										<th>이름 * </th>
										<td><input type="text" name="name"></td>
									</tr>
									<tr>
										<th>비밀번호 * </th>
										<td><input type="password" name="pwd"></td>
									</tr>
								</table>
							</form>
						</div>
				</div>
			</section>
			<!-- footer -->
			<jsp:include page="../footer.jsp" flush="false"/>
		</div>
	</div>
</body>
</html>