<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3307/blog?useSSL=false";
	Connection conn = DriverManager.getConnection(db, "root", "1234");
	Statement stmt = conn.createStatement();
	String sql = "select*from member where userid='" + session.getAttribute("userid") + "'";
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	int sex = rs.getInt("sex");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Style/commonStyle.css">
<link rel="stylesheet" href="../Style/signupStyle.css">
<script src="../Script/signupCheck.js"></script>
<script>
	function getRadioCheck() {
		document.getElementsByName("sex")[<%=sex%>].checked ="true";
	}
</script>
</head>
<body onload="getRadioCheck()">
	<%@ include file="../Common/header.jsp"%>
	<section>
		<%@ include file="../Common/sidebar.jsp"%>
		<article>
			<form action="../Member/editProfile_ok.jsp" method="post"
				onsubmit="return check()">
				<table>
					<caption>정보수정</caption>
					<tr>
						<td><input type="text" name="userid" placeholder="아이디"
							value="<%=rs.getString("userid")%>" disabled></td>
						<td class="x"></td>
					</tr>
					<tr>
						<td><input type="password" name="password" placeholder="비밀번호"
							value="<%=rs.getString("password")%>"></td>
						<td class="x"></td>
					</tr>
					<tr>
						<td><input type="password" name="passwordCon"
							placeholder="비밀번호 확인"></td>
						<td class="x"></td>
					</tr>
					<tr>
						<td><input type="text" name="name" placeholder="이름"
							value="<%=rs.getString("name")%>"></td>
						<td class="x"></td>
					</tr>
					<tr>
						<td><input type="text" name="email" placeholder="이메일"
							value="<%=rs.getString("email")%>"></td>
						<td class="x"></td>
					</tr>
					<tr>
						<td><input type="radio" name="sex" value="0"> 남 <input
							type="radio" name="sex" value="1"> 여</td>
						<td class="x"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="수정하기"></td>
					</tr>
				</table>
			</form>
		</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>

</body>
</html>