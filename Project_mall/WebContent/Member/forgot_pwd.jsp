<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/forgot_id.css?ver=1">
<script>
	function BusinessForm(b) {
		if(b == "1") {
			document.getElementById("business_name").innerText = "상호명";
		}
		else {
			document.getElementById("business_name").innerText = "이름";			
		}
	}
</script>
<style>
#forgot_header {
	height: 200px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 700;
	letter-spacing: 2px;
	font-size: 14px;
	color: #353535;
}

#forgot_form {
	margin-bottom: 100px;
}

#forgot_form table {
	width: 800px;
	margin: auto;
	padding-top: 50px;
	padding-bottom: 50px;
	border: 1px solid #495164;
	border-radius: 5px;
}

#forgot_form table caption {
	font-size: 12px;
	padding: 20px;
	text-align: left;
}

#forgot_form table th, td {
	height: 40px;
}

#forgot_form table td a {
	border: 1px solid #495164;
	border-radius: 5px;
	background: #495164;
	color: white;
	font-size: 12px;
	font-weight: bold;
	width: 150px;
	padding: 10px;
	text-decoration: none;
}

#forgot_form table td input {
	height: 35px;
}

</style>
</head>
<body>
	<!-- 네비게이션 바 <body> display: grid -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
			<!-- empty space for nav bar -->
			<div id="grid_left"></div> 
			<div id="grid_right">
				<!-- 로그인 페이지 -->
				<section class="forgot_section">
					<!-- 로그인 글자 -->
					<div id="forgot_header">FORGOT PASSWORD</div>
					<div id="forgot_main" class="account_grid_container">
						<div id="forgot_form">
						<form action="forgot_pwd_ok.jsp" method="post">
							<table>
								<caption> * 사업자회원의 경우 상호명을 입력해주세요.</caption>
								<tr>
									<th>회원구분</th>
									<td>
										<select name="type" id="type" onchange="BusinessForm(this.value)">
											<option value="0">개인회원</option>
											<option value="1">사업자회원</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td><input type="text" name="email"></td>
								</tr>
								<tr>
									<th id="business_name">이름</th>
									<td><input type="text" name="username"></td>
								</tr>
								<tr>
									<th></th>
									<td>
										<input type="submit" value="비밀번호 찾기">
									</td>
								</tr>
							</table>
						</form>
						</div>
						<%
							if(session.getAttribute("email") != null) {
						%>
						<!-- account 네비게이션바 -->
						 <jsp:include page="account_nav.jsp" flush="false"/>
						 <%
							}
						 %>
					</div>
				</section>
				<!-- footer -->
				<jsp:include page="../footer.jsp" flush="false"/>
			</div>
	</div>
</body>
</html>