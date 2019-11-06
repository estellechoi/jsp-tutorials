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
<script src="../Etc/product_buynow.js?ver=6"></script>
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
<!-- daum 도로명주소검색 API 끝 -->
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
<style>
	div {
		width: 1000px;
		margin: auto;
		padding-bottom: 50px;
		text-align: center;
	}
	
	#page_header {
		padding-top: 100px;
		padding-bottom: 100px;
		font-size: 20px;
		font-weight: bold;
		color: #555555;
		letter-spacing: 5px;
	}
		
	.article_top table {
		width: 1000px;
	}
	.article_top table td {
		border-bottom: 1px solid #eeeeee;
	}
	.article_middle {
		display: flex;
	}
	.article_middle table {
		width: 470px;
		margin: auto;
	}	
	.article_bottom table {
		width: 1000px;
	}
	
	/* 테이블 공통 */
	caption {
		text-align: left;
		padding:30px;
		border-bottom: 1px solid #eeeeee;
	}
	
	table img {
		border: none;
		border-radius: 50%;
		margin-top: 10px;
		margin-bottom: 10px;
	}
	
	table th, td {
		color: #555555;
		font-size: 14px;
		height: 40px;
		text-align: center;
		letter-spacing: 2px;
		padding: 5px;
	}
	table .show_amount {
		text-align: right;
		padding-right: 30px;
	}

	/* 주문자&배송지 정보 */
	.article_middle table th {
		width: 150px;
	}
	.article_middle table td {
		text-align: left;
	}
	
	.article_bottom table td {
		text-align: left;		
	}
	
	/* 입력란 공통 */
	input[type=text] {
		height: 35px;
		padding-left: 10px;
		padding-right: 10px;
		width: 240px;
	}
	.address input[type=text]:nth-child(1) {
		width: 80px;
	}	
	.cell input[type=text] {
		width: 60px;
	}
	.email input[type=text] {
		width: 90px;
	}
	
	/* submit 버튼 공통 */	
	.button_submit {
		border: 2px solid #303030;
		background: #303030;
		color: white;
		font-weight: bold;
		width: 200px;
		height: 50px;
	}
	
	.button_submit:hover {
		background: white;
		color: #303030;
	}
</style>
</head>
<body>
	<section>
		<div id="page_header">BUY NOW</div>
		<article>
			<form action="product_buynow_ok.jsp" method="post" name="order" onsubmit="return Submit()">
				<input type="hidden" name="cart" value="<%=cart%>">
				<input type="hidden" name="wish" value="<%=wish%>">
				<input type="hidden" name="kind" value="<%=kind%>">
				<!-- 1)상품정보 -->
				<div class="article_top">
					<table>
						<caption>상품 정보</caption>
						<tr>
							<td colspan="2">상품정보</td>
							<td>수량</td>
							<td>금액 (￦)</td>
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
							// 적립 포인트
							int points = 0;
							
							// 반복문 시작
							int i = 0;
							while(rs.next()) {
							%>
						<tr>
							<input type="hidden" name="product_code" value="<%=product_code[i]%>">
							<input type="hidden" name="size" value="<%=size[i]%>">
							<input type="hidden" name="qty" value="<%=qty[i]%>">
							<input type="hidden" name="get_point" value="<%=rs.getInt("price")*rs.getInt("point")/100%>">
							<!-- 주문상품 테이블 -->
							<td><img src="Image/<%=rs.getString("product_list")%>" alt="no img" width="100" height="100"></td>
							<td><%=rs.getString("name")%> <p></p> [옵션 : 사이즈 <%=size[i]%>]</td>
							<td><%=qty[i]%></td>
							<td class="show_amount"><%=Util.comma(qty[i] * rs.getInt("price"))%></td>
						</tr>
							<%
								total = total + (qty[i] * rs.getInt("price"));
								points = total * rs.getInt("point") / 100;
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
						<tr>
							<td colspan="2"></td>
							<td>상품 합계</td>
							<td class="show_amount"><%=Util.comma(total)%></td>
						</tr>
						<tr>
							<td colspan="2"></td>
							<td>배송비</td>
							<td class="show_amount"><%=Util.comma(delivery_int)%></td>
						</tr>
						<tr>
							<td colspan="2"></td>
							<td>총 합계</td>
							<td class="show_amount"><%=Util.comma(total + delivery_int)%></td>
						</tr>
					</table>
				</div>
				<!-- 상품정보 끝 ! -->
				
				<!-- 2)주문자정보 & 배송정보 -->
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
				<!-- display: grid -->
				<div class="article_middle">
					<!-- 1-1)주문자 정보 -->
					<table>
						<caption>주문자 정보</caption>
						<!-- 이름 -->
						<tr>
							<th>이름 * </th>
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
						<!-- 주소 -->
						<tr>
							<th>주소 * </th>
							<td class="address">
								<input type="text" name="address_zip" class="zip" value="<%=zip%>">
								<a href="javascript:SearchAddress(0)" class="zip_button">우편번호 검색</a>
								<p></p>
								<input type="text" name="address_address1" class="address1" value="<%=address1%>"><p></p>
								<input type="text" name="address_address2" class="address2" value="<%=address2%>">								
							</td>
						</tr>
						<!-- 휴대전화 -->
						<tr>
							<th>휴대전화 * </th>
							<td class="cell">
								<input type="text" name="cell1" value="<%=cell[0]%>">
								<input type="text" name="cell2" value="<%=cell[1]%>">
								<input type="text" name="cell3" value="<%=cell[2]%>">
							</td>
						</tr>
						<!-- 이메일 -->
						<script>
							function Email_default() {
								document.getElementById("email_selector").value = "<%=email[1]%>";								
							}
							Email_default();
						</script>
						<tr>
							<th>이메일 * </th>
							<td class="email">
								<input type="hidden" name="email">
								<input type="text" name="email_id" size="7" value="<%=email[0]%>">
								@
								<input type="text" name="email_host" size="7" value="<%=email[1]%>">
							</td>
						</tr>
					</table>
					<!-- 1-2)배송지 정보 -->
					<table>
						<caption>
							배송지 정보
