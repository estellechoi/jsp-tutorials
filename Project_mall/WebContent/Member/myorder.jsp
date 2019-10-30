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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/myorder.css?ver=6">
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
						// order_code 부터 추출
						// 같은 값은 가진 레코드 개수가 1개 이상인  order_code 레코드 조회 (해당 레코드 필드명: order_code, 레코드 개수: num)
						String sql = "select order_code, count(*) as num from ordered where email='"+session.getAttribute("email")+"'";
						sql = sql + " group by order_code having num >= 1";
						ResultSet rs = stmt.executeQuery(sql);
						
						// 주문 내역이 있다면
						if (rs.next()) {		
							// order_code 의 개수
							rs.last();
							int r = rs.getRow();
							rs.beforeFirst();
							
							// order_code 배열화
							String order_code[] = new String[r];
							for (int i=0; i<order_code.length; i++) {
								rs.next();
								order_code[i] = rs.getString("order_code");
							}
							
							// ordered, product 2개 테이블의 데이터를 동시에 조회 (order_code 별로 조회)
							// MySQL substring(1, 10) 1번째 문자 ~ 10번째 문자까지 추출
							for (int i=0; i<order_code.length; i++) {
								sql = "select ordered.order_code, ordered.id as id_order, substring(ordered.writeday, 1, 10) as writeday, product.id as product_id, product.product_list, product.name, ordered.size as size";
								sql = sql + ", ordered.qty, ordered.amount_buy, product.price, ordered.get_point, ordered.cancel from ordered, product where ordered.email='" + session.getAttribute("email") + "'";
								sql = sql + " and product.product_code = ordered.product_code" + sql_period + " and ordered.order_code='"+ order_code[i] +"'";
								rs = stmt.executeQuery(sql);
								rs.next();
						%>
						<table>
							<caption>
								<b>주문일 <%=rs.getString("writeday")%></b>
								<span id="order_code"><%=order_code[i]%></span>
							</caption>
							<%
								rs.beforeFirst();
								while(rs.next()) {
							%>
							<tr>
								<td><img src="../Product/Image/<%=rs.getString("product_list")%>" alt="no image" width="100" height="100" onclick="Product_content('<%=rs.getString("product_id")%>')"></td>
								<td>
									<b><%=rs.getString("name")%></b><p></p>
									사이즈 : <%=rs.getString("size")%> / 수량 : <%=rs.getString("qty")%> 개<p></p>
									총 <%=Util.comma(rs.getInt("price")*rs.getInt("qty"))%> 원
									<span id="show_get_point"><%=Util.comma(rs.getInt("get_point"))%> p 적립</span>
								</td>
								<td>
									배송중 <p></p>
									<a href="#">배송 조회</a><p></p>
									<%
									if (rs.getString("cancel").equals("na")) {
									%>
									<a href="myorder_cancel.jsp?order_code=<%=order_code[i]%>&id_order=<%=rs.getString("id_order")%>">주문 취소</a>
									<%
									} else {
									%>
									<a href="#">취소 접수</a>
									<%
									}
									%>
								</td>
							</tr>
							<%
								}
							%>
						</table>
						<%
							}
						
	} else {
		

						%>
						<table>
							<caption></caption>
							<tr>
								<td colspan="3">주문 내역이 없습니다.</td>
							</tr>
						</table>
						<%
						
	}					%>
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