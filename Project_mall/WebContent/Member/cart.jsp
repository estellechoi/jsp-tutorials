<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Util.Util"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	String sql = "select product.id, product.product_code, product.product_list, product.name, product.price, cart.id as id_cart, cart.size, cart.qty from product, cart where cart.email='" + session.getAttribute("email") + "'";
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

/* 레이어 */
#layer_options_cart {
	position: absolute;
	top: 0px;
	left: 0px;
	visibility: hidden;
	border: 2px solid #495164;
	background: white;
	width: 200px;
	height: 30px;
	padding-top: 5px;
	padding-bottom: 5px;
	text-align: center;
}

#layer_options_cart #Show_options {
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
	
	// 이 상품만 바로 구매
	function Buynow(product_code, size, qty) {
		location = "../Product/product_buynow.jsp?product_code="+product_code+",&size="+size+",&qty="+qty+",&cart=y&kind=1";
		// 뒤에 , 더한 이유 : product_buynow.jsp 에서 값을 변수에 담을 때 split(",") 하기 때문
		// cart 데이터 테이블에서 삭제는 구매 완료시에 ! 구매완료 전까지는 데이터 유지 !
	}
	
	// 레이어
	// 레이어 열기
	function Change_options_open(i, product_code, size) {
		var txt = "사이즈 <select id='layer_size'><option value='XS'>XS</option>";
		txt = txt + "<option value='S'>S</option><option value='M'>M</option><option value='L'>L</option>";
		// i : 옵션 선택 후 몇번째 상품에 적용할지 정보 저장
		txt = txt + "</select><input type='hidden' name='i' value='" + i + "'>";
		document.getElementById("layer_options_cart").style.visibility = "visible";
		document.getElementById("layer_options_cart").style.top = (event.clientY + document.documentElement.scrollTop) + "px";
		document.getElementById("layer_options_cart").style.left = event.clientX + "px";
		document.getElementById("Show_options").innerHTML = txt;
		// 기존 사이즈 표시
		document.getElementById("layer_size").value = size;
	}
	
	// 변경하지 않고 레이어 닫기
	function Change_options_close() {
		document.getElementById("layer_options_cart").style.visibility = "hidden";
	}
	
	// 레이어 변경내용 저장하기
	function Change_options_save() {
		var i = parseInt(document.getElementsByName("i")[0].value);
		var size = document.getElementById("layer_size").value;
		// input name=size 값 변경
		document.getElementsByName("size")[i].value = size;
		document.getElementById("layer_options_cart").style.visibility = "hidden";
	}
	
	// 선택된 상품 구매하기
	function Order_selected() {
		var checkbox = document.getElementsByName("product_code"); // 배열
		
		var product_code ="";
		var size = "";
		var qty = "";
		var id_cart = "";
		var n = 0;
		
		for (var i = 0; i < checkbox.length; i++) { // checkbox.length 로 대체 가능 (장바구니 상품의 가짓수)
			if(checkbox[i].checked) {
				product_code = product_code + checkbox[i].value + ",";
				size = size + document.getElementsByName("size")[i].value + ",";
				qty = qty + document.getElementsByName("qty")[i].value + ",";
				n++;
			}
		}
		
		location = "../Product/product_buynow.jsp?product_code=" + product_code + "&size=" + size + "&qty=" + qty + "&cart=y&kind="+n;
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
			max:100,
// 			spin: function(event, ui) {
// 				var $Q = $(".qty");
// 				var n = $Q.index(this); // .qty 요소 중 해당요소의 index no.
// // 				document.getElementsByClassName(".qty")[n].value;
// 				// alert(ui.value);
// 			}
		});
// 		// spinner 값이 바뀔 때 이벤트 체크
// 		$(".qty").on("spinstop", function() {
// 			var $qty = $(".qty");
// 			$qty.index(this).value = qty;
// 		});
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
			<section class="wishlist_section">
				<div id="cart_header">CART</div>
				<div class="account_grid_container">
					<div class="account_grid_left">
						<form action="cart_toBuy.jsp" method="post">
							<input type="hidden" name="IfFromCart" value="y">
							<table>
								<caption>
									<input type="checkbox" onclick="Checkbox_controller(this)" id="checkbox_master"> 모든 상품을 선택합니다.
								</caption>
								<%
									int i = 0;
									while (rs.next()) {		
										// 사이즈 텍스트 변환
										int s = rs.getInt("size");
										String size = "";
										switch(s) {
											case 0: size = "선택"; break;
											case 1: size = "XS"; break;
											case 2: size = "S"; break;
											case 3: size = "M"; break;
											case 4: size = "L"; break;
										}
								%>
								<input type="hidden" name="id_cart" value="<%=rs.getString("id_cart")%>">
								<tr>
									<td><input type="checkbox" name="product_code" value="<%=rs.getString("product_code")%>" onclick="Checkbox()"></td>
									<td><img src="../Product/Image/<%=rs.getString("product_list")%>" alt="no image" width="80" height="80" onclick="Product_content(<%=rs.getInt("id")%>)"></td>
									<td width="200px"><%=rs.getString("name")%></td>
									<td>￦ <%=Util.comma(rs.getInt("price"))%></td>
									<td><input type="text" name="size" value="<%=size%>" readonly size="1"></td>
									<!-- 옵션 변경시, cart 데이터베이스 테이블도 바꿔줘야한다 ! 페이지 리로드 해야하나 ? -->
									<td><input type="button" value="옵션 변경" onclick="Change_options_open(<%=i%>, '<%=rs.getString("product_code")%>', '<%=size%>')"></td>
									<td><input type="text" name="qty" class="qty" value="<%=rs.getInt("qty")%>" size="4"> 개</td>
									<td><input type="button" value="이 상품만 바로 구매" onclick="Buynow('<%=rs.getString("product_code")%>', <%=s%>, <%=rs.getInt("qty")%>)"></td>
								</tr>
								<%
										i++;
									}
								%>
							</table>
							<div id="button_box">
								<input type="button" id="button_del" value="선택상품 삭제" onclick="Del()">
								<input type="button" id="button_buy" value="선택상품 구매" onclick="Order_selected()">
							</div>
						</form>
					</div>
					<!-- 옵션변경 레이어 -->
					<div id="layer_options_cart">
						<span id="Show_options"></span>
						<input type="button" value="변경" onclick="Change_options_save()">
						<input type="button" value="취소" onclick="Change_options_close()">
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