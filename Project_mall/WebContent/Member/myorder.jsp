<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Util.Util"%>
<%
	// 조회기간 (0 ~ 5, all)
	String period = request.getParameter("period");
	String sql_period = "";
	
	// MySQL date_sub() date_add()
	// MySQL curdate() : 현재날짜 반환
	if (period == null) {
		sql_period = " and ordered.writeday > date_sub(curdate(), interval 3 month)"; // 기본 3개월
	}
	else if (period.equals("0")) {
		sql_period = " and ordered.writeday > curdate()";
	}
	else if (period.equals("1")) {
		sql_period = " and ordered.writeday > date_sub(curdate(), interval 7 day)";
	}
	else if (period.equals("2")) {
		sql_period = " and ordered.writeday > date_sub(curdate(), interval 1 month)";
	}
	else if (period.equals("3")) {
		sql_period = " and ordered.writeday > date_sub(curdate(), interval 3 month)";
	}
	else if (period.equals("4")) {
		sql_period = " and ordered.writeday > date_sub(curdate(), interval 6 month)";
	}
	else if (period.equals("5")) {
		sql_period = "";
	}
	else if (period.equals("6")) {
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		sql_period = " and ordered.writeday >= '" + start + "' and ordered.writeday <= date_add('" + end + "', interval 1 day)";
	} // interval 1 day 왜 필요하지 ?? 선택한 날짜의 다음날 00:00 까지 포함하기 위해서 !

	// DB 연결
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	// ordered, product 2개 테이블의 데이터를 동시에 조회
	// MySQL substring(1, 10) 1번째 문자 ~ 10번째 문자까지 추출
	String sql = "select ordered.id, substring(ordered.writeday, 1, 10) as writeday, product.id as product_id, product.product_list, product.name, ordered.size";
	sql = sql + ", ordered.qty, ordered.amount_buy, product.price from ordered, product where ordered.email='" + session.getAttribute("email") + "'";
	sql = sql + " and product.product_code = ordered.product_code" + sql_period + " order by writeday desc";
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/myorder.css?ver=3">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script>
	function Period_order(n) {
		if (n < 6) {
			location = "myorder.jsp?period="+n;
		}
		else {
			var start = document.getElementById("start").value;
			var end = document.getElementById("end").value;
			location = "myorder.jsp?period=6&start=" + start + "&end=" + end;		
		}
	}
	
	$(function() {
		$("#start").datepicker({
			dateFormat: "yy-mm-dd"
		});
		$("#end").datepicker({
			dateFormat: "yy-mm-dd"
		});
	});
	
	function Product_content(id) {
		location = "../Product/product_content.jsp?id=" + id;
	}
</script>
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div> 
		<div id="grid_right">
			<section class="myorder_section">
				<div id="myorder_header">MY ORDER</div>
				<div class="account_grid_container">
					<div class="account_grid_left">
						<ul>
							<li onclick="Period_order(0)">오늘</li>
							<li onclick="Period_order(1)">1주일</li>
							<li onclick="Period_order(2)">1개월</li>
							<li onclick="Period_order(3)">3개월</li>
							<li onclick="Period_order(4)">6개월</li>
							<li onclick="Period_order(5)">전체</li>
						</ul>
						<div id="period_controller">
							<input type="text" name="start" id="start"> ~
							<input type="text" name="end" id="end">
							<input type="button" value="조회" onclick="Period_order(6)">
						</div>
						<%
							while(rs.next()) {
						%>
						<table>
							<caption>주문일 <%=rs.getString("writeday")%></caption>
							<tr>
								<td><img src="../Product/Image/<%=rs.getString("product_list")%>" alt="no image" width="100" onclick="Product_content('<%=rs.getString("product_id")%>')"></td>
								<td>
									<%=rs.getString("name")%><p></p>
									<%=Util.comma(rs.getInt("amount_buy"))%> 원 <p></p>
									<%=rs.getString("qty")%> 개
								</td>
								<td>
									배송중 <p></p>
									<a href="#">배송 조회</a><p></p>
									<a href="#">주문 취소</a>
								</td>
							</tr>
						</table>
						<%
							}
						%>
					</div>
					<!-- ACCOUNT 페이지 메뉴 네비게이션바 -->
					<div class="account_grid_right">
						<jsp:include page="account_nav.jsp" flush="false"/>
					</div>
			</section>
			
		</div>
	</div>

</body>
</html>