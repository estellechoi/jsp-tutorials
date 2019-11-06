<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Util.Util"%>
<%
	// ordered 의 id 값 (주문 완료와 함께 id값 GET 전송)
	int e = request.getParameter("id").lastIndexOf(",");
	String id = request.getParameter("id").substring(0, e);
	
	// order_code 값
	String order_code = request.getParameter("order_code");
	
	// DB 연결
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	// ordered, product 2개 테이블의 데이터를 동시에 조회
	// ordered.id 로 조회 / ordered.order_code 로 조회
	String sql = "select*from ordered, product where ordered.product_code = product.product_code and ordered.id in(" + id + ")";
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function Myorder() {
		location = "../Member/myorder.jsp";
	}
	function Signin() {
		location = "../Member/signin.jsp";
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
			<section class="buynow_view_section">
				<div id="buynow_view_header">주문 완료</div>
				<div id="table_ordered">
					<!-- 오더번호 안내 -->
					<table>
						<caption>주문 정보</caption>
						<tr>
							<td width="200px">오더번호</td>
							<td><%=order_code%></td>
						</tr>
					</table>
						<%
							if(session.getAttribute("email") == null) {
						%>
						<div class="alert"> * 비회원 주문 조회를 위해 오더번호를 기억해주세요.</div>
						<%
							}
						%>
					<table>
						<!-- 주문 정보 -->
						<caption>주문 상품 정보</caption>
						<tr>
							<td>이미지</td>
							<td>상품정보</td>
							<td>판매가</td>
							<td>수량</td>
							<td>적립포인트</td>
							<td>배송구분</td>
							<td>합계</td>
						</tr>
						<%
						int total = 0;
						int delivery_fee = 0;
						int pay = 0;
						while (rs.next()) {
						%>
						<tr>
							<td><img src="Image/<%=rs.getString("product_list")%>" alt="no image" width="100" height="100"></td>
							<td><%=rs.getString("name")%> <p></p> [옵션 : 사이즈 <%=rs.getString("size")%> ]</td>
							<td><%=rs.getInt("price")%></td>
							<td><%=rs.getInt("qty")%></td>
							<td><%=Util.comma(rs.getInt("get_point"))%> p </td>
							<td>국내배송</td>
							<td><%=Util.comma(rs.getInt("price")*rs.getInt("qty"))%></td>
						</tr>
						<%
							int amount = rs.getInt("price")*rs.getInt("qty");
							total = total + amount;
							delivery_fee = rs.getInt("delivery_fee");
							pay = rs.getInt("pay");
						}
						%>
						<tr>
							<td colspan="8" class="table_footer">
								<!-- 여기에서 Util.comma() 작동 안하는 이유 ? -->
								상품 금액  <%=Util.comma(total)%> + 배송비 <%=Util.comma(delivery_fee)%> = 합계 <%=Util.comma(total + delivery_fee)%>
							</td>
						</tr>
					</table>
					<!-- 결제 정보 -->
					<table>
						<caption>결제 정보</caption>
						<tr>
							<td width="200px">최종 결제 금액</td>
							<td><%=Util.comma(total)%></td>
						</tr>
						<tr>
							<td>결제 수단</td>
							<%
								String pay_method = "";
								switch(pay) {
									case 0: pay_method = "무통장 입금/계좌이체"; break;
									case 1: pay_method = "카카오 페이"; break;
									case 2: pay_method = "카드 결제"; break;
									default: pay_method = "확인불가";
								}
							%>
							<td><%=pay_method%></td>
						</tr>
					</table>
					<%
						// 주문자 정보와 동일한 배송지를 선택한 경우, 주소록에 주소 자동 추가되도록 설정하지 않으면 아래 쿼리문의 rs 값은 비어 있다.
						// 주문시, ordered table 의 id_address 값도 부여돼야한다.
						sql = "select*from ordered, address where ordered.order_code='" + order_code + "' and address.id = ordered.id_address";
						rs = stmt.executeQuery(sql);
						rs.next();
					%>
					<table>
						<caption>배송지 정보</caption>
						<tr>
							<td>받으시는 분</td>
							<td><%=rs.getString("recipient")%></td>
						</tr>
						<tr>
							<td>우편번호</td>
							<td><%=rs.getString("zip")%></td>
						</tr>
						<tr>
							<td>주소</td>
							<td><%=rs.getString("address1")%> <%=rs.getString("address2")%></td>
						</tr>
						<tr>
							<td>휴대전화</td>
							<td><%=rs.getString("cell")%></td>
						</tr>
						<%
							String r_msg = "";
						 	if (rs.getString("r_msg").equals("")) {
						 		r_msg = "없음";
						 	}
						 	else {
						 		r_msg = rs.getString("r_msg");
						 	}
						%>
						<tr>
							<td>배송 메세지</td>
							<td><%=r_msg%></td>
						</tr>
					</table>
					<div class="button">
						<!-- 추후 링크 걸기 -->
						<input type="button" value="쇼핑 계속하기">
						<%
							if (session.getAttribute("email") != null) {
						%>
						<input type="button" value="전체 주문 보기" onclick="Myorder()">
						<%
							} else {
						%>
						<input type="button" value="주문 조회" onclick="Signin()">
						<%
							}
						%>
					</div>
				</div>
				<!-- footer -->
				<jsp:include page="../footer.jsp" flush="false"/>
			</section>
		</div>
	</div>

</body>
</html>