<!-- 							<input type="radio" name="same_address" value="0" onclick="Delivery(this.value)"> -->
<!-- 							주문자 정보 동일 -->
<!-- 							<input type="radio" name="same_address" value="1" onclick="Delivery(this.value)" checked> -->
<!-- 							새 배송지 -->
<!-- 							<input type="radio" name="same_address" value="2" onclick="Address()"> -->
<!-- 							주소록 -->

						</caption>
						<!-- address table 에 레코드가 있다면 그 id 값을 부여 -->
						<input type="hidden" name="id_address">
						<tr>
							<th>이름 * </th>
							<td><input type="text" name="recipient"></td>
						</tr>
						<!-- 주소 -->
						<tr>
							<th>주소 * </th>
							<td class="address">
								<input type="text" name="r_zip" class="zip">
								<a href="javascript:SearchAddress(1)" class="zip_button">우편번호 검색</a>
								<p></p>
								<input type="text" name="r_address1" class="address1"><p></p>
								<input type="text" name="r_address2" class="address2">			
							</td>
						</tr>
						<!-- 휴대전화 -->
						<tr>
							<th>휴대전화 * </th>
							<td class="cell">
								<input type="text" name="r_cell1">
								<input type="text" name="r_cell2">
								<input type="text" name="r_cell3">
							</td>
						</tr>
						<tr>
							<th>배송 요청사항</th>
							<td><textarea name="r_msg" cols="35" rows="3"></textarea></td>
						</tr>
					</table>
				</div>
				<!-- 주문자&배송지 정보 끝 -->
				
				<!-- 결제정보 -->
				<script>
					// 콤마표시 정규식
					function comma(x) {
					    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					}
				</script>
				<div class="article_bottom">
					<table>
						<caption>결제 정보</caption>
						<%
							if (session.getAttribute("email") != null) {
						%>
						<tr>
							<th>포인트 사용</th>
							<td>
								<input type="text" name="use_point" value="0"> p 
								<a href="javascript:UsePoint()">적용</a>
							</td>
							<td>
								내 포인트 : <%=Util.comma(rs.getInt("point"))%> p 
								<a href="javascript:Exhaust(<%=rs.getInt("point")%>)">모두 사용</a>					
							</td>
						</tr>
						<%
							}
						%>
						<tr>
							<th>총 합계</th>
							<td colspan="2">
								<input type="text" name="amount_buy" value="<%=Util.comma(total + delivery_int)%>" readonly> ￦
							</td>
						</tr>
						<tr>
							<th>할인 금액</th>
							<td colspan="2">
								<input type="text" name="amount_discount" value="0" readonly> ￦
							</td>
						</tr>
						<tr>
							<th>결제 금액</th>
							<td colspan="2">
								<input type="text" name="amount_pay" value="<%=Util.comma(total + delivery_int)%>" readonly> ￦
							</td>
						</tr>
						<tr>
							<th>결제 방법</th>
							<td colspan="2">
								<input type="radio" name="pay" value="0" onclick="Pay_form(0)" checked>무통장 입금/계좌이체
								<input type="radio" name="pay" value="1" onclick="Pay_form(1)">카카오페이
								<input type="radio" name="pay" value="2" onclick="Pay_form(2)">카드결제								
							</td>
						</tr>
						<tr>
							<th></th>
							<td>
								<input type="checkbox" name="pay_keychain" value="1">
								결제수단과 입력정보를 저장하고 다음에도 사용합니다.
							</td>
						</tr>
					</table>
				</div>
				<div>
					<input type="submit" value="결제하기" class="button_submit">
				</div>
			</form>
		</article>
	</section>
</body>
</html>
<%
		stmt.close();
		conn.close();
%>