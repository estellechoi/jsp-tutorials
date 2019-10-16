<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	// table ordered 의 id (주문 완료와 함께 id값 GET 전송)
	String id = request.getParameter("id");

	// DB 연결
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	// ordered, product 2개 테이블의 데이터를 동시에 조회
	String sql = "select*from ordered, product where ordered.product_code = product.product_code and ordered.id=" + id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	
	// 금액 표시 객체
	DecimalFormat df = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/product_buynow_view.css?after">
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
					<table>
						<caption>결제 정보</caption>
						<tr>
							<td width="200px">최종 결제 금액</td>
							<td><%=rs.getString("amount_pay")%></td>
						</tr>
						<tr>
							<td>결제 수단</td>
							<%
								String pay = "";
								switch(rs.getInt("pay")) {
									case 0: pay = "무통장 입금/계좌이체"; break;
									case 1: pay = "카카오 페이"; break;
									case 2: pay = "카드 결제"; break;
									default: pay = "확인불가";
								}
							%>
							<td><%=pay%></td>
						</tr>
					</table>
					<table>
						<caption>주문 상품 정보</caption>
						<tr>
							<td>이미지</td>
							<td>상품정보</td>
							<td>판매가</td>
							<td>수량</td>
							<td>적립포인트</td>
							<td>배송구분</td>
							<td>배송비</td>
							<td>합계</td>
						</tr>
						<!-- 주문상품 반복문으로 추후 수정 -->
						<tr>
							<td><img src="Image/<%=rs.getString("product_list")%>" alt="no image" width="100"></td>
							<td><%=rs.getString("name")%> <p></p> [옵션 : 사이즈 <%=rs.getString("size")%> ]</td>
							<td><%=rs.getInt("price")%></td>
							<td><%=rs.getInt("qty")%></td>
							<td><%=rs.getInt("get_point")%></td>
							<td>일반배송</td>
							<%
								String delivery_str = "무료";
								if (rs.getInt("delivery_fee") != 0) {
									delivery_str = "차등";
								}
							%>
							<td><%=delivery_str%></td>
							<td><%=rs.getInt("price")*rs.getInt("qty")%></td>
						</tr>
						<tr>
							<td colspan="8" class="table_footer">
								상품 금액  <%=df.format(rs.getInt("price")*rs.getInt("qty"))%> + 배송비 <%=df.format(rs.getInt("delivery_fee"))%> = 합계 <%=df.format(rs.getInt("price")*rs.getInt("qty") + rs.getInt("delivery_fee"))%>
							</td>
						</tr>
					</table>
					<%
						sql = "select*from ordered, address where ordered.id=" + id + " and address.id = ordered.id_address";
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
							<td><%=rs.getInt("zip")%></td>
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
						<input type="button" value="주문 상세 보기">
					</div>
				</div>
			</section>
		</div>
	</div>

</body>
</html>