<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/signup.css?ver=3">
<script src="../Etc/signup.js"></script>
<!-- daum 도로명주소검색 API 시작 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 우편번호 검색 버튼 클릭하여 함수 호출
	function search_address() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	// 사용자가 도로명 주소를 선택했을 경우
	            if (data.userSelectedType === 'R') { 
	                addr = data.roadAddress;
	                
	            // 사용자가 지번 주소를 선택했을 경우(J)
	            } else { 
	                addr = data.jibunAddress;
	            }
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById("zip").value = data.zonecode; // 우편번호
	            document.getElementById("address1").value = addr;  // 주소
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("address2").focus();
	        }
	    }).open();	
	}
</script>
<!-- daum 도로명주소검색 API 끝 -->
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
							<form action="signup_ok.jsp" method="post">
								<table>
									<caption>정보 입력</caption>
									<tr>
										<th>회원구분 * </th>
										<td>
											<input type="radio" name="type" value="0">개인회원
											<input type="radio" name="type" value="1">사업자회원
										</td>
									</tr>
									<tr>
										<th>이메일 * </th>
										<td>
											<input type="text" name="email_id" size="7"> @
											<input type="text" name="email_host" size="7" id="email_host">
											<select name="email" id="email" onchange="Host()">
												<option value="직접입력">직접 입력</option>
												<option value="naver.com">naver.com</option>
												<option value="daum.net">daum.net</option>
												<option value="gmail.com">gmail.com</option>
												<option value="yahoo.com">yahoo.com</option>
											</select>
										</td>
										<script>

										</script>
									</tr>
									<tr>
										<th>이름 * </th>
										<td><input type="text" name="name"></td>
									</tr>
									<tr>
										<th>비밀번호 * </th>
										<td><input type="password" name="pwd"></td>
									</tr>
									<tr>
										<th>비밀번호 확인 * </th>
										<td><input type="password" name="pwd_check"></td>
									</tr>
									<tr>
										<th>주소</th>
										<td>
											<input type="text" name="zip" id="zip">
											<input type="button" value="우편번호 검색" id="zip_button" onclick="search_address()"> <p></p>
											<input type="text" name="address1" id="address1"> 기본주소 <p></p>
											<input type="text" name="address2" id="address2"> 나머지 주소
										</td>
									</tr>
									<tr>
										<th>성별</th>
										<td>
											<input type="radio" name="sex" value="0">남
											<input type="radio" name="sex" value="1">여
										</td>
									</tr>
									<tr>
										<th>생년월일</th>
										<td>
											<select name="birth_year" id="birth_year">
												<%
													Date today = new Date();
													int yy = today.getYear() +1900;
													for (int i=yy; i>=1970; i--) {
												%>
												<option value="<%=i%>"><%=i%></option>
												<%
													}
												%>
											</select> 년
											<select name="birth_month" id="birth_month">
												<%
													for(int i=1; i<=12; i++) {
												%>
												<option value="<%=i%>"><%=i%></option>
												<%
													}
												%>
											</select> 월 
											<select name="birth_date" id="birth_date">
												<option value="1">1</option>
											</select> 일
										</td>
									</tr>
								</table>
								<table>
									<caption>이용약관</caption>
									<tr>
										<td id="agree_master_td">
											<input type="checkbox" id="agree_master" onclick="AgreeAll(this)">
											이용약관 및 개인정보수집 및 이용, 쇼핑정보 수신(선택)에 모두 동의합니다.
										</td>
									</tr>
									<tr>
										<td>
											<b>[필수] 이용약관 동의</b> <p></p>
											<textarea name="" id="" cols="80" rows="10">
												<jsp:include page="../Etc/agree1.txt"/>
											</textarea> <p></p>
											<!-- txt 파일 저장시 인코딩 : UTF-8 설정 필요 -->
											이용약관에 동의하십니까? <input type="checkbox" name="agree1" id="" class="agree" onclick="Agree()">동의함
										</td>
									</tr>
									<tr>
										<td>
											<b>[필수] 개인정보 수집 및 이용 동의</b> <p></p>
											<textarea name="" id="" cols="80" rows="10">
												<jsp:include page="../Etc/agree2.txt"/>
											</textarea> <p></p>
											개인정보 수집 및 이용에 동의하십니까? <input type="checkbox" name="agree2" id="" class="agree" onclick="Agree()">동의함
										</td>
									</tr>
									<tr>
										<td>
											<b>[선택] 쇼핑정보 수신 동의</b> <p></p>
											<textarea name="" id="" cols="80" rows="10">
												<jsp:include page="../Etc/agree3.txt"/>
											</textarea> <p></p>
											SMS 수신을 동의하십니까? <input type="checkbox" name="agree3" id="" class="agree" onclick="Agree()">동의함 <p></p>
											이메일 수신을 동의하십니까? <input type="checkbox" name="agree4" id="" class="agree" onclick="Agree()">동의함
										</td>
									</tr>
								</table>
								<div id="submit_button">
									<input type="submit" value="회원가입">
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