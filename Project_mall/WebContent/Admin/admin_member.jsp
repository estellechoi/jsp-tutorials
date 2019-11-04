<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*"%>
 <%@ page import="mall.Jdbc.Connect"%>
<%@ page import="mall.Util.Util"%>
 
 <%
	Connection conn = Connect.connection_static(); // Connect 클래스 connection_static() 리턴함수
	Statement stmt = conn.createStatement();
	
	// 0 ~ 24 인덱스 레코드만 출력하기
	String sql = "select*from member order by id desc";
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.product_manage_section {
	height: 900px;
	overflow: scroll;
}

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
/**/
.list_main {
	display: grid;
	grid-template-columns: 1fr 150px;
}

/* 상품 리스트 테이블 크기 (브라우저 크기에 맞추기) */
table {
	width: 1200px;
	margin: auto;
	border-collapse: collapse;
}

table caption {
	text-align: right;
	padding: 20px;
}

	/* 상품 등록 */
	table caption a {
		text-decoration: none;
		font-size: 12px;
		font-weight: bold;
		color: #495164;
		letter-spacing: 3px;
	}
	table caption a:hover {
		text-decoration: underline;
	}

table td {
	border: 1px solid grey;
	text-align: center;
	padding-top: 5px;
	padding-bottom: 5px;
	color: grey;
	font-size: 13px;
}

table td img {
	border: none;
	border-radius: 50%;
}

table #field td {
	font-weight: bold;
	color: #353535;
}

table td a {
	color: grey;
}

</style>
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div> 
		<div id="grid_right">
			<section class="product_manage_section">
				<!-- 대분류 텍스트 -->
				<div class="list_header">MANAGE MEMBER</div>
				<div class="list_main">
					<!-- 상품 테이블 -->
					<div>
						<table>
							<caption><a href="product.jsp">상품등록</a></caption>
							<tr id="field">
								<td>순</td>
								<td>구분</td>
								<td>이메일</td>
								<td>이름</td>
								<td>성별</td>
								<td>생년월일</td>
								<td>적립포인트</td>
								<td>구매실적</td>
								<td>가입일</td>
							</tr>
							<%
							int i = 1;
							String usertype = "";
							String sex = "";
							
							while(rs.next()) {
								switch(rs.getInt("usertype")) {
									case 0: usertype = "개인"; break;
									case 1: usertype = "사업자"; break;
								}
								switch(rs.getInt("sex")) {
									case 0: sex = "남"; break;
									case 1: sex = "여"; break;
								}
							%>
							<tr>
								<td><%=i%></td>
								<td><%=usertype%></td>
								<td><%=rs.getString("email")%></td>
								<td><%=rs.getString("username")%></td>
								<td><%=sex%></td>
								<td><%=rs.getString("birth")%></td>
								<td><%=Util.comma(rs.getInt("point"))%> p </td>
								<td></td>
								<td><%=rs.getString("writeday")%></td>
							</tr>
							<%
								i++;
							}
							%>
						</table>
					</div>
					<!-- 관리자용 navigation -->
					<jsp:include page="admin_nav.jsp" flush="false"/>
				</div>
			</section>
		</div>
	</div>
</body>
</html>