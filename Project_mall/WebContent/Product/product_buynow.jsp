<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.text.DecimalFormat"%>
<%

	// **** 위시리스트나 장바구니에서 넘어온 상품의 경우, 구매 완료 후 해당 데이터베이스 테이블에서 레코드를 삭제해야 한다 !

	request.setCharacterEncoding("UTF-8");
	// 바로 구매
	String product_code = request.getParameter("product_code");
	String size = request.getParameter("size");
	int qty = Integer.parseInt(request.getParameter("qty"));
	
	if (session.getAttribute("email") != null) {
			
		Connection conn = Connect.connection_static();
		Statement stmt = conn.createStatement();
		
		// product table
		// 바로 구매 버튼 클릭시 상품수
		int n = 1;
		
		// 바로 구매 데이터 요청 쿼리
		String sql = "select*from product where product_code='" + product_code + "'";
		ResultSet rs = stmt.executeQuery(sql);
		rs.next();
		
		// 금액 표시 객체
		DecimalFormat df = new DecimalFormat("#,###");
		
		// 사이즈 텍스트 변환
		switch(size) {
			case "0": size = "선택"; break;
			case "1": size = "XS"; break;
			case "2": size = "S"; break;
			case "3": size = "M"; break;
			case "4": size = "L"; break;
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/product_buynow.css?ver=4">
<script src="../Etc/product_buynow.js"></script>
<script src="../Etc/common.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- daum 도로명주소검색 API 시작 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 우편번호 검색 버튼 클릭하여 함수 호출
	function SearchAddress() {
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
</head>
<body onload="Member()">
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
						<form action="product_buynow_ok.jsp" method="post" name="form" onsubmit="return Submit()">
							<input type="hidden" name="product_code" value="<%=product_code%>">
							<input type="hidden" name="size" value="<%=size%>">
							<input type="hidden" name="qty" value="<%=qty%>">
							<input type="hidden" name="get_point" value="<%=rs.getInt("price")*rs.getInt("point")/100%>">
							<input type="hidden" name="email" value="<%=session.getAttribute("email")%>">
							<table>
								<tr>
									<td colspan="9" class="table_head">국내배송 상품 주문내역</td>
								</tr>
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
								<!-- 구매상품 반복문 -->
								<%
								
								// total 총계 (모든 상품들의 금액 합), amount 상품금액 (상품수 * 가격)
								int total = 0;
								int amount = 0;
								
								// 배송료
								int delivery_int;
								String delivery_str = "";
								
								// 장바구니에서 선택한 상품들 반복문 시작 
								amount = qty * rs.getInt("price");
								total = total + amount;
								%>
								<tr>
									<td><input type="checkbox" class="checkbox" onclick="Check_allbox(<%=n%>)"></td>
									<td><img src="Image/<%=rs.getString("product_list")%>" alt="no img" width="100"></td>
									<td><%=rs.getString("name")%> <p></p> [옵션 : 사이즈 <%=size%>]</td>
									<td><%=df.format(rs.getInt("price"))%></td>
									<td><%=qty%></td>
									<!-- 포인트 적립 처리 어떻게 할거 ? input hidden 으로 값 전송-->
									<td><%=df.format(rs.getInt("price")*rs.getInt("point")/100)%></td>
									<td>일반배송</td>
									<td> <!-- 배송비 -->
									<%			
									// 전체 상품 구매 금액 합계에 따라 배송비가 결정되는데, 각 상품 반복문 내에서 어떻게 배송비를 표시하지 ?
										if (total >= 70000) {
											delivery_int = 0;
											delivery_str = "무료";
										} else {
											delivery_int = 2500;
											delivery_str = "차등";
										}
									%>
									<%=delivery_str%>
									</td>
									<td><%=df.format(amount)%></td>
								</tr>
								<!-- 반복문 종료 -->
								<!-- 선택상품 전체 + 배송비 합계 -->
								<tr>
									<input type="hidden" name="delivery_fee" value="<%=delivery_int%>">
									<td colspan="9" class="table_footer">상품 금액  <%=df.format(total) %> + 배송비 <%=df.format(delivery_int)%> = 합계 <%=df.format(total + delivery_int)%></td>
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
							String sql_m = "select*from member where email='" + session.getAttribute("email") + "'";
							ResultSet rs_m = stmt.executeQuery(sql_m);
							rs_m.next();
						%>
						<div class="table_userinformation">
							<table>	
								<tr>
									<td colspan="2" class="table_head">주문 정보</td>
								</tr>
								<tr>
									<th>주문자명 * </th>
									<td><input type="text" name="username" value="<%=session.getAttribute("username")%>" readonly></td>
								</tr>
								<%
								// 1) 주소 정보가 있는 회원의 경우
								if (rs_m.getInt("zip") != 0) {
								%>
								<tr>
									<th>주소 * </th>
									<td>
										<input type="text" name="zip" value="<%=rs_m.getString("zip")%>"><p></p>
										<input type="text" name="address1" value="<%=rs_m.getString("address1")%>"> 기본주소 <p></p>
										<input type="text" name="address2" value="<%=rs_m.getString("address2")%>"> 나머지 주소
									</td>
								</tr>
								<%
								// 2) 주소 정보가 없는 회원
								} else {
								%>
								<tr>
									<th>주소 * </th>
									<td>
										<input type="text" name="zip">
										<input type="button" value="우편번호 검색" class="zip_button"> <p></p>
										<input type="text" name="address1"> 기본주소 <p></p>
										<input type="text" name="address2"> 나머지 주소
									</td>
								</tr>				
								<%
								}
								
								if (rs_m.getString("cell") != null) {
									String cell = rs_m.getString("cell");
									String cellSplit[] = cell.split("-");
								%>
								<script>
									document.getElementById("cell1").value = "<%=cellSplit[0]%>";
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
										<input type="text" name="cell2" size="5" value="<%=cellSplit[1]%>">-
										<input type="text" name="cell3" size="5" value="<%=cellSplit[2]%>">
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
								<!-- 여백 -->
								<tr>
									<td colspan="2" class="space"></td>
								</tr>
								<!-- 배송 정보 -->
								<tr>
									<td colspan="2" class="table_head">배송 정보</td>
								</tr>
								<tr>
									<th>배송지 선택</th>
									<td>
										<input type="hidden" name="id_address"><!-- address table 에 레코드가 있다면 그 id 값을 부여 -->
										<input type="radio" name="recipient" value="0" onclick="Recipient(1)">주문자 정보와 동일
										<input type="radio" name="recipient" value="1" onclick="Recipient(2)" checked>새로운 배송지
										<input type="button" value=" > 즐겨찾기에서 선택" class="recipient_button" onclick="Address()">
									</td>
								</tr>
								<tr>
									<th>받으시는 분 * </th>
									<td><input type="text" name="r_username"></td>
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
								<!-- 여백 -->
								<tr>
									<td colspan="2" class="space"></td>
								</tr>
								<!-- 결제 정보 -->
								<tr>
									<td colspan="2" class="table_head">결제 정보</td>
								</tr>
								<!-- 포인트 사용 (로그인 정보) -->
								<script>
								// 콤마표시 정규식
								function comma(x) {
								    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
								}
								
								// 보유포인트 모두사용
								function Exhaust() {
									document.getElementById("point").value = "0";
									document.getElementById("use_point").value = "<%=df.format(rs_m.getInt("point"))%>";
									document.form.amount_discount.value = "<%=df.format(rs_m.getInt("point"))%>";
									document.form.amount_discount_hidden.value = "<%=rs_m.getInt("point")%>";
									
									// 최종 결제금액 !!
									document.form.amount_pay.value = "<%=df.format(total + delivery_int - rs_m.getInt("point"))%>";
									document.form.amount_pay_hidden.value = "<%=total + delivery_int - rs_m.getInt("point")%>";
									document.getElementById("amount_pay_emphasis").innerHTML = "￦ "+"<%=df.format(total + delivery_int - rs_m.getInt("point"))%>";
								}
								
								// 입력한 만큼 포인트 사용
								// 코드가 지저분하다.... 뭔가 문제가 있어 ...
								function Use_point() {
									// 사용 포인트
									var use = parseInt(document.getElementById("use_point").value);
									// 잔여 포인트
									var point = <%=rs_m.getInt("point")%> - use;
									
									if (<%=rs_m.getInt("point")%> < use) {
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
										￦ <input type="text" name="point" id="point" size="5" value="<%=df.format(rs_m.getInt("point"))%>" readonly>
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
										<input class="amount_box" type="text" name="amount_buy" readonly value="<%=df.format(total + delivery_int)%>">
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
										<input class="amount_box" type="text" name="amount_pay" readonly value="<%=df.format(total + delivery_int)%>">
									</td>
								</tr>
								<!-- 여백 -->
								<tr>
									<td colspan="2" class="space"></td>
								</tr>								
							</table>
						</div>
					</div>
					<!-- 결제 수단 선택 및 결제 진행  grid -->
					<div id="process_payment">
							<div>
								<div id="radio_box">
									<input type="radio" name="pay" value="0" onclick="Pay_form(0)" checked>무통장 입금/계좌이체
									<input type="radio" name="pay" value="2" onclick="Pay_form(1)">카카오페이
									<input type="radio" name="pay" value="3" onclick="Pay_form(2)">카드결제
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
								<div id="amount_pay_emphasis">￦ <%=df.format(total + delivery_int)%></div>
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
<%
		stmt.close();
		conn.close();
	} else {
		response.sendRedirect("product_buynow_nonmember.jsp?product_code="+product_code+"&size="+size+"&qty="+qty);
	}
%>