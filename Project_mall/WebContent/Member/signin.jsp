<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/signin.css?ver=1">
</head>
<body>
	<!-- 네비게이션 바 <body> display: grid -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
			<!-- empty space for nav bar -->
			<div id="grid_left"></div> 
			<div id="grid_right">
				<!-- 로그인 페이지 -->
				<section class="signin_section">
					<div id="signin_main">
						<!-- 로그인 글자 -->
						<div id="signin_header">LOGIN</div>
						<!-- 로그인 폼 grid -->
						<form action="signin_ok.jsp" method="post">
							<div id="signin_form">
								<div id="form_left">
									<div id="userid">
										<label for="uid">이메일</label> <input type="text" name="email" id="email">
									</div>
									<div id="password">
										<label for="pwd">패스워드</label> <input type="password" name="pwd" id="pwd">
									</div>
								</div>
								<div id="form_right">
									<input type="submit" value="로그인" id="submit">
								</div>
							</div>
							<!-- 키체인 설정 여부 -->
							<div id="signin_keychain">
								<input type="checkbox" name="keychain" id="keychain" value="Y"><label for="keychain">아이디 저장</label>
								<img alt="no image" src="../Etc/lock.png" width="12px"> 보안접속
							</div>
						</form>
						<!-- 아이디/비밀번호 찾기 -->
						<div id="signin_forgot">
							<a href="forgot_id.jsp"><img alt="no image" src="../Etc/link_icon.jpg" width="12px"> 아이디 찾기</a>
							<a href="forgot_pwd.jsp"><img alt="no image" src="../Etc/link_icon.jpg" width="12px"> 비밀번호 찾기</a>
						</div>
						<!-- 카카오 계정으로 로그인하기 -->
						<div id="signin_kakao">
							<div id="naver">네이버 로그인</div>
							<div id="facebook">페이스북 로그인</div>
							<div id="kakao">카카오 로그인</div>
						</div>
						<!-- 회원가입 링크 -->
						<div id="signup_link">
						 	<div><img alt="no image" src="../Etc/link_icon.jpg" width="12px"> 회원가입을 하시면 다양하고 특별한 혜택이 준비되어 있습니다.</div>
						 	<div><a href="signup.jsp">회원가입  > </a></div>
						</div>
						<!-- 비회원 로그인-->
						<div id="nonmember">
							<div>비회원 주문조회</div>
							<div>비회원의 경우, 주문번호로 주문조회가 가능합니다.</div>
							<div><img alt="no image" src="../Etc/link_icon.jpg" width="12px"> <span>주문자명</span> <input type="text" name="name"></div>
							<div><img alt="no image" src="../Etc/link_icon.jpg" width="12px"> <span>주문번호</span> <input type="text" name="ordernum1" size="7"> - <input type="text" name="ordernum2" size="7"></div>
							<div><img alt="no image" src="../Etc/link_icon.jpg" width="12px"> <span>비밀번호</span> <input type="password" name="pwd"></div>
							<div><button>조회 >></button></div>
						</div>
					</div>
				</section>
				<!-- footer -->
				<jsp:include page="../footer.jsp" flush="false"/>
			</div>
	</div>
</body>
</html>