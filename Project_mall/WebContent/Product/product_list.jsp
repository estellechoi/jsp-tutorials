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

	request.setCharacterEncoding("UTF-8");
	int c = 0;
	String category = "";
	// 대분류 code 값
	if (request.getParameter("code") != null) {
		c = Integer.parseInt(request.getParameter("code")); // 상품 대분류 코드
		category = request.getParameter("category"); // 품목 (bestseller,..)		
	}

	// 검색어로 접근한 경우
	if (request.getParameter("search") != null) {
		// 띄어쓰기로 구분되는 단어 모두에 대해 검색
		String search[] = request.getParameter("search").split(" ");
		for (int i = 0; i < search.length; i++) {
			switch(search[i]) {
				case "원피스": c = 3; break;
				case "드레스": c = 302; break;
				case "탑": c = 1; break;
				default: c = 0;
			}
		}
		category = "'" + request.getParameter("search") + "' 검색 결과";
	}

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
<link rel="stylesheet" href="../Etc/product_list.css?ver=9">
<script>
	function Content(id) {
		location = "product_content.jsp?id="+id;
	}
	
	function scrollTopButton() {
		alert(document.documentElement.scrollTop);
		document.documentElement.scrollTop = 0;
	}
</script>
</head>
<body>
	<!-- scrollTop 네비게이션바 -->
	<input type="button" value="TOP" id="TOP" onclick="scrollTopButton()">
	<!-- 메뉴바 include -->
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
						<caption class="link_sub_category">
							<!-- 상품 코드에 따라 -->
							<a href="#"><span id="test"></span></a>
						</caption>
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
										<img src="Image/<%=product.get(i).getProduct_list()%>" alt="no image" width="250" onclick="Content(<%=product.get(i).getId()%>)">
									</div>
									<div id="text_box">
										<%=product.get(i).getName()%> <p></p>
										￦ <%=product.get(i).getPrice()%>
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