<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/home.css">
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div> 
		<div id="grid_right">
			<!-- 상품설명 -->
			<section class="welcome_image">
				<div id="welcome_text">mall</div>
			</section>
			<!-- footer -->
			<jsp:include page="../footer.jsp" flush="false"/>
		</div>
	</div>
</body>
</html>	