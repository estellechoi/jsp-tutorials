<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#account_address_header {
		height: 200px;
		display: flex;
		align-items: center;
		justify-content: center;
		font-weight: 700;
		letter-spacing: 2px;
		font-size: 14px;
		color: #353535;
	}
</style>
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div> 
		<div id="grid_right">
			<section class="account_address_section">
				<div id="account_address_header">MY ADDRESS</div>
				<div class="account_grid_container">
					<div>
						<!-- JSP include로 페이지를 요청할 때, 인클루드되는 페이지에 매개변수(파라미터)로 값 주기 -->
						<jsp:include page="address.jsp" flush="false">
							<jsp:param name="incld" value="1"/>
						</jsp:include>
					</div>
					<!-- ACCOUNT 페이지 메뉴 네비게이션바 -->
					<div class="account_grid_right">
						<jsp:include page="account_nav.jsp" flush="false"/>
					</div>
				</div>
			</section>
		</div>
	</div>
</body>
</html>