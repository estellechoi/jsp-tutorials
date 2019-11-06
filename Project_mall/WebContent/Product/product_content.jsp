<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.text.DecimalFormat"%>
<%

	String email = "";
	if (session.getAttribute("email") != null) {
		email = session.getAttribute("email").toString();
	}
	else {
		email = "nonmember"; // 비회원
	}

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
	
	// 상품정보
	String id_product = rs.getString("id");
	String product_code = rs.getString("product_code");
	String country = product_code.substring(5,7); // index 5,6
	String maker = product_code.substring(7,9); // index 7,8
	
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
	
	// 쿠키 생성
	// 접속한 클라이언트의 하드로부터 쿠키 값을 읽어오는 함수
	// 저장한 데이터 없을 때 배열의 크기는 1 (자동으로 붙는 session id 때문)
	Cookie cookies[] = request.getCookies();
	
	
	// 1) 쿠키 없을 경우 (최초쿠키, 시간 지나서 쿠키 모두 소멸한 경우)
	if (cookies.length == 1) {
		Cookie cookie = new Cookie("product_code" + cookies.length, rs.getString("product_code"));
		cookie.setMaxAge(600); // 600초
		response.addCookie(cookie); // 하드디스크에 저장
	}
	// 2) 추가로 쿠키 생성
	else {
		int n = Integer.parseInt(cookies[cookies.length - 2].getName().substring(12));
		Cookie cookie = new Cookie("product_code" + (n + 1), rs.getString("product_code"));
		cookie.setMaxAge(600);
		response.addCookie(cookie);
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
<style>
/* TOP 버튼 */
#goTop {
	border: 3px solid #FF00FF;
	border-radius: 50%;
	width: 40px;
	height: 40px;
	color: #FF00FF;
	font-weight: bold;
	position: fixed;
	top: 100px;
	left: 300px;
	text-align: center;
	cursor: pointer;
	text-decoration: none;
}

.product_content_section #head {
	height: 700px;
	display: grid;
	grid-template-columns: 700px 1fr;
}

/* 상품 대표 이미지 product_list */
.product_content_section #head_left {
	display: flex;
	align-items: center;
	justify-content: center;
}

/* 상품 구매박스 테이블 */
#head_right table {
	width: 600px;
	margin: auto;
}

#head_right table caption {
	padding-top: 50px;
	padding-bottom: 50px;
	font-size: 27px;
	font-weight: bold;
	letter-spacing: 3px;
	color: #555555;
}

/* 상품 설명*/
#head_right table #product_summary {
	height: 270px;
	color: grey;
	font-size: 13px;
}

/* 상품 구매 박스 항목 */
#head_right table td {
	padding-top: 10px;
	padding-bottom: 10px;
	color: #555555;
}

#head_right table #product_price, #buying_amount {
	letter-spacing: 3px;
	font-weight: bold;
}

#head_right table .product_size, #product_qty, #product_amount {
	font-weight: bold;
	font-size: 13px;
}

#head_right table .product_size select {
	border: 1px solid grey;
	width: 80px;
	height: 30px;
	color: #FF00FF;
}

#head_right table #product_alert {
	font-size: 13px;
}

#head_right table #product_qty input {
	border: none;
	width: 50px;
	height: 30px;
	color: #FF00FF;
	font-weight: bold;
}

/* 구매 버튼 */
#head_right table #product_button button, input[type=button] {
	border: 1px solid #555555;
	color: white;
	font-weight: bold;
	background: #555555;
	width: 150px;
	height: 50px;
	cursor: pointer;
}

#head_right table #product_button button:hover, input[type=button]:hover {
	border: 3px solid #555555;
	color: #555555;
	background: none;
}

/* 상품 포스트 / 이미지 */
.product_content_section #middle {
	padding-top: 120px;
	padding-bottom: 80px;
	align: center;
}
/* 하단 상품정보 */

.product_content_section #bottom table {
	width: 1000px;
	margin: auto;
	border-collapse: collapse;
}

#bottom table td {
	border: 1px solid #eeeeee;
	height: 50px;
	width: 200px;
	text-align: center;
	vertical-align: center;
	font-size: 13px;
	color: #555555;
}

#bottom table #information_field td {
	font-weight: bold;
}

/* 레이어 hidden 처리 */
#layer_cart, #layer_wishlist {
	display: none;
	width: 400px;
	height: 130px;
	position: absolute;
	top: 300px;
	left: 600px;
	background: white;
	border: 3px solid #555555;
}

#layer_cart p, #layer_wishlist p {
	font-size: 13px;
	color: #555555;
	font-weight: bold;
	text-align: center;
	padding-top: 10px;
	padding-bottom: 10px;
}

