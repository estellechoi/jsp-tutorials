<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="mall.Util.Util"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	String email = session.getAttribute("email").toString();
	// 가져올 필드
	String sql = "select price, ordered.qty, member.point, ordered.get_point";
	// 검색 영역이 되는 테이블 : product, member, ordered
	sql = sql + " from product, member, ordered where member.email = '" + email + "'";
	sql = sql + " and member.email = ordered.email and ordered.product_code = product.product_code";
	ResultSet rs = stmt.executeQuery(sql);
	
	// 누적 포인트
	int point_history = 0;	
	// 누적 구매 금액
	int amount_total = 0;	
	// 누적 주문건수
	int order = 0;
	
	while (rs.next()) {
		point_history = point_history + rs.getInt("get_point");
		amount_total = amount_total + (rs.getInt("price") * rs.getInt("qty"));
		order++;
	}
	
	// 현재 포인트
	int point;
	// 주문 히스토리 있을 때
	if (order != 0) {
		rs.first(); // 첫번째 레코드로 이동
		point = rs.getInt("point");
	}
	// 주문 히스토리 없을 때 (레코드 X)
	else {
		sql = "select point from member where email='" + email + "'";
		rs = stmt.executeQuery(sql);
		rs.next();
		point = rs.getInt("point");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/account.css?after">
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
							<caption>포인트</caption>
							<tr>
								<td>현재 포인트</td>
								<td>누적 적립포인트</td>
								<td>누적 주문금액</td>
								<td>누적 주문건수</td>
							</tr>
							<tr>
								<td><%=Util.comma(point)%></td>
								<td><%=Util.comma(point_history)%></td>
								<td><%=Util.comma(amount_total)%></td>
								<td><%=order%></td>
							</tr>
						</table>
						<!-- 개인정보 -->
						<table>
							<caption><%=session.getAttribute("email")%></caption>
							<tr>
								<th>회원 구분</th>
								<td></td>
							</tr>
							<tr>
								<th width="200">이름</th>
								<td><%=session.getAttribute("username")%></td>
							</tr>
							<tr>
								<th>주소</th>
								<td></td>
							</tr>
							<tr>
								<th>휴대전화</th>
								<td></td>
							</tr>
							<tr>
								<th>성별</th>
								<td></td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td></td>
							</tr>
							<tr>
								<th>수신 동의</th>
								<td></td>
							</tr>
							<tr>
								<th>가입일자</th>
								<td></td>
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