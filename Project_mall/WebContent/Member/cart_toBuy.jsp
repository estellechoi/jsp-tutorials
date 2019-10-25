<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Util.Util"%>
<%
	// request 전송값 가져오기
	request.setCharacterEncoding("UTF-8");
	String product_code[] = request.getParameter("product_code").split(",");
	String size[] = request.getParameter("size").split(",");
	String Q[] = request.getParameter("qty").split(",");
	// 자바에서 split 했을 때 공백은 배열의 요소에 포함되나 ? 테스트결과, 아닌듯
	
	// 수량 int 변환
	int qty[] = new int[Q.length];
	for (int i=0; i<Q.length; i++) {
		qty[i] = Integer.parseInt(Q[i]);
	}
	
	// 주문상품 가짓수
	int n = product_code.length;
	
	// DB 연결
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/product_buynow.css?ver=1">
<script src="../Etc/product_buynow.js"></script>
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div>
		<div id="grid_right">
			<section class="product_buynow_section">
				<div class="buynow_main">
					<!-- 타이틀 표시 및 주문 단계 그래프 -->
					<div id="buynow_header">주문서 작성</div>
					<div id="buynow_stage">
						<div>1 장바구니</div>
						<div>2 주문서 작성</div>
						<div>3 결제 완료</div>
						<div>4 주문 완료</div>
					</div>
					
					<!-- 국내배송 주문서 -->
					<div id="table_domestic">
						<form action="cart_toBuy_ok" method="post" name="order" onsubmit="return Submit()">
							<input type="hidden" name="IfFromCart" value="<%=request.getParameter("IfFromCart")%>">
							<table>
								<caption>상품 주문내역</caption>
								<tr class="field">
									<td><input type="checkbox" id="checkbox_all" onclick="Check_all(this, <%=n%>)"></td>
									<td>이미지</td>
									<td>상품정보</td>
									<td>판매가</td>
									<td>수량</td>
									<td>적립포인트</td>
									<td>배송구분</td>
									<td>배송비</td>
									<td>합계</td>
								</tr>
								<%									
									int total = 0;
									int delivery_int = 2500;
									String delivery_str = "차등";
									
									// 구매 상품별 반복문
									// 인덱스 i 별로 각 상품에 대한 정보, size[i], qty[i]
									for (int i = 0; i < n; i++) {
										String sql = "select*from product where product_code='" + product_code[i] + "'";
										ResultSet rs = stmt.executeQuery(sql);
										rs.next();
										int amount = rs.getInt("price") * qty[i];
										total = total + amount;
								%>
								<input type="hidden" name="product_code" value="<%=product_code[i]%>">
								<input type="hidden" name="size" value="<%=size[i]%>">
								<input type="hidden" name="qty" value="<%=qty[i]%>">
								<input type="hidden" name="get_point" value="<%=rs.getInt("point")%>">
								<tr>
									<td><input type="checkbox" class="checkbox" onclick="Check_allbox(<%=n%>)"></td>
									<td><img src="../Product/Image/<%=rs.getString("product_list")%>" alt="no img" width="100" height="100"></td>
									<td><%=rs.getString("name")%> <p></p> [옵션 : 사이즈 <%=size[i]%>]</td>
									<td><%=Util.comma(rs.getInt("price"))%></td>
									<td><%=qty[i]%></td>
									<!-- 포인트 적립 처리 어떻게 할거 ? input hidden 으로 값 전송-->
									<td><%=Util.comma(rs.getInt("price")*rs.getInt("point")/100)%> p </td>
									<td>국내배송</td>
									<td>배송비</td>
									<td><%=Util.comma(amount)%></td>
								</tr>
								<%
									}
									
									// 상품별 반복문 종료
									
									// 배송비 결정
									if (total >= 70000) {
										delivery_int = 0;
										delivery_str = "무료";
									}
								%>
								<!-- 선택상품 전체 + 배송비 합계 -->
								<tr>
									<input type="hidden" name="delivery_fee" value="<%=delivery_int%>">
									<td colspan="9" class="table_footer">상품 금액  <%=Util.comma(total)%> + 배송비 <%=Util.comma(delivery_int)%> = 합계 <%=Util.comma(total + delivery_int)%></td>
								</tr>
							</table>
							<div class="button">
								<input type="button" value="ⓧ 선택상품 삭제" onclick="Drop_product()">
								<input type="button" value="이전 페이지" onclick="Back()">
							</div>
							<hr/>
						</div>
						
						<!-- 주문자 정보 -->
						<!-- 로그인 회원정보 가져와서 표시하기 해야함 -->
						<%
							// member table
							String sql = "select*from member where email='" + session.getAttribute("email") + "'";
							ResultSet rs = stmt.executeQuery(sql);
							rs.next();
						%>
						<div class="table_userinformation">
							<table>	
								<caption>주문 정보</caption>
								<tr>
									<th>주문자명 * </th>
									<td><input type="text" name="username" value="<%=session.getAttribute("username")%>" readonly></td>
								</tr>
								<tr>
									<th>주소 * </th>
									<td>
									<%
									// 1) 주소 정보가 있는 회원의 경우
									if (rs.getString("zip") != null) {
									%>
										<input type="text" name="address_zip" value="<%=rs.getString("zip")%>"><p></p>
										<input type="text" name="address_address1" value="<%=rs.getString("address1")%>"> 기본주소 <p></p>
										<input type="text" name="address_address2" value="<%=rs.getString("address2")%>"> 나머지 주소
									<%
									// 2) 주소 정보가 없는 회원
									} else {
									%>
										<input type="text" name="address_zip">
										<input type="button" value="우편번호 검색" class="zip_button"> <p></p>
										<input type="text" name="address_address1"> 기본주소 <p></p>
										<input type="text" name="address_address2"> 나머지 주소			
									<%
									}
									%>
									</td>
								</tr>	
								<%
								
								if (rs.getString("cell") != null) {
									String cell[] = rs.getString("cell").split("-");
								%>
								<script>
									document.getElementById("cell1").value = "<%=cell[0]%>";
								</script>
								<tr>
									<th>휴대전화 * </th>
									<td>
										<select name="cell1" id="cell1">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select>-
										<input type="text" name="cell2" size="5" value="<%=cell[1]%>">-
										<input type="text" name="cell3" size="5" value="<%=cell[2]%>">
									</td>
								</tr>
								<%
								} else {
								%>
								<tr>
									<th>휴대전화 * </th>
									<td>
										<select name="cell1" id="cell1">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select>-
										<input type="text" name="cell2" size="5">-
										<input type="text" name="cell3" size="5">
									</td>
								</tr>								
								<%
								}
								
								// 이메일
								String email = session.getAttribute("email") + "";
								String emailSplit[] = email.split("@");
								%>
								<script>
									document.getElementById("email_host_select").value = "<%=emailSplit[1]%>";
								</script>
								<tr>
									<th>이메일 * </th>
									<td>
										<input type="text" name="email_id" id="email_id" size="7" value="<%=emailSplit[0]%>">@
										<input type="text" name="email_host" id="email_host" size="7" value="<%=emailSplit[1]%>">
										<select name="email_host_select" id="email_host_select" onchange="Email(this.value)">
											<option value="직접입력">직접입력</option>
											<option value="naver.com">naver.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="daum.net">daum.net</option>
											<option value="yahoo.com">yahoo.com</option>
											<option value="outlook.com">outlook.com</option>
										</select>
									</td>
								</tr>
							</table>
							<table>
								<!-- 배송 정보 -->
								<caption>배송 정보</caption>
								<tr>
									<th>배송지 선택</th>
									<td>
										<input type="hidden" name="id_address"><!-- address table 에 레코드가 있다면 그 id 값을 부여 -->
										<input type="radio" name="same_address" value="0" onclick="Delivery(this.value)">주문자 정보와 동일
										<input type="radio" name="same_address" value="1" onclick="Delivery(this.value)" checked>새로운 배송지
										<input type="radio" name="same_address" value="2" onclick="Address()">주소록에서 선택
									</td>
								</tr>
								<tr>
									<th>받으시는 분 * </th>
									<td><input type="text" name="recipient"></td>
								</tr>
								<tr>
									<th>주소 * </th>
									<td>
										<input type="text" name="r_zip" id="zip">
										<input type="button" value="우편번호 검색" class="zip_button" onclick="SearchAddress()"> <p></p>
										<input type="text" name="r_address1" id="address1"> 기본주소 <p></p>
										<input type="text" name="r_address2" id="address2"> 나머지 주소
									</td>
								</tr>
								<tr>
									<th>수령인 휴대전화 * </th>
									<td>
										<select name="r_cell1" id="r_cell1">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select>-
										<input type="text" name="r_cell2" size="5">-
										<input type="text" name="r_cell3" size="5">
									</td>
								</tr>
								<tr>
									<th>배송 메세지</th>
									<td><textarea name="r_msg" cols="40" rows="3"></textarea></td>
								</tr>
							</table>
							<table>
								<!-- 결제 정보 -->
								<caption>결제 정보</caption>
								<!-- 포인트 사용 (로그인 정보) -->
								<script>
								// 콤마표시 정규식
								function comma(x) {
								    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
								}
								
								// 보유포인트 모두사용
								function Exhaust() {
									document.getElementById("point").value = "0";
									document.getElementById("use_point").value = "<%=Util.comma(rs.getInt("point"))%>";
									document.form.amount_discount.value = "<%=Util.comma(rs.getInt("point"))%>";
									document.form.amount_discount_hidden.value = "<%=rs.getInt("point")%>";
									
									// 최종 결제금액 !!
									document.form.amount_pay.value = "<%=Util.comma(total + delivery_int - rs.getInt("point"))%>";
									document.form.amount_pay_hidden.value = "<%=total + delivery_int - rs.getInt("point")%>";
									document.getElementById("amount_pay_emphasis").innerHTML = "￦ "+"<%=Util.comma(total + delivery_int - rs.getInt("point"))%>";
								}
								
								// 입력한 만큼 포인트 사용
								// 코드가 지저분하다.... 뭔가 문제가 있어 ...
								function Use_point() {
									// 사용 포인트
									var use = parseInt(document.getElementById("use_point").value);
									// 잔여 포인트
									var point = <%=rs.getInt("point")%> - use;
									
									if (<%=rs.getInt("point")%> < use) {
										alert("보유 포인트 내에서 사용 가능해요.");
									}
									else {
										document.getElementById("point").value = comma(point); // 콤마표시
										
										// 할인 금액 = 사용 포인트
										document.form.amount_discount.value = comma(use);
										document.form.amount_discount_hidden.value = use + "";
										
										// 최종 결제금액 !!
										var x = <%=total + delivery_int%> - use;
										document.form.amount_pay.value = comma(x);
										document.form.amount_pay_hidden.value = x;
										document.getElementById("amount_pay_emphasis").innerHTML = "￦ "+ comma(x);
									}
								}
								</script>
								<tr>
									<th>보유포인트</th>
									<td>
										￦ <input type="text" name="point" id="point" size="5" value="<%=Util.comma(rs.getInt("point"))%>" readonly>
										 <input type="button" value="모두 사용" class="zip_button" onclick="Exhaust()">
									</td>
								</tr>
								<tr>
									<th>사용포인트</th>
									<td>￦ <input type="text" id="use_point" size="5" value="0" onblur="Use_point()"></div></td>
									<!-- 
									text나 textarea의 경우에는 값을 적고 있을 때에는 onchange로는 값의 변경을 감지할 수 없습니다.
									왜냐하면 onchange 이벤트가 걸리는 시점이 blur(focus와 반대로 오브젝트를 떠나는 시점)이기 때문입니다.
									 -->
								</tr>
								<tr>
									<th>합계 금액</th>
									<td>
										￦ <input type="hidden" name="amount_buy_hidden" value="<%=total + delivery_int%>">
										<input class="amount_box" type="text" name="amount_buy" readonly value="<%=Util.comma(total + delivery_int)%>">
									</td>
								</tr>
								<tr>
									<!-- 이거 어떡하지 ? -->
									<th>할인 금액</th>
									<td>
										￦ <input type="hidden" name="amount_discount_hidden" value="0">
										<input class="amount_box" type="text" name="amount_discount" readonly value="0">
									</td>
								</tr>
								<tr>
									<th>결제 금액</th>
									<td>
										￦ <input type="hidden" name="amount_pay_hidden" value="<%=total + delivery_int%>">
										<input class="amount_box" type="text" name="amount_pay" readonly value="<%=Util.comma(total + delivery_int)%>">
									</td>
								</tr>
							</table>
						</div>
					</div>
					<!-- 결제 수단 선택 및 결제 진행  grid -->
					<div id="process_payment">
							<div>
								<div id="radio_box">
									<input type="radio" name="pay" value="0" onclick="Pay_form(0)" checked>무통장 입금/계좌이체
									<input type="radio" name="pay" value="1" onclick="Pay_form(1)">카카오페이
									<input type="radio" name="pay" value="2" onclick="Pay_form(2)">카드결제
								</div>
								<div id="layer_box">
											<!-- 무통장입금/계좌이체 -->
											<div class="pay_form">
												<table>
												 <tr>
												 	<td>입금자명</td>
												 	<td><input type="text" name="sender"></td>
												 </tr>
												 <tr>
												 	<td>입금 계좌</td>
												 	<td>우리은행 1005-003-000000</td>
												 </tr>
												</table>
											</div>
											<!-- 카카오페이 -->
											<div class="pay_form">
												<div>카카오 송금 서비스를 이용합니다.</div>
											</div>
											<!-- 카드결제 -->
											<div class="pay_form">
												<div>무이자할부를 원하시는 경우 장바구니에서 무이자할부 상품만 선택하여 주문하여 주시기 바랍니다.</div>
											</div>
								</div>
								<div id="confirm_box">
									<input type="checkbox" name="pay_keychain" value="1">
									결제수단과 입력정보를 저장하고 다음에도 사용합니다.
									<p></p>
									<input type="checkbox" name="confirm" value="1">
									결제정보를 확인하였으며, 구매 진행에 동의합니다.
								</div>
							</div>
							<div id="submit_button_box">
								<div id="amount_pay_emphasis">￦ <%=Util.comma(total + delivery_int)%></div>
								<input type="submit" value="결제하기">
							</div>
						</div>
					</form>
				</div>
			</section>
		</div>
	</div>
</body>
</html>