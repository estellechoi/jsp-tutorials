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

	Product_list p = new Product_list();
	
	// Product_list 클래스 product() 함수의 리턴값 : list 객체 (ResultSet 레코드 값이 저장된)
	ArrayList<Product> product = p.product();
	
	// 테스트
	// out.print(product.get(0).getName());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<caption><h2>상품 03</h2></caption>
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
					<img src="Image/<%=product.get(i).getProduct_list()%>" alt="no image" width="250"> <p></p>
					<%=product.get(i).getName()%> <br>
					￦<%=product.get(i).getPrice()%>
				</td>
			<%
				}
			%>
		</tr>
	</table>

</body>
</html>