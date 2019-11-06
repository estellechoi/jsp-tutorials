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
<style>

.product_list_section {
	height: 900px;
	overflow: scroll;
}

/* .product_list_section .list_main { */
/* 	width: 1000px; */
/* 	margin: auto; */
/* } */

.list_header {
	height: 200px;
	display: flex;
	align-items: center;
	justify-content: center;
/* 	font-family: 'Gill Sans MT Std'; */
	font-weight: 700;
	letter-spacing: 2px;
	font-size: 14px;
	color: #353535;
}

/* 리스트 메인 구간 grid display */
.list_main {
	display: grid;
	grid-template-columns: 1fr 100px;
}
/* 상품 테이블 크기 (브라우저 크기에 맞추기) */
table {
	width: 100%;
}

table #text_box {
	height: 500px;
	letter-spacing: 5px;
	font-weight: bold;
	font-size: 12px;
	color: #495164;
	margin-top: 10px;
	margin-bottom: 30px;
}

/* 상품별 상자 크기 */
table #image_box {
	width: 250px;
	height: 250px;
	overflow: hidden;
	border: none;
	border-radius: 50%;
	display: flex;
	align-items: flex-end;
	justify-content: center;
}

table #image_box img {
	cursor: pointer;
}

table #text_box {
	height: 60px;
/* 	border: 1px solid red; */
	font-size: 13px;
}

/* 상품 테이블 caption (하위카테고리 링크) */
table .link_sub_category {
	height: 80px;
}

table .link_sub_category a {
	text-decoration: none;
	color: grey;
	letter-spacing: 5px;
	font-size: 12px;
}

table .link_sub_category a:hover {
	text-decoration: underline;
}

/* TOP 버튼 */
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
	
</style>
<script>
	function Content(id) {
		location = "product_content.jsp?id="+id;
	}
	// 스크롤 탑
	// product_content.jsp 에서는 잘되는데 ? 여기선 왜안되지 ?
	function GoTop() {
		document.documentElement.scrollTop = 0;
	}
</script>
</head>
<body>
	<!-- scrollTop 네비게이션바 -->
	<a href="javascript:GoTop()" id="goTop">TOP</a>
	<!-- 메뉴바 include -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div> 
		<div id="grid_right">
			<section class="product_list_section">
				<!-- 대분류 텍스트 -->
				<div class="list_header"><%=category%></div>
				<div class="list_main">
					<!-- 상품 테이블 -->
					<div>
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
					<!-- 쿠키 이미지 -->
					<jsp:include page="../Product/cookie.jsp" flush="false"/>
				</div>
			</section>
		</div>
	</div>
</body>
</html>