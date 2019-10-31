<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="mall.Util.Util"%>
<%
	// POST 전송값 가져오기
	request.setCharacterEncoding("UTF-8");
	int kind = Integer.parseInt(request.getParameter("kind")); // 상품 가짓수
	
	// 주문상품 정보를 담을 변수
	String product_code[];
	String size[];
	String Q[];
	int qty[];
	
	// 1개 상품만 바로 구매 또는 1개 상품 선택 구매이더라도 뒤에 , 붙어 오도록 이전페이지에서 Script 작성
	// product_content.jsp 에서 오는 바로구매 값은 , 가 붙어있지 않은데 split(",") 작동에 에러가 없네 ??? 확인 필요
	// → rproduct_content.jsp 에서 , 붙은 값이 넘어오는 걸로  추정 .. 뭐지 
	product_code = request.getParameter("product_code").split(",");
	size = request.getParameter("size").split(",");
	Q = request.getParameter("qty").split(",");
	qty = new int[product_code.length];
	for (int i =0; i<Q.length; i++) {
		qty[i] = Integer.parseInt(Q[i]);
	}
	
	// **** 위시리스트나 장바구니에서 넘어온 상품의 경우, 구매 완료 후 해당 데이터베이스 테이블에서 레코드를 삭제해야 한다 !
	String wish = request.getParameter("wish"); // 맞으면 "y" 아니면 null
	String cart = request.getParameter("cart"); // 맞으면 "y" 아니면 null
	
	// 주문자 정보 디폴트 값
	String username = "";
	String zip = "";
	String address1 = "";
	String address2 = "";
	String cell[] = {"010", "", ""};
	String email[] = {"", ""};
	int point = 0;
	
	// DB 연결		
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 로그인 */
.product_buynow_section {
	margin-bottom: 150px;
}

.product_buynow_section #buynow_main {
	width: 1200px;
	margin: auto;
}

/* 주문서 작성 글자 */
#buynow_header {
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

/* 주문 단계 표시 */
#buynow_stage {
	width: 1200px;
	margin: auto;
	padding: 0;
	display: flex;
	border: 1px solid #eeeeee;
	border-radius: 5px;
}

#buynow_stage div {	
	font-weight: bold;
	font-style: italic;
	width: 300px;
	height: 60px;
	display: flex;
	align-items: center;
	justify-content: center;
}

#buynow_stage div:nth-child(1) {
	background: #B5B5B5;
	color: white;
}

#buynow_stage div:nth-child(2) {
	background: #495164;
	color: white;
}

#buynow_stage div:nth-child(3) {
	background: #FFF8F5;
	color: #B5B5B5;
}

#buynow_stage div:nth-child(4) {
	background: white;
	color: #B5B5B5;
}

/* 국내배송 테이블 */
#table_domestic, .table_userinformation, #payment, #process_payment {
	width: 1200px;
	margin: auto;
	padding: 0;
}

#table_domestic table, .table_userinformation table {
	width: 1200px;
	border-collapse: collapse;
	margin-top: 50px;
}

#table_domestic table caption, .table_userinformation table caption {
	text-align: left;
	font-size: 13px;
	font-weight: bold;
	color: #495164;
	padding: 10px;
}

#table_domestic td, .table_userinformation th, td {
	border: 1px solid #eeeeee;
	height: 30px;
	font-size: 12px;
	color: #515151;
	/* 주문정보 테이블은 별도 지정 */
	text-align: center;
	vertical-align: center;
}

#table_domestic img {
	overflow: hidden;
	border: none;
	border-radius: 50%;
}

/* 테이블 필드명 굵게 */
#table_domestic table .field td {
	font-weight: bold;
}

/* 국내배송 + 주문정보 테이블 헤드 */
#table_domestic .table_head, .table_userinformation .table_head {
	text-align: left;
	padding-left: 10px;
	font-weight: bold;
}

#table_domestic table .table_footer {
	text-align: right;
	padding-right: 10px;
	font-weight: bold;
	height: 50px;
}

/* 주문정보 테이블 텍스트 정렬 */
.table_userinformation td {
	text-align: left;
	vertical-align: center;
	padding: 10px;
}
/* 테이블 여백 */
.space {
	height: 80px;
	border-left: none;
	border-right: none;
}

