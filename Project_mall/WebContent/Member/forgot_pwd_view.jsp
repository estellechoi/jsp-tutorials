<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	
	// DB 연결
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();

	String sql = "select*from member where email='" + email + "'";
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	/* 로그인 */
	.forgot_section {
		height: 730px;
	}
	
	.forgot_section #forgot_main {
		width: 800px;
		margin: auto;
	}
	
	/* 로그인 글자 */
	#forgot_header {
		height: 200px;
		display: flex;
		align-items: center;
		justify-content: center;
		font-weight: 700;
		letter-spacing: 2px;
		font-size: 14px;
		color: #353535;
	}
	
	table {
		width: 400px;
		margin: auto;
		border: 1px solid #3A4050;
		border-radius: 5px;
	}
	
	table caption {
		text-align: left;
		font-weight: bold;
		padding-bottom: 30px;
		padding-left: 10px;
	}
	
	table th, td {
		padding-top: 20px;
		padding-bottom: 20px;
	}
	
	input[type=button] {
		background: #3A4050;
		color: white;
		border: 1px solid #3A4050;
		border-radius: 5px;
		padding: 10px;
	}
</style>
<script>
	function Signin() {
		location = "signin.jsp";
	}
</script>
</head>
<body>
	<!-- 네비게이션 바 <body> display: grid -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
			<!-- empty space for nav bar -->
			<div id="grid_left"></div> 
			<div id="grid_right">
				<!-- 로그인 페이지 -->
				<section class="forgot_section">
					<div id="forgot_main">
						<!-- 로그인 글자 -->
						<div id="forgot_header">FORGOT PASSWORD</div>
						<div>
							<table>
								<caption><%=rs.getString("username")%> 님의 가입 정보</caption>
								<tr>
									<th>이메일</th>
									<td><%=rs.getString("email")%></td>
								</tr>
								<tr>
									<th></th>
									<td>
										<input type="button" value="로그인 페이지" onclick="Signin()">
									</td>
								</tr>
							</table>
						</div>
					</div>
				</section>
			</div>
	</div>
</body>
</html>