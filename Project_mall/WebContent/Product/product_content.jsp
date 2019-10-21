<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id"); // product table id
	
	String sql = "select*from product where id="+id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	
	DecimalFormat df = new DecimalFormat("#,###");
	
	// 세탁정보
	String laundry;
	
	switch(rs.getInt("laundry")) {
		case 0: laundry = "물세탁"; break;
		case 1: laundry = "손세탁"; break;
		case 2: laundry = "드라이클리닝"; break;
		case 3: laundry = "울세탁"; break;
		default: laundry = "미확인";
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- javascript -->
<script src="../Etc/product_content.js?ver=3"></script>
<script>
	function basic() {
		var code = "<%=rs.getString("product_code")%>";
		var country = code.substring(5,7); // index 5,6
		var maker = code.substring(7,9); // index 7,8
		
		switch(country) {
		case "00": country = "미확인"; break;
		case "01": country = "대한민국"; break;
		case "02": country = "미국"; break;
		case "03": country = "중국"; break;
		case "04": country = "일본"; break;
		default: country = "???";
		}
		
		switch(maker) {
		case "00": maker = "미확인"; break;
		case "01": maker = "삼성물산"; break;
		case "02": maker = "코오롱인더스트리"; break;
		case "03": maker = "세아상역"; break;
		case "04": maker = "한솔섬유"; break;
		default: maker = "???";		
		}
		
		document.getElementById("country").innerText = country;
		document.getElementById("maker").innerText = maker;
	}
	
	// 장바구니 담기, 위시리스트 담기 AJAX
	// AJAX 에서 session, cookie 값은 null
	// 매개변수로 값을 전송하는 방법 뿐인가 ?
	var cart = new XMLHttpRequest();
	var wishlist = new XMLHttpRequest();
	
	function Cart(product_code) {
		var size = parseInt(document.getElementById("size").value);
		var qty = document.getElementById("qty").value;
		if (size == 0) {
			alert("사이즈를 선택하세요 !");
		}
		else {
			url = "cart_ok.jsp?product_code=" + product_code + "&size=" + size + "&qty=" + qty+"&email=" + <%=session.getAttribute("email")%>;
			cart.open("get", url);
			cart.send();
		}
	}
	
	cart.onreadystatechange = function() {
		if (cart.readyState == 4) {
			if (cart.responseText.trim() == "ok") {
				// JSP <html> 출력값이 "ok" 하나만 있어야 하며, 다른 값이 있을 경우 전달되지 않는다.
				document.getElementById("layer_cart").display = "block";
			}
		}
	}
	
	function Wishlist(product_code) {
		url = "wishlist_ok.jsp?product_code=" + product_code + "&email=" + <%=session.getAttribute("email")%>;
		wishlist.open("get", url);
		wishlist.send();
	}
	
	wishlist.onreadystatechange = function() {
		if (wishlist.readyState == 4) {
			if (wishlist.responseText.trim() == "ok") {
				document.getElementById("layer_wishlist").display = "block";
			}
		}
	}

</script>
<!-- stylesheet -->
<link rel="stylesheet" href="../Etc/product_content.css?ver=3">
</head>
<body onload="basic()">
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div> 
		<div id="grid_right">
			<section class="product_content_section">
				<!-- 대표 이미지 / 구매 박스 -->
				<article id="head">
					<div id="head_left">
						<img src="Image/<%=rs.getString("product_list")%>" alt="no image">
					</div>
					<div id="head_right">
						<form action="product_buynow.jsp" method="post">
							<!-- 
							* 전송해야할 값
							- 상품코드 (상품정보 불러오기 위한 코드)
							- 수량
							- 사이즈
							 -->
							<input type="hidden" name="product_code" value="<%=rs.getString("product_code")%>">
							<table>
								<caption><%=rs.getString("name")%></caption>
								<tr>
									<td id="product_summary" colspan="2">상품설명</td>
								</tr>
								<tr>
									<td id="product_price" colspan="2">￦  <%=df.format(rs.getInt("price"))%></td>
								</tr>
								<tr>
									<td class="product_size">사이즈</td>
									<td class="product_size">
										<!-- size 선택하지 않으면 구매 못하도록 장치 필요 -->
										<select name="size" id="size">
											<option value="0">선택</option>
											<option value="1">XS</option>
											<option value="2">S</option>
											<option value="3">M</option>
											<option value="4">L</option>
										</select>							
									</td>
								</tr>
								<tr>
									<td id="product_alert" colspan="2">위 옵션선택 박스를 선택하시면 아래에 상품이 추가됩니다.</td>
								</tr>
								<!-- jQuery 플러그인 spinner -->
								<script>
									$(function() {
										$("#qty").spinner({
											min:1,
											max:100
										});
										// spinner 값이 바뀔 때 이벤트 체크
										$("#qty").on("spinstop", function() {
											var qty = document.getElementById("qty").value;
											var price = <%=rs.getInt("price")%>;
											var am = qty * price;
											am = comma(am); // comma(); 금액 콤마 표시
											document.getElementById("product_amount").innerText = "￦ " + am;
											document.getElementById("buying_amount").innerText = "￦ " + am;
										});
									});
								</script>
								<tr>
									<td id="product_qty">수량</td>
									<td>
										<input type="text" name="qty" id="qty" value="1">
										<span id="product_amount">￦  <%=df.format(rs.getInt("price"))%></span>
									</td>
								</tr>
								<tr>
									<td colspan="2" id="buying_amount">￦  <%=df.format(rs.getInt("price"))%></td>
								</tr>
								<!-- 구매 버튼 -->
								<tr>
									<td id="product_button" colspan="2">
										<!-- <button> 태그는 form submit 기능 → post 전송 -->
										<button id="buynow">바로 구매</button>
										<!-- input:button 은 submit 기능 X → get 전송-->
										<input type="button" onclick="Cart('<%=rs.getString("product_code")%>')" value="장바구니 담기">
										<input type="button" onclick="Wishlist('<%=rs.getString("product_code")%>')" value="위시리스트 추가">
									</td>
								</tr>
							</table>
						</form>
					</div>
				</article>
				<!-- 상품 이미지 상세 -->
				<article id="middle">
					<img src="Image/<%=rs.getString("product_main")%>" alt="no image">
				</article>
				<!-- 하단 상품 상세 정보 -->
				<article id="bottom">
					<table>
						<tr id="information_field">
							<td>세탁정보</td>
							<td>제조국</td>
							<td>제조사</td>
							<td>제조일자</td>
							<td>품질보증기간</td>
							<td>AS 문의</td>
						</tr>
						<tr>
							<td><%=laundry%></td>
							<td id="country"></td>
							<td id="maker"></td>
							<td><%=rs.getString("manufactured_date")%></td>
							<td>구입 후 1년 이내</td>
							<td>02-494-2344</td>
						</tr>
					</table>
				</article>
			</section>
		</div>
	</div>
	
	<!-- 장바구니 레이어 -->
	<div id="layer_cart">
		<p>장바구니에 상품을 담았습니다.</p>
		<p>
			<button onclick="Move_cart()">장바구니로 이동</button>
			<button onclick="Close_cart()">쇼핑 계속하기</button>
		</p>
	</div>
	
	<!-- 위시리스트 레이어 -->
	<div id="layer_wishlist">
		<p>위시리스트에 상품을 담았습니다.</p>
		<p>
			<button onclick="Move_wishlist()">위시리스트로 이동</button>
			<button onclick="Close_wishlist()">쇼핑 계속하기 ⓧ</button>
		</p>
	</div>
</body>
</html>