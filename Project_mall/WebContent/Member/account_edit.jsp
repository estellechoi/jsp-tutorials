<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.util.Date"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	String sql = "select*from member where email='" + session.getAttribute("email") + "'";
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	
	// 회원 구분
	String usertype = "";
	if(rs.getInt("usertype") == 0) {
		usertype = "개인 회원";
	}
	else {
		usertype = "사업자 회원";
	}
	
	// 성별 텍스트 변환
	String sex = "";
	if (rs.getInt("sex") == 0) {
		sex = "남";
	}
	else {
		sex = "여";
	}
	
	// 회원 생년월일
	String birth = rs.getString("birth");
	String birthSplit[] = birth.split("-");
	
	// 07 과 같은 수를 7 로 변환하기 위한 작업
	int mm = Integer.parseInt(birthSplit[1]);
	int dd = Integer.parseInt(birthSplit[2]);
	
	// 오늘 날짜
	Date today = new Date();
	int toyear = today.getYear() + 1900;	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/account_edit.css?ver=1">
<script>
	// 문서 로드시
	function Filled() {
		// 생년월일
		document.getElementsByName("birth_yy")[0].value = "<%=birthSplit[0]%>";
		document.getElementsByName("birth_mm")[0].value = "<%=mm%>";
		document.getElementsByName("birth_dd")[0].value = "<%=dd%>";
		
		// 수신동의 체크
		if (<%=rs.getString("agree_SMS")%> == "1") {
			document.getElementsByName("agree_SMS")[0].checked = true;
		}
		
		if (<%=rs.getString("agree_email")%> == "1") {
			document.getElementsByName("agree_email")[0].checked = true;
		}
	}
	
	// POST 값 전송을 위해 cell, birth 입력값을 하나의 문자열로 통합하는 작업
	function Birth() {
		var yy = document.getElementsByName("birth_yy")[0].value;
		var mm = document.getElementsByName("birth_mm")[0].value;
		var dd = document.getElementsByName("birth_dd")[0].value;
		
		if (mm < 10) {
			mm = "0" + mm;
		}		
		if (dd < 10) {
			dd = "0" + dd;
		}
		
		document.getElementsByName("birth")[0].value = yy + "-" + mm + "-" + dd;
	}
	
	function Cell() {
		var cell1 = document.getElementsByName("cell1")[0].value;
		var cell2 = document.getElementsByName("cell2")[0].value;
		var cell3 = document.getElementsByName("cell3")[0].value;
		
		document.getElementsByName("cell")[0].value = cell1 + "-" + cell2 + "-" + cell3;
	}
	
	function Back() {
		history.back();
	}
</script>
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
<script src="../Etc/common.js?after"></script>
</head>
<body onload="Filled()">
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div> 
		<div id="grid_right">
			<section class="account_edit_section">
				<div id="account_edit_header">EDIT ACCOUNT</div>
				<div class="account_grid_container">	
					<div class="account_grid_left">
						<form action="account_edit_ok.jsp" method="post" name="order">
							<!-- 주소록 팝업창에서 값을 받기 위해 form의 name 값을 order로 함.... -->
							<!-- table member 레코드 id 값 -->
							<input type="hidden" name="id" value="<%=rs.getInt("id")%>">
							<input type="hidden" name="birth" value="<%=rs.getString("birth")%>">
							<input type="hidden" name="cell" value="<%=rs.getString("cell")%>">
							<table>
								<tr>
									<th>회원구분</th>
									<td><%=usertype%></td>
								</tr>
								<tr>
									<th>이름</th>
									<td>
										<input type="text" name="username" value="<%=session.getAttribute("username")%>">
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>
										<input type="text" name="email" value="<%=session.getAttribute("email")%>" readonly>
									</td>
								</tr>
								<tr>
									<th>주소</th>
									<%
										if (rs.getString("zip") != null) {
									%>
									<td>
										<input type="text" name="zip" id="zip" value="<%=rs.getInt("zip")%>" size="5" readonly>
										<input type="button" value="우편번호 검색" onclick="search_address()">
										<br>
										<input type="text" name="address1" id="address1" value="<%=rs.getString("address1")%>" readonly><br>
										<input type="text" name="address2" id="address2" value="<%=rs.getString("address2")%>"><br>
										<span class="information">새 주소는 내 주소록에 자동으로 추가됩니다.</span>
									</td>
									<%
										} else {
									%>
									<td>
										<input type="text" name="zip" id="zip" size="5">
										<input type="button" value="우편번호 검색" onclick="search_address()">
										<br>
										<input type="text" name="address1" id="address1"><br>
										<input type="text" name="address2" id="address2"><br>
										<span class="information">새 주소는 내 주소록에 자동으로 추가됩니다.</span>
									</td>		
									<%
										}
									%>
								</tr>
								<tr>
									<th>휴대전화</th>
									<%
										if (rs.getString("cell") != null) {
										String cell = rs.getString("cell");
										String cellSplit[] = cell.split("-");
									%>
									<td>
										<input type="text" name="cell1" value="<%=cellSplit[0]%>" size="5" onblur="Cell()">-
										<input type="text" name="cell2" value="<%=cellSplit[1]%>" size="5" onblur="Cell()">-
										<input type="text" name="cell3" value="<%=cellSplit[2]%>" size="5" onblur="Cell()">
									</td>
									<%
										} else {
									%>
									<td>
										<input type="text" name="cell1" size="5" onblur="Cell()">-
										<input type="text" name="cell2" size="5" onblur="Cell()">-
										<input type="text" name="cell3" size="5" onblur="Cell()">
									</td>							
									<%
										}
									%>
								</tr>
								<tr>
									<th>성별</th>
									<td><%=sex%></td>
								</tr>
								<tr>
									<th>생년월일</th>
									<%
		
									%>
									<td>
										<select name="birth_yy" onchange="Birth()">
											<%
											for (int i = toyear; i>=1950; i--) {
											%>
											<option value="<%=i%>"><%=i%></option>
											<%
											}
											%>
										</select>
										<select name="birth_mm" onchange="Birth()">
											<%
											for (int i=1; i<=12; i++) {
											%>
											<option value="<%=i%>"><%=i%></option>
											<%
											}
											%>
										</select>
										<select name="birth_dd" onchange="Birth()">
											<%
											for (int i=1; i<=31; i++) {
											%>
											<option value="<%=i%>"><%=i%></option>
											<%
											}
											%>
										</select>
									</td>
								</tr>
								<tr>
									<th>수신 동의</th>
									<td>
										<!-- 체크하면 1 , 체크 해제하면 null -->
										<input type="checkbox" name="agree_SMS" value="1"> SMS 수신 동의
										<input type="checkbox" name="agree_email" value="1"> 이메일 수신 동의
									</td>
								</tr>
							</table>
							<div class="submit">
								<input type="submit" value="수정">
								<input type="button" value="취소" onclick="Back()">
							</div>
						</form>
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