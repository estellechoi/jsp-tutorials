<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/forgot_id.css">
<script>
	function BusinessForm(b) {
		if(b == "1") {
			document.getElementById("business_no").innerText = "사업자번호";
			document.getElementById("business_name").innerText = "상호명";
		}
		else {
			document.getElementById("business_no").innerText = "이메일";
			document.getElementById("business_name").innerText = "이름";			
		}
	}
</script>
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
					<div id="forgot_main">
						<!-- 로그인 글자 -->
						<div id="forgot_header">FORGOT ID</div>
						<div id="forgot_form">
						<form action="forgot_id_ok.jsp" method="post">
							<table>
								<caption> * 사업자회원의 경우 상호명과 사업자번호를 입력해주세요.</caption>
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
									<th id="business_no">이메일</th>
									<td><input type="text" name="email"></td>
								</tr>
								<tr>
									<th id="business_name">이름</th>
									<td><input type="text" name="name"></td>
								</tr>
							</table>
							<div id="submit">
								<input type="submit" value="아이디 찾기" id="submit_button">
							</div>
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