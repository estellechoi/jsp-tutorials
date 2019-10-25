<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.grid_container {
	display: grid;
	grid-template-colums: 200px 1fr;
}
</style>
</head>
<body>
	<div class="grid_container">
		<div class="grid_left">
			<jsp:include page="../nav.jsp" flush="false" />
		</div>
		<section>
			home
		</section>
	</div>
</body>
</html>