/* 결제 금액 안내 박스 */

#amount_total {
	color: #FF00FF;
	font-size: 22px;
}

/* 결제수단 선택 박스 grid */
#process_payment {
	display: grid;
	grid-template-columns: 4fr 6fr;
	border: 1px solid #eeeeee;
	margin-top: 10px;
}

#process_payment div {
/* 	border: 1px solid #eeeeee; */
	font-size: 12px;
}

/* 금액 안내 박스 */
.amount_box {
	border: none;
	background: none;
}

input:focus {
	outline: none;
}

/* 결제수단 선택 */

#radio_box {
	padding-top: 20px;
	padding-bottom: 20px;
}

#radio_box input[type=radio], #confirm_box {
	margin-left: 20px;
}
/* 결제수단 선택에 따른 레이어 */
#layer_box .pay_form {
	height: 100px;
	display: none;
}

#layer_box .pay_form:nth-child(1) {
	display: block;
}

#layer_box .pay_form>table, .pay_form>div {
	width: 300px;
	margin: auto;
}
/* 최종 결제 금액 강조 구간 */
#process_payment #amount_pay_emphasis {
	height: 70px;
	font-size: 30px;
	color: #FF8080;
	font-weight: bold;
	letter-spacing: 5px;
	display: flex;
	justify-content: center;
	align-items: center;
}

/* 구매 컨펌 */
#confirm_box {
	height: 60px;
}

/* 최종 submit 버튼 구간 */
#submit_button_box {
	display: flex;
	justify-content: flex-end;
	align-items: center;
}

#submit_button_box input[type=submit] {
	width: 200px;
	height: 70px;
	border: 1px solid #495164;
	border-radius: 5px;
	background: #495164;
	color: white;
	font-size: 25px;
	font-weight: bold;
	cursor: pointer;
	margin-left: 70px;
	margin-right: 30px;
}

/* 버튼 공통 스타일 */
.button {
	height: 50px;
	border: none;
	padding-top: 20px;
	padding-left: 10px;
}

.button input[type=button] {
	width: 120px;
	height: 30px;
	background: #8C8C8C;
	color: white;
	border: 1px solid #8C8C8C;
	border-radius: 5px;
	font-size: 12px;
	font-weight: bold;
	cursor: pointer;
}

/* 주문정보/배송정보 테이블 내 버튼 공통 스타일 */
.zip_button {
	border: 1px solid #495164;
	border-radius: 5px;
	background: #495164;
	color: white;
	font-size: 12px;
	cursor: pointer;
	text-decoration: none;
	padding: 3px;
}

.recipient_button {
	border: 1px solid #495164;
	border-radius: 5px;
	background: none;
	color: #495164;
	font-size: 11px;
	font-weight: bold;
	margin-left: 20px;
	cursor: pointer;
}

</style>
<script src="../Etc/product_buynow.js?ver=4"></script>
<script src="../Etc/common.js"></script>
<!-- daum 도로명주소검색 API 시작 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 우편번호 검색 버튼 클릭하여 함수 호출
	function SearchAddress(i) {
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
	            document.getElementsByClassName("zip")[i].value = data.zonecode; // 우편번호
	            document.getElementsByClassName("address1")[i].value = addr;  // 주소
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementsByClassName("address2")[i].focus();
	        }
	    }).open();
	}
</script>
<!-- 제이쿼리 -->
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function() {
		var kind = <%=kind%>;
		$("#drop_product").click(function() {
			$(".checkbox").each(function(i) {
				if (this.checked) {
					$(".row_product").eq(i).remove();
					kind--; // 상품 삭제시마다 상품가지수 변화주기
				}
				document.getElementsByName("kind")[0].value = kind + "";
			});
		});
	});
