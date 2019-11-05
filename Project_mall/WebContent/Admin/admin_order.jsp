<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*"%>
 <%@ page import="mall.Jdbc.Connect"%>
<%@ page import="mall.Util.Util"%>
 
 <%
	Connection conn = Connect.connection_static(); // Connect 클래스 connection_static() 리턴함수
	Statement stmt = conn.createStatement();
	
	// 0 ~ 24 인덱스 레코드만 출력하기
	String sql = "select order_code, ordered.product_code, name, product_list, size, qty, delivery_fee, amount_pay, ordered.email, r_msg, ordered.writeday as writeday, status, ordered.id as id from product, ordered where ordered.product_code=product.product_code order by ordered.id desc";
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.product_manage_section {
	height: 900px;
	overflow: scroll;
}

.list_header {
	height: 200px;
	display: flex;
	align-items: center;
	justify-content: center;
/* 	font-family: 'Gill Sans MT Std'; */
	font-weight: 700;
	letter-spacing: 2px;
	font-size: 14px;
	color: #353535;
}
/**/
.list_main {
	display: grid;
	grid-template-columns: 1fr 150px;
}

/* 상품 리스트 테이블 크기 (브라우저 크기에 맞추기) */
table {
	width: 1200px;
	margin: auto;
	border-collapse: collapse;
}

table caption {
	text-align: right;
	padding: 20px;
}

	/* 상품 등록 */
	table caption a {
		text-decoration: none;
		font-size: 12px;
		font-weight: bold;
		color: #495164;
		letter-spacing: 3px;
	}
	table caption a:hover {
		text-decoration: underline;
	}

table td {
	border: 1px solid grey;
	text-align: center;
	padding-top: 5px;
	padding-bottom: 5px;
	color: grey;
	font-size: 13px;
}

table td img {
	border: none;
	border-radius: 50%;
}

table #field td {
	font-weight: bold;
	color: #353535;
}

table td a {
	color: grey;
}

</style>
<script>
	function Status(id, i) {
		var status = document.getElementsByName("status")[i].value;
		location = "admin_order_ok.jsp?id=" + id + "&status=" + status;
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
			<section class="product_manage_section">
				<!-- 대분류 텍스트 -->
				<div class="list_header">MANAGE ORDER</div>
				<div class="list_main">
					<!-- 상품 테이블 -->
					<div>
						<form action="admin_order_ok.jsp" method="post">
							<table>
								<caption><a href="product.jsp">상품등록</a></caption>
								<tr id="field">
									<td>오더번호</td>
									<td>상품코드</td>
									<td>상품명</td>
									<td>이미지</td>
									<td>사이즈</td>
									<td>수량</td>
									<td>배송비</td>
									<td>결제금액</td>
									<td>주문자</td>
									<td>배송 메세지</td>
									<td>주문 날짜</td>
									<td>처리 현황</td>
								</tr>
								<%
								int i = 0;
								while(rs.next()) {
								%>
									<script>
										$(function() {
											document.getElementsByName("status")[<%=i%>].value = "<%=rs.getString("status")%>";										
										});
									</script>
								<tr>
									<td><%=rs.getString("order_code")%></td>
									<td><%=rs.getString("product_code")%></td>
									<td><%=rs.getString("name")%></td>
									<td><img src="../Product/Image/<%=rs.getString("product_list")%>" alt="no image" width="60" height="60"></td>
									<td><%=rs.getString("size")%></td>
									<td><%=rs.getInt("qty")%></td>
									<td><%=Util.comma(rs.getInt("delivery_fee"))%></td>
									<td><%=Util.comma(rs.getInt("amount_pay"))%></td>
									<td><%=rs.getString("email")%></td>
									<td><%=rs.getString("r_msg")%></td>
									<td><%=rs.getString("writeday")%></td>
									<td>
										<select name="status">
											<option value="입금 전">입금 전</option>
											<option value="결제 완료">결제 완료</option>
											<option value="배송 준비">배송 준비</option>
											<option value="배송중">배송중</option>
											<option value="배송 완료">배송 완료</option>
											<option value="반품 접수">반품 접수</option>
											<option value="반품 완료">반품 완료</option>
										</select>
										<a href="javascript:Status(<%=rs.getInt("id")%>, <%=i%>)">저장</a>
									</td>
								</tr>
								<%
									i++;
								}
								%>
							</table>
						</form>
					</div>
					<!-- 관리자용 navigation -->
					<jsp:include page="admin_nav.jsp" flush="false"/>
				</div>
			</section>
		</div>
	</div>
</body>
</html>