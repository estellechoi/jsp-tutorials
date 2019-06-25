<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3307/hostel?useSSL=false";
	Connection conn = DriverManager.getConnection(db, "root", "1234");
	Statement stmt = conn.createStatement();

	String sql = "select*from member where userid='" + session.getAttribute("userid") + "'";
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css">
<link rel="stylesheet" href="../Image/editProfileStyle.css">
<script>
	function check() {
		var email = document.all.email.value;

		if (document.all.newPassword.value == "") {
			newPasswordX.innerText = "비밀번호를 입력하세요.";
			return false;
		} else if (document.all.newPassword.value != document.all.confirmPassword.value) {
			confirmPasswordX.innerText = "비밀번호 불일치";
			return false;
		} else if (email.indexOf("@") <= 0) {
			emailX.innerText = "올바르지 않은 이메일 주소";
			return false;
		} else {
			return true;
		}
	}
</script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<article></article>
		<article>
			<form method="post" action="editProfile_ok.jsp" onsubmit="return check()">
				<table>
					<tr>
						<td class="colLeft">아이디</td>
						<td><input type="text" name="userid"
							value="<%=rs.getString("userid")%>" disabled></td>
						<td></td>
					</tr>
					<tr>
						<td class="colLeft">이름</td>
						<td><input type="text" name="name"
							value="<%=rs.getString("name")%>" readonly></td>
						<td id="nameX"></td>
					</tr>
					<tr>
						<td class="colLeft">기존 비밀번호</td>
						<td><input type="password" name="password"></td>
						<td id="passwordX"></td>
					</tr>
					<tr>
						<td class="colLeft">새 비밀번호</td>
						<td><input type="password" name="newPassword"></td>
						<td id="newPasswordX"></td>
					</tr>
					<tr>
						<td class="colLeft">새 비밀번호 확인</td>
						<td><input type="password" name="confirmPassword"></td>
						<td id="confirmPasswordX"></td>
					</tr>
					<tr>
						<td class="colLeft">이메일 주소</td>
						<td><input type="text" name="email"
							value="<%=rs.getString("email")%>"></td>
						<td id="emailX"></td>
					</tr>
					<tr>
						<td id="buttonBy" colspan="3"><input type="submit"
							value="정보 수정"></td>
					</tr>
				</table>
			</form>
		</article>

	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>