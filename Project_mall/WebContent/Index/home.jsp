<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Util.Util"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();

	String sql = "select*from product order by writeday asc";
	ResultSet rs = stmt.executeQuery(sql);
	rs.last();
	int n = rs.getRow();
	rs.beforeFirst();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Insert title here</title>
<!-- jQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Vegas Plugin -->
<script src="/Vegas/vegas.js"></script>
<script src="/Vegas/vegas.min.js"></script>
<link rel="stylesheet" href="/Vegas/vegas.css">
<link rel="stylesheet" href="/Vegas/vegas.min.css">
<script>
	$(function() {
		$("section").vegas({
			slides : [ {
				src : "../Etc/vintage1.jpg"
			}, {
				src : "../Etc/vintage2.jpg"
			} ]
		});
	});
</script>
<style>

.welcome_section table {
	width: 100%;
	margin-top: 50px;
}

.welcome_section table td {
	height: 500px;
	letter-spacing: 5px;
	font-weight: bold;
	font-size: 12px;
	color: #495164;
}

#image_box {
	border: none;
	border-radius: 50%;
	width: 250px;
	height: 250px;
	overflow: hidden;
	margin-bottom: 5px;
	cursor: pointer;
}

</style>
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false" />
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div>
		<div id="grid_right">
			<section class="welcome_section">
				<!-- 웰컴 이미지 -->
				<table>
					<tr>
				<%
					for (int i = 0; i < n; i++) {
						rs.next();
						if (i % 4 == 0) {
						
							%>
							</tr>
							<tr>
							<%
						}
						%>
								<td align="center">
									<div id="image_box">
										<img src="../Product/Image/<%=rs.getString("product_list")%>" width="300" alt="no image" onclick="Content(<%=rs.getString("id")%>)">
									</div>
									<div id="text_box">
										<%=rs.getString("name")%> <p></p>
										￦ <%=Util.comma(rs.getInt("price"))%>
									</div>
								</td>
						<%
					}
				%>
					</tr>
				<%
					
				%>
				</table>
			</section>
			<!-- footer -->
			<jsp:include page="../footer.jsp" flush="false" />
		</div>
	</div>
</body>
</html>