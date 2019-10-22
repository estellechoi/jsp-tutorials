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
.layer_optionSelector_opener {
	position: relative;
}
.layer_optionSelector {
	display: none;
	width: 250px;
	height: 30px;
	padding-top: 1px;
	padding-bottom: 1px;
	position: absolute;
	top: 0px;
	left: 00px;
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
	
// 	// 사이즈 선택 레이어 열기
// 	function OptionSelector_open(i) {
// 		document.getElementsByClassName("layer_optionSelector")[i].style.display = "block";
// 	}
	
	
// 	// 취소하고 창닫기
// 	function OptionSelector_close(i) {
// 		document.getElementsByClassName("layer_optionSelector")[i].style.display = "none";
// 	}
	
// 	// 사이즈 선택 레이어 저장하고 닫기
// 	function OptionSelector_save(i, product_code) {
// 		// 1) 값 저장
// 		var layer_size = document.getElementsByClassName("layer_size")[i].value;
		
//  		// input hidden
// 		document.getElementsByName("product_code_size")[i].value = product_code + "," + layer_size;
		
// 		// inner text
// 		switch(layer_size) {
// 			case "1": layer_size = "XS"; break;
// 			case "2": layer_size = "S"; break;
// 			case "3": layer_size = "M"; break;
// 			case "4": layer_size = "L"; break;
// 		}
// 		document.getElementsByClassName("product_code_size")[i].innerText = layer_size;
		
// 		// 2) 레이어 닫기
// 		document.getElementsByClassName("layer_optionSelector")[i].style.display = "none";
// 	}
	
	
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
									<!-- 사이즈/수량 선택내용 표시 -->
									<!-- 선택된것 보여주고, 동시에 데이터 넘길 수 있도록 input 이나, 어떤 변수에 넣어주기 ! -->
<!-- 									<td class="product_code_size" width="100px"><input type="hidden" name="product_code_size"></td> -->
<!-- 									<td class="layer_optionSelector_opener"> -->
<%-- 										<input type="button" value="사이즈 선택" onclick="OptionSelector_open(<%=i%>)"> --%>
<!-- 										사이즈/수량 선택 레이어 -->
<!-- 										<div class="layer_optionSelector"> -->
<!-- 														사이즈 -->
<!-- 														<select class="layer_size"> -->
<!-- 															<option value="1">XS</option> -->
<!-- 															<option value="2">S</option> -->
<!-- 															<option value="3">M</option> -->
<!-- 															<option value="4">L</option> -->
<!-- 														</select> -->
<!-- 														버튼 -->
<%-- 														<input type="button" value="적용" onclick="OptionSelector_save(<%=i%>, '<%=rs.getString("product_code")%>')"> --%>
<%-- 														<input type="button" value="취소" onclick="OptionSelector_close(<%=i%>)"> --%>
<!-- 										</div> -->
<!-- 									</td> -->
									<td><input type="button" value="이 상품만 바로 구매"></td>
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
					<!-- ACCOUNT 페이지 메뉴 네비게이션바 -->
					<div class="account_grid_right">
						<jsp:include page="account_nav.jsp" flush="false"/>
					</div>
</body>
</html>