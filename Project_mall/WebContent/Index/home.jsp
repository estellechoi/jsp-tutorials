<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Insert title here</title>
<!-- jQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Vegas Plugin -->
<script src="../Vegas/vegas.js"></script>
<script src="../Vegas/vegas.min.js"></script>
<link rel="stylesheet" href="../Vegas/vegas.css">
<link rel="stylesheet" href="../Vegas/vegas.min.css">
<script>
	$(function() {
		$(".welcome_section").vegas({
			slides : [ {
				src : "../Etc/vintage1.jpg"
			}, {
				src : "../Etc/vintage2.jpg"
			} ]
		});
	});
</script>
<style>
.welcome_section {
	height: 1500px;
}
</style>
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false" />
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div>
		<div id="grid_right">
			<!-- 웰컴 이미지 -->
			<section class="welcome_section">
				<div id="content">mall</div>
			</section>
			<!-- footer -->
			<jsp:include page="../footer.jsp" flush="false" />
		</div>
	</div>
</body>
</html>
