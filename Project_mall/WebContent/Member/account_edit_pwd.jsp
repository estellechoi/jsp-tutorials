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
<link rel="stylesheet" href="../Etc/account_edit.css?ver=2">
<script>
	function Pwd_check(rs) {
		var pwd_before = document.getElementsByName("pwd_before")[0].value;
		var pwd = document.getElementsByName("pwd")[0].value;
		var pwd_check = document.getElementsByName("pwd_check")[0].value;
		
		// DB 데이터와 비교
		if (!(rs == pwd_before)) {
			alert("이전 비밀번호가 틀립니다.");
			document.getElementById("pwd_before").style.color = "red";
			document.getElementsByName("pwd_before")[0].focus();
			// 왜 리턴되지 ?
			return false;
		}
		else if (pwd != pwd_check) {
			alert("새 비밀번호가 일치하지 않습니다.");
			document.getElementById("pwd_check").style.color = "red";
			document.getElementsByName("pwd_check")[0].focus();
			return false;
		}
		else {
			return true;
		}
	}
</script>
</head>
<body>
	<!-- 네비게이션 바 -->
	<jsp:include page="../nav.jsp" flush="false"/>
	<div id="grid_container">
		<!-- empty space for nav bar -->
		<div id="grid_left"></div>
		<div id="grid_right">
			<section class="account_edit_section">
				<div id="account_edit_header">UPDATE PASSWORD</div>
				<div class="account_grid_container">
					<div class="account_grid_left">
						<form action="account_edit_pwd_ok.jsp" method="post" onsubmit="return Pwd_check('<%=rs.getString("pwd")%>')">
							<!-- table member 레코드 id 값 -->
							<input type="hidden" name="id" value="<%=rs.getInt("id")%>">
							<table>
								<caption>
									<%=session.getAttribute("email")%>
								</caption>
								<tr>
									<th id="pwd_before">이전 비밀번호</th>
									<td><input type="password" name="pwd_before"></td>
								</tr>
								<tr>
									<th>새 비밀번호</th>
									<td><input type="password" name="pwd"></td>
								</tr>
								<tr>
									<th id="pwd_check">새 비밀번호 확인</th>
									<td>
										<input type="password" name="pwd_check">
									</td>
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
					</div>
					<!-- ACCOUNT 페이지 메뉴 네비게이션바 -->
					<div class="account_grid_right">
						<jsp:include page="account_nav.jsp" flush="false"/>
					</div>
				</div>
			</section>
		</div>
	</div>
</body>
</html>