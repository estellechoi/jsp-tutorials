<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="mall.Util.Util"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	String email = session.getAttribute("email").toString();
	
	// 누적 포인트
	int point_history = 0;	
	// 누적 구매 금액
	int amount_total = 0;
	// 누적 주문건수
	int order = 0;
	
	String sql = "select*from member where email='" + email + "'";
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/account.css?ver=2">
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div> 
		<div id="grid_right">
			<section class="account_section">
				<div id="account_header">ACCOUNT</div>
				<div class="account_grid_container">	
					<div class="account_grid_left">
						<!-- 포인트 내역 -->
						<table>
							<caption>내 포인트/쿠폰 현황</caption>
							<tr>
								<th>가용 포인트</th>
								<td><%=Util.comma(rs.getInt("point"))%></td>
							</tr>
							<tr>
								<th>내 쿠폰</th>
								<td>
									<select name="coupon" id="coupon">
										<option value="0">내 쿠폰보기</option>
									</select>
								</td>
							</tr>
						</table>
						<!-- 개인정보 -->
						<table class="user_information">
							<caption><%=session.getAttribute("email")%></caption>
							<tr>
								<th>회원 구분</th>
								<td>
								<%
									String usertype;
									if (rs.getInt("usertype") == 0) {
										usertype = "개인 회원";
									}
									else {
										usertype = "사업자 회원";
									}
								%>
								<%=usertype%>
								</td>
							</tr>
							<tr>
								<th width="200">이름</th>
								<td><%=session.getAttribute("username")%></td>
							</tr>
							<tr>
								<th>주소</th>
								<td>
								<%
									if (rs.getString("zip") != null) {
								%>
									(<%=rs.getString("zip")%>)<br>
									<%=rs.getString("address1")%><br>
									<%=rs.getString("address2")%>
								<%
									}
								%>
								</td>
							</tr>
							<tr>
								<th>휴대전화</th>
								<td>
								<%
									if (rs.getString("cell") != null) {
								%>
									<%=rs.getString("cell")%>
								<%
									}
								%>
								</td>
							</tr>
							<tr>
								<th>성별</th>
								<td>
								<%
									String sex = "남";
									if (rs.getInt("sex") == 0) {
										sex = "남";
									}
									else {
										sex = "여";
									}
								%>
								<%=sex%>
								</td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td>
								<%=rs.getString("birth")%>
								</td>
							</tr>
							<tr>
								<th>수신 동의</th>
								<td>
								<%
									String agree_SMS;
									String agree_email;
									if (rs.getInt("agree_SMS") == 1) {
										agree_SMS = "동의";
									}
									else {
										agree_SMS = "미동의";
									}
									if (rs.getInt("agree_email") == 1) {
										agree_email = "동의";
									}
									else {
										agree_email = "미동의";
									}
								%>
								SMS 수신 동의 <%=agree_SMS%> / 이메일 수신 동의 <%=agree_email%>
								</td>
							</tr>
							<tr>
								<th>가입일자</th>
								<td><%=rs.getString("writeday")%></td>
							</tr>
						</table>
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