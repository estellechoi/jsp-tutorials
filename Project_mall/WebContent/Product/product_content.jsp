<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	
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
<script src="../Etc/product_content.js"></script>
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
</script>
<!-- stylesheet -->
<link rel="stylesheet" href="../Etc/product_content.css?after">
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
								});
							</script>
							<tr>
								<td id="product_qty">수량</td>
								<td>
									<input type="text" name="qty" id="qty" value="1">
								</td>
							</tr>
							<!-- 구매 버튼 -->
							<tr>
								<td id="product_button" colspan="2">
									<button id="buynow">바로 구매</button>
									<button id="cart" onclick="Cart(<%=id%>)">장바구니에 담기</button>
									<button id="wishlist" onclick="Wishlist(<%=id%>)">위시리스트 추가</button>
								</td>
							</tr>
						</table>
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