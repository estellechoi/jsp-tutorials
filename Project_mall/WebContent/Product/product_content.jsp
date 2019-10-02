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
	}
</script>
<!-- stylesheet -->
<link rel="stylesheet" href="../Etc/product_content.css">
</head>
<body onload="basic()">
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div> 
		<div id="grid_right">
			<section class="product_content_section">
				<article id="head">
					<div id="head_left">
						<img src="Image/<%=rs.getString("product_list")%>" alt="no image">
					</div>
					<div id="head_right">
						<table>
							<caption><%=rs.getString("name")%></caption>
							<tr>
								<td id="product_summary">상품설명</td>
							</tr>
							<tr>
								<td id="product_price">￦  <%=df.format(rs.getInt("price"))%></td>
							</tr>
							<tr>
								<td id="product_size">
									사이즈 
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
								<td id="product_alert">위 옵션선택 박스를 선택하시면 아래에 상품이 추가됩니다.</td>
							</tr>
							<!-- jQuery 플러그인 spinner -->
							<tr>
								<td id="product_qty">수량 <input type="text" name="qty" id="qty" value="1" style="width: 30px"></td>
							</tr>
							<!-- 구매 버튼 -->
							<tr>
								<td id="product_button">
									<button id="buynow">바로 구매</button>
									<button id="cart" onclick="Cart(<%=id%>)">장바구니에 담기</button>
									<button id="wishlist" onclick="Wishlist(<%=id%>)">위시리스트 추가</button>
								</td>
							</tr>
						</table>
					</div>
				</article>
			</section>
		</div>
	</div>

</body>
</html>