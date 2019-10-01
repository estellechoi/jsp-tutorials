<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="mall.Command.Product_list"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mall.Dto.Product" %>

<%
// 	DecimalFormat df = new DecimalFormat("#,###");

// 	Connection conn = Connect.connection_static(); // Connect 클래스 connection_static() 리턴함수
// 	Statement stmt = conn.createStatement();

// 	// 0 ~ 24 이전 인덱스 레코드만 출력하기
// 	String sql = "select*from product where product_code like 'p03%' limit 0, 24";
// 	ResultSet rs = stmt.executeQuery(sql);

	// 대분류 code 값
	request.setCharacterEncoding("UTF-8");
	int c = Integer.parseInt(request.getParameter("code"));
	String category = request.getParameter("category");

	Product_list p = new Product_list();
	
	// Product_list 클래스 product() 함수의 리턴값 : list 객체 (ResultSet 레코드 값이 저장된)
	ArrayList<Product> product = p.product(c);
	
	// 테스트
	// out.print(product.get(0).getName());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/product_list.css">
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div> 
		<div id="grid_right">
			<section class="product_list_section">
				<div class="list_main">
					<!-- 대분류 텍스트 -->
					<div class="list_header"><%=category%></div>
					<!-- 상품 테이블 -->
					<table>
						<!-- 하위 카테고리 링크 -->
						<caption class="link_sub_category"><a href="#">short</a> / <a href="#">long</a></caption>
						<tr>
				
							<%
								for (int i = 0; i < product.size(); i++) {
									if (i % 4 == 0) {
							%>
								</tr>
								<tr>
							<%
									}
							%>
								<td align="center">
									<div id="image_box">
										<img src="Image/<%=product.get(i).getProduct_list()%>" alt="no image" width="250">
									</div>
									<div id="text_box">
										<%=product.get(i).getName()%> <br>
										￦<%=product.get(i).getPrice()%>
									</div>
								</td>
							<%
								}
							%>
						</tr>
					</table>
				</div>
			</section>

		</div>
	</div>
</body>
</html>