</script>
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
						<form action="product_buynow_ok.jsp" method="post" name="order" onsubmit="return Submit()">
							<input type="hidden" name="cart" value="<%=cart%>">
							<input type="hidden" name="wish" value="<%=wish%>">
							<input type="hidden" name="kind" value="<%=kind%>">
							<table>
								<caption>상품 주문내역</caption>
								<tr class="field">
									<td><input type="checkbox" id="checkbox_all" onclick="Check_all(this, <%=kind%>)"></td>
									<td>이미지</td>
									<td>상품정보</td>
									<td>판매가</td>
									<td>수량</td>
									<td>적립포인트</td>
									<td>배송구분</td>
									<td>합계</td>
								</tr>
								<!-- 구매상품 반복문 시작-->
								<%
								// 구매하는 상품 정보를 표시하기 위해 데이터 불러오기
								// 조회할 상품코드
								String ex = "";
								for (int i=0; i<product_code.length; i++) {
									ex = ex + "'" + product_code[i] + "', ";
								}
								int e = ex.lastIndexOf(",");
								ex = ex.substring(0, e);
								
								// select*from table where column in('value', 'value', 'value');
								String sql = "select*from product where product_code in(" + ex + ")";
								ResultSet rs = stmt.executeQuery(sql);
								
								// 모든 상품 구매금액 합계
								int total = 0;
								
								// 반복문 시작
								int i = 0;
								while(rs.next()) {
								%>
								<tr class="row_product">
									<input type="hidden" name="product_code" value="<%=product_code[i]%>">
									<input type="hidden" name="size" value="<%=size[i]%>">
									<input type="hidden" name="qty" value="<%=qty[i]%>">
									<input type="hidden" name="get_point" value="<%=rs.getInt("price")*rs.getInt("point")/100%>">
									<!-- 테이블 열 -->
									<td><input type="checkbox" class="checkbox" onclick="Check_allbox(<%=kind%>)"></td>
									<td><img src="Image/<%=rs.getString("product_list")%>" alt="no img" width="100"></td>
									<td><%=rs.getString("name")%> <p></p> [옵션 : 사이즈 <%=size[i]%>]</td>
									<td><%=Util.comma(rs.getInt("price"))%></td>
									<td><%=qty[i]%></td>
									<!-- 포인트 적립 처리 어떻게 할거 ? input hidden 으로 값 전송-->
									<td><%=Util.comma(rs.getInt("price")*rs.getInt("point")/100)%> p </td>
									<td>국내배송</td>
									<td><%=Util.comma(qty[i] * rs.getInt("price"))%></td>
								</tr>
								<%
									total = total + (qty[i] * rs.getInt("price"));
									i++;
								}
								// 배송료
								int delivery_int;
								if (total >= 70000) {
									delivery_int = 0;
								} else {
									delivery_int = 2500;
								}
								%>
								<!-- 선택상품 전체 + 배송비 합계 -->
								<tr>
									<input type="hidden" name="delivery_fee" value="<%=delivery_int%>">
									<td colspan="9" class="table_footer">상품 금액  <%=Util.comma(total)%> + 배송비 <%=Util.comma(delivery_int)%> = 합계 <%=Util.comma(total + delivery_int)%></td>
								</tr>
							</table>
							<div class="button">
								<input type="button" value="ⓧ 선택상품 삭제" id="drop_product">
								<input type="button" value="이전 페이지" onclick="Back()">
							</div>
							<hr/>
						</div>	
						<!-- 주문자 정보 -->
						<%
							// 로그인 회원정보가 있다면 값 바꿔주기
							if (session.getAttribute("email") != null) {
								sql = "select*from member where email='" + session.getAttribute("email") + "'";
								rs = stmt.executeQuery(sql);
								rs.next();
								// 변수에 회원정보 담기
								username = session.getAttribute("username").toString();
								if (rs.getString("zip") != null) {
									zip = rs.getString("zip");
									address1 = rs.getString("address1");
									address2 = rs.getString("address2");
								}
								if (rs.getString("cell") != null) {
									cell = rs.getString("cell").split("-");								
								}
								String Em[] = rs.getString("email").split("@");
								email[0] = Em[0];
								email[1] = Em[1];
								point = rs.getInt("point");
							}
						%>
						<div class="table_userinformation">
							<table>	
								<caption>주문 정보</caption>
								<tr>
									<th>주문자명 * </th>
									<td>
									<%
									if (session.getAttribute("email") != null) {
									%>
									<input type="text" name="username" value="<%=username%>" readonly>
									<%
									} else {
									%>
									<input type="text" name="username" value="<%=username%>">
									<%
									}
									%>
									</td>
								</tr>
								<tr>
									<th>주소 * </th>
									<td>
										<input type="text" name="address_zip" class="zip" value="<%=zip%>">
										<a href="javascript:SearchAddress(0)" class="zip_button">우편번호 검색</a>
										<p></p>
										<input type="text" name="address_address1" class="address1" value="<%=address1%>"> 기본주소 <p></p>
										<input type="text" name="address_address2" class="address2" value="<%=address2%>"> 나머지 주소
									</td>
								</tr>
								<script>
									function Cell_default() {
										document.getElementById("cell1").value = "<%=cell[0]%>";										
									}
									Cell_default();
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
								<script>
									function Email_default() {
										document.getElementById("email_host_select").value = "<%=email[1]%>";										
									}
									Email_default();
								</script>
								<tr>
									<th>이메일 * </th>
									<td>
										<input type="text" name="email_id" id="email_id" size="7" value="<%=email[0]%>">@
										<input type="text" name="email_host" id="email_host" size="7" value="<%=email[1]%>">
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
										<%
											if (session.getAttribute("email") != null) {
										%>
										<input type="radio" name="same_address" value="2" onclick="Address()">주소록에서 선택
										<%
											}
										%>
									</td>
								</tr>
								<tr>
									<th>받으시는 분 * </th>
									<td><input type="text" name="recipient"></td>
								</tr>
								<tr>
									<th>주소 * </th>
									<td>
										<input type="text" name="r_zip" class="zip">
										<a href="javascript:SearchAddress(0)" class="zip_button">우편번호 검색</a>
										<p></p>
										<input type="text" name="r_address1" class="address1"> 기본주소 <p></p>
										<input type="text" name="r_address2" class="address2"> 나머지 주소
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
								function Exhaust(point) {
									document.getElementById("point").value = "0";
									document.getElementById("use_point").value = comma(point);
									document.form.use_point.value = point + "";
									document.form.amount_discount.value = comma(parseInt(document.form.amount_discount.value) + point);
									document.form.amount_discount_hidden.value = parseInt(document.form.amount_discount_hidden.value) + point;
									
									// 최종 결제금액 !!
									document.form.amount_pay.value = "<%=Util.comma(total + delivery_int - point)%>";
									document.form.amount_pay_hidden.value = "<%=total + delivery_int - point%>";
									document.getElementById("amount_pay_emphasis").innerHTML = "￦ "+"<%=Util.comma(total+ delivery_int - point)%>";
								}
								
								// 입력한 만큼 포인트 사용
								// 코드가 지저분하다.... 뭔가 문제가 있어 ...
								function Use_point(point) {
									// 사용 포인트
									var use = parseInt(document.getElementById("use_point").value);
									// 잔여 포인트
									var left = point - use;
									
									if (left < use) {
										alert("보유 포인트 내에서 사용 가능해요.");
									}
									else {
										document.getElementById("point").value = comma(left); // 콤마표시
										
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
								<%
								// 회원인 경우만 포인트 사용 섹션 표시
								if (session.getAttribute("email") != null) {
								%>
								<tr>
									<th>보유포인트</th>
									<td>
										￦ <input type="text" name="point" id="point" size="5" value="<%=Util.comma(rs.getInt("point"))%>" readonly>
										 <input type="button" value="모두 사용" class="zip_button" onclick="Exhaust(<%=rs.getInt("point")%>)">
									</td>
								</tr>
								<tr>
									<th>사용포인트</th>
									<td>
										￦ <input type="hidden" name="use_point" value="0">
										<input type="text" id="use_point" size="5" value="0" onblur="Use_point(<%=rs.getInt("point")%>)"></div>
									</td>
									<!-- 
									text나 textarea의 경우에는 값을 적고 있을 때에는 onchange로는 값의 변경을 감지할 수 없습니다.
									왜냐하면 onchange 이벤트가 걸리는 시점이 blur(focus와 반대로 오브젝트를 떠나는 시점)이기 때문입니다.
									 -->
								</tr>
								<%
								}
								%>
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
									<%
									if (session.getAttribute("email") != null) {
									%>
									<input type="checkbox" name="pay_keychain" value="1">
									결제수단과 입력정보를 저장하고 다음에도 사용합니다.
									<p></p>
									<%
									}
									%>
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
<%
		stmt.close();
		conn.close();
%>