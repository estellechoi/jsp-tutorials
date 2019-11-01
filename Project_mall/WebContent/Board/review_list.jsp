<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	// include 하는 페이지에서 전달한 파라미터값
	String id_product = request.getParameter("id_product");
	
	String sql = "select*from review where id_product=" + id_product;
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#review {
	margin-top: 50px;
	margin-bottom: 50px;
}
#review_header {
	width: 1000px;
	margin: auto;
	padding: 10px;
	color: #555555;
	font-size: 20px;
	font-weight: bold;
	letter-spacing: 5px;
}
/* 리뷰 테이블 */
#review table {
	width: 1000px;
	margin: auto;
	padding: 5px; /* ?? */
	border-collapse: collapse;
	border: 1px solid #555555;
	border-radius: 5px;
}
#review table caption {
	padding: 10px;
	font-size: 17px;
	font-weight: bold;
	letter-spacing: 3px;
	color: #FF8000;
	text-align: left;
}

#review table td {
	text-align: left;
	vertical-align: center;
	font-size: 13px;
	color: #555555;
	padding-left: 20px;
	padding-top: 5px;
	padding-bottom: 5px;
}

#review #review_user td {
	height: 30px;
}

/* 리뷰 이미지 */
#review table #review_image {
	text-align: center;
}
#review table #review_image img {
	border: none;
	border-radius: 10px;
}


</style>
</head>
<body>
				<article id="review">
					<div id="review_header">REVIEW</div>
					<hr>
					<!-- 반복문 -->
					<%
						if (!(rs.next())) {
					%>
							<table>
								<caption></caption>
								<tr>
									<td>리뷰가 없습니다.</td>
								</tr>
							</table>
					<%
						} else {
							rs.beforeFirst();
							while(rs.next()) {
								int star = rs.getInt("star");
								String star_img = "";
								for (int i=0; i< star; i++) {
									star_img = star_img + " ★ ";
								}
					%>
							<table>
								<caption><%=star_img%></caption>
								<tr id="review_user">
									<td><%=rs.getString("email")%></td>
									<td><%=rs.getString("writeday")%></td>
									<td>키 : <%=rs.getString("height")%> cm / 몸무게 : <%=rs.getString("weight")%> kg</td>
									<td rowspan="2" id="review_image">
										<img src="../Board/Image/<%=rs.getString("image")%>" alt="no image" width="200px">
									</td>
								</tr>
								<tr>
									<td colspan="3"><%=rs.getString("content")%></td>
								</tr>
							</table>
					<%
							}
						}
					%>
				</article>
</body>
</html>