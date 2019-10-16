<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	String sql = "select*from member where email='" + session.getAttribute("email") + "'";
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Etc/account_edit.css?ver=1">
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div>
		<div id="grid_right">
			<section class="account_edit_section">
				<div id="account_edit_header">비밀번호 변경</div>
				<form action="account_edit_pwd_ok.jsp" method="post">
					<!-- table member 레코드 id 값 -->
					<input type="hidden" name="id" value="<%=rs.getInt("id")%>">
					<table>
						<caption>
							<%=session.getAttribute("email")%>
						</caption>
						<tr>
							<th>이전 비밀번호</th>
							<td><input type="text" name="pwd_before"></td>
						</tr>
						<tr>
							<th>새 비밀번호</th>
							<td><input type="text" name="pwd"></td>
						</tr>
						<tr>
							<th>새 비밀번호 확인</th>
							<td><input type="text" name="pwd_check"></td>
						</tr>
						<tr>
							<th></th>
							<td><input type="submit" value="비밀번호 변경"></td>
						</tr>
						<tr>
							<th></th>
							<td><a href="forgot_id.jsp">비밀번호를 잊으셨나요 ?</a></td>
						</tr>
					</table>
				</form>
			</section>
		</div>
	</div>
</body>
</html>