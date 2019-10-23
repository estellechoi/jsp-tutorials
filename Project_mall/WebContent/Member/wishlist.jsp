<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Util.Util"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	String sql = "select product.id, product.product_code, product.product_list, product.name, product.price from product, wishlist where wishlist.email='" + session.getAttribute("email") + "'";
	sql =sql + " and product.product_code = wishlist.product_code";
	ResultSet rs = stmt.executeQuery(sql);
	rs.last();
	int n = rs.getRow();
	rs.beforeFirst();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#wishlist_header {
	height: 200px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 700;
	letter-spacing: 2px;
	font-size: 14px;
	color: #353535;
}

.account_grid_left table {
	width: 1000px;
	margin: auto;
	border-collapse: collapse;
}

.account_grid_left #button_box {
	width: 800px;
	margin: auto;
	padding-top: 20px;
}

.account_grid_left table caption {
	text-align: left;
	padding-left: 15px;
	padding-bottom: 20px;
	font-size: 13px;
	font-weight: bold;
	color: #495164;
}

.account_grid_left table td {
	border-bottom: 1px solid #eeeeee;
	text-align: center;
	padding-top: 5px;
	padding-bottom: 5px;
}

.account_grid_left table img {
	border-radius: 50%;
	cursor: pointer;
}

/* 버튼공통 */
input[type=button] {
	border: 1px solid #495164;
	border-radius: 5px;
	background: #495164;
	color: white;
	font-size: 12px;
	padding: 5px;
	cursor: pointer;
}

input[type=submit] {
	border: 1px solid #800000;
	border-radius: 5px;
	background: #800000;
	color: white;
	font-size: 12px;
	padding: 5px;
	cursor: pointer;
}

/* 사이즈/수량 선택 레이어 */
/* 레이어 위치 설정 어떻게 해야할까 ? */
.layer_options_box {
	position: relative;
}
#layer_options {
	visibility: hidden;
	width: 250px;
	height: 30px;
	padding: 5px;
	position: absolute;
	top: 0px;
	left: 0px;
	border: 2px solid #495164;
	border-radius: 5px;
	background: white;
	font-size: 12px;
}
</style>
<script>
	// 체크박스 모두 체크/해제 컨트롤
	function Checkbox_controller(all) {
		if (all.checked) {
			for (var i=0; i<<%=n%>; i++) {
				document.getElementsByName("product_code")[i].checked = true;
			}
		}
		else {
			for (var i=0; i<<%=n%>; i++) {
				document.getElementsByName("product_code")[i].checked = false;
			}	
		}
	}
	
	function Checkbox() {
		var x = 0;
		for (var i=0; i<<%=n%>; i++) {
			if (document.getElementsByName("product_code")[i].checked) {
				x++;
			}
		}
		if (x == <%=n%>) {
			document.getElementById("checkbox_master").checked = true;
		}
		else {
			document.getElementById("checkbox_master").checked = false;
		}
	}
	
	// onsubmit = 체크된 상품이 있는지 ?
	function If_checked() {
		var x = 0;
		for (var i=0; i<<%=n%>; i++) {
			if (document.getElementsByName("product_code")[i].checked) {
				x++;
			}
		}
		
		if (x == 0) {
			alert("선택된 상품이 없습니다.");
			return false;
		}
		else {
			return true;
		}
	}
	
	// 위시리스트에서 상품 상세 페이지로 이동 (매개변수 : product 테이블의 id)
	function Product_content(id) {
		location = "../Product/product_content.jsp?id="+id;
	}

	// 위시리스트 → 장바구니 담기
	function WishToCart() {
		// 체크된 상품코드
		var code = "";
		for (var i=0; i<<%=n%>; i++) {
			if (document.getElementsByName("product_code")[i].checked) {
				code = code + document.getElementsByName("product_code")[i].value + ",";
			}
		}
		location = "wishlist_toCart.jsp?code=" + code;
	}
	
	// 위시리스트 → 이 상품만 바로 구매 레이어 열기
	function Wish_toBuynow_open(product_code, i) {
		document.getElementById("layer_options").style.visibility = "visible";
		document.getElementById("layer_options").style.top = (event.clientY + document.documentElement.scrollTop) + "px";
		document.getElementById("layer_options").style.left = (event.clientX + 100) + "px";
		// input hidden 값
		document.layer.product_code.value = product_code;
	}
	
	// 위시리스트 → 이 상품만 바로 구매 레이어 닫기 (취소)
	function Wish_toBuynow_close(i) {
		document.getElementById("layer_options").style.visibility = "hidden";
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
			<section class="wishlist_section">
				<div id="wishlist_header">WISHLIST</div>
				<div class="account_grid_container">
					<div class="account_grid_left">
						<form action="wishlist_del.jsp" method="post" onsubmit="return If_checked()">
							<table>
								<caption><input type="checkbox" onclick="Checkbox_controller(this)" id="checkbox_master"> 모든 상품을 선택합니다.</caption>
								<%
									int i = 0;
									while (rs.next()) {
								%>
								<tr>
									<td><input type="checkbox" name="product_code" value="<%=rs.getString("product_code")%>" onclick="Checkbox()"></td>
									<td><img src="../Product/Image/<%=rs.getString("product_list")%>" alt="no image" width="80" height="80" onclick="Product_content(<%=rs.getInt("id")%>)"></td>
									<td width="200px"><%=rs.getString("name")%></td>
									<td>￦ <%=Util.comma(rs.getInt("price"))%></td>
									<td class="layer_options_box">
										<input type="button" value="이 상품만 바로 구매" onclick="Wish_toBuynow_open('<%=rs.getString("product_code")%>', <%=i%>)">

									</td>
								</tr>
								<%
										i++;
									}
								%>
							</table>
							<div id="button_box">
								<input type="submit" value="선택상품 삭제">
								<input type="button" value="선택상품 장바구니 담기" onclick="WishToCart()">
							</div>
						</form>
					</div>
					<!-- 이 상품만 바로 구매시, 수량/사이즈 선택 레이어 -->
					<div id="layer_options">
						<form action="../Product/product_buynow.jsp" method="post" name="layer">
							<input type="hidden" name="product_code">
							<input type="hidden" name="wish" value="y">
							사이즈
							<select name="size">
								<option value="0">선택</option>
								<option value="1">XS</option>
								<option value="2">S</option>
								<option value="3">M</option>
								<option value="4">L</option>
							</select>
							수량
							<input type="text" name="qty" size="1">
							<input type="submit" value="구매">
							<input type="button" value="취소" onclick="Wish_toBuynow_close()">
						</form>
					</div>
					
					<!-- ACCOUNT 페이지 메뉴 네비게이션바 -->
					<div class="account_grid_right">
						<jsp:include page="account_nav.jsp" flush="false"/>
					</div>
</body>
</html>