#layer_cart button, #layer_wishlist button {
	width: 140px;
	height: 40px;
	border: 2px solid #555555; 
	background: #555555;
	color: white;
	font-size: 13px;
	cursor: pointer;
}

#layer_cart button:hover, #layer_wishlist button:hover {
	background: white;
	color: #555555;	
}
</style>
<script>
	// 콤마
	function comma(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	// 장바구니 담기, 위시리스트 담기 AJAX
	// AJAX 에서 session, cookie 값은 null - 매개변수로 값을 전송하는 방법 뿐인가 ?
	var cart = new XMLHttpRequest();
	var wishlist = new XMLHttpRequest();
	
	function Cart(product_code) {
		var size = document.getElementById("size").value;
		var qty = document.getElementById("qty").value;
		var email = "<%=email%>";
		if (size == "0") {
			alert("사이즈를 선택하세요 !");
		}
		else {
			url = "cart_ok.jsp?product_code=" + product_code + "&size=" + size + "&qty=" + qty+"&email=" + email;
			cart.open("get", url);
			cart.send();
		}
	}
	
	cart.onreadystatechange = function() {
		if (cart.readyState == 4) {
			if (cart.responseText.trim() == "ok") {
				// JSP <html> 출력값이 "ok" 하나만 있어야 하며, 다른 값이 있을 경우 전달되지 않는다.
				document.getElementById("layer_cart").style.display = "block";
			}
		}
	}
	
	// GET 매개변수로 값 전송시, <\%=%> 바로 사용할 수 없다 (문자로 인식하지 못하기 때문에 @ 같은 특수문자로 에러 발생 가능)
	function Wishlist(product_code) {
		var email = "<%=email%>";
		url = "wishlist_ok.jsp?product_code=" + product_code + "&email=" + email;
		wishlist.open("get", url);
		wishlist.send();
	}
	
	wishlist.onreadystatechange = function() {
		if (wishlist.readyState == 4) {
			if (wishlist.responseText.trim() == "ok") {
				document.getElementById("layer_wishlist").style.display = "block";
			}
			else if (wishlist.responseText.trim() == "no"){
				alert("이미 위시리스트에 담은 상품입니다.");
			}
		}
	}
	
	// 장바구니/위시리스트 이동
	function Close_cart() {
		document.getElementById("layer_cart").style.display = "none";
	}

	function Move_cart() {
		location = "../Member/cart.jsp";
	}

	function Close_wishlist() {
		document.getElementById("layer_wishlist").style.display = "none";
	}

	function Move_wishlist() {
		location = "../Member/wishlist.jsp";
	}
	
	// onsubmit 바로구매시 사이즈 선택여부 체크
	function Submit() {
		if (document.getElementById("size").value == "0") {
			alert("사이즈를 선택하세요.");
			return false;
		}
		else {
			return true;
		}
	}
	
	// 스크롤 탑
	function GoTop() {
		document.documentElement.scrollTop = 0;
	}
</script>
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
			var am = comma(qty * price); // comma(); 금액 콤마 표시
			document.getElementById("product_amount").innerText = "￦ " + am;
			document.getElementById("buying_amount").innerText = "￦ " + am;
		});
	});
</script>
</head>
<body>
	<!-- scrollTop 네비게이션바 -->
	<a href="javascript:GoTop()" id="goTop">TOP</a>
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
						<form action="product_buynow.jsp" method="post" onsubmit="return Submit()">
							<!-- 
							* 전송해야할 값
							- 상품코드 (상품정보 불러오기 위한 코드)
							- 수량
							- 사이즈
							 -->
							<input type="hidden" name="product_code" value="<%=rs.getString("product_code")%>">
							<input type="hidden" name="kind" value="1">
							<table>
								<caption><%=rs.getString("name")%></caption>
								<tr>
									<td id="product_summary" colspan="2">
										<%=rs.getString("information")%>
									</td>
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
											<option value="XS">XS</option>
											<option value="S">S</option>
											<option value="M">M</option>
											<option value="L">L</option>
										</select>							
									</td>
								</tr>
								<tr>
									<td id="product_alert" colspan="2">위 옵션선택 박스를 선택하시면 아래에 상품이 추가됩니다.</td>
								</tr>
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
							<td><%=country%></td>
							<td><%=maker%></td>
							<td><%=rs.getString("manufactured_date")%></td>
							<td>구입 후 1년 이내</td>
							<td>02-494-2344</td>
						</tr>
					</table>
				</article>
				<!-- 리뷰 게시판 -->
				<jsp:include page="../Board/review_list.jsp" flush="false">
					<jsp:param name="id_product" value="<%=id_product%>"/>
				</jsp:include>
				<!-- footer -->
				<jsp:include page="../footer.jsp" flush="false"/>
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