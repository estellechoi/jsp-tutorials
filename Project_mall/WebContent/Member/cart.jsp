<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Util.Util"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	String sql = "select product.id, product.product_code, product.product_list, product.name, product.price, cart.size, cart.qty from product, cart where cart.email='" + session.getAttribute("email") + "'";
	sql = sql + " and product.product_code = cart.product_code";
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
	#cart_header {
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
input[type=button], #button_buy {
	border: 1px solid #495164;
	border-radius: 5px;
	background: #495164;
	color: white;
	font-size: 12px;
	padding: 5px;
	cursor: pointer;
}

#button_del {
	border: 1px solid #800000;
	border-radius: 5px;
	background: #800000;
	color: white;
	font-size: 12px;
	padding: 5px;
	cursor: pointer;
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
	
	// 콤마
	function comma(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	// 선택상품 삭제
	function Del() {
		// 체크된 상품코드
		var code = "";
		for (var i=0; i<<%=n%>; i++) {
			if (document.getElementsByName("product_code")[i].checked) {
				code = code + document.getElementsByName("product_code")[i].value + ",";
			}
		}
		location = "cart_del.jsp?code=" + code;
	}
</script>
<!-- jQuery -->
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script>						
	// jQuery 플러그인 spinner
	$(function() {
		$(".qty").spinner({
			min:1,
			max:100
		});
	});
// 	// spinner 값이 바뀔 때 이벤트 체크
// 		$(".qty").on("spinstop", function() {
// 			var qty = document.getElementsById(this).value;
// 		});
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
				<div id="cart_header">CART</div>
				<div class="account_grid_container">
					<div class="account_grid_left">
						<form action="cart_toBuy.jsp" method="post">
							<table>
								<caption>
									<input type="checkbox" onclick="Checkbox_controller(this)" id="checkbox_master" checked> 모든 상품을 선택합니다.
								</caption>
								<%
									while (rs.next()) {		
										// 사이즈 텍스트 변환
										String size = rs.getString("size");
										switch(size) {
											case "0": size = "선택"; break;
											case "1": size = "XS"; break;
											case "2": size = "S"; break;
											case "3": size = "M"; break;
											case "4": size = "L"; break;
										}
								%>
								<tr>
									<td><input type="checkbox" name="product_code" value="<%=rs.getString("product_code")%>" onclick="Checkbox()" checked></td>
									<td><img src="../Product/Image/<%=rs.getString("product_list")%>" alt="no image" width="80" height="80" onclick="Product_content(<%=rs.getInt("id")%>)"></td>
									<td width="200px"><%=rs.getString("name")%></td>
									<td>￦ <%=Util.comma(rs.getInt("price"))%></td>
									<td><%=size%></td>
									<td><input type="text" name="qty" class="qty" value="<%=rs.getInt("qty")%>" size="4"> 개</td>
									<td><input type="button" value="옵션 변경"></td>
									<td><input type="button" value="이 상품만 바로 구매"></td>
								</tr>
								<%
									}
								%>
							</table>
							<div id="button_box">
								<input type="button" id="button_del" value="선택상품 삭제" onclick="Del()">
								<input type="submit" id="button_buy" value="선택상품 구매">
							</div>
						</form>
					</div>
					<!-- ACCOUNT 페이지 메뉴 네비게이션바 -->
					<div class="account_grid_right">
						<jsp:include page="account_nav.jsp" flush="false"/>
					</div>
				</div>
			</section>
		</div>
	</div>
</body>
</html>