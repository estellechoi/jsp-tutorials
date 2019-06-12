<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false";
	String user = "root";
	String pw = "apmsetup";
	Connection conn = DriverManager.getConnection(db, user, pw);

	Statement stmt = conn.createStatement();
	ResultSet rs;

	String sql = "select*from guest";
	rs = stmt.executeQuery(sql);
%>
<style>
table, td, tr {
	border: 1px solid red;
	/*cellpadding: 10px;*/
	padding: 10px;
	border-spacing: 0px 0px;
	border-collapse: collapse;
}

input {
	color: "gold";
}
"
WebContent
/Test_content
.jsp
"
</style>
<script>
	function setColor() {
		var tableCap = document.querySelector('#tableCap');
		if (tableCap.value == "Click") {
			tableCap.style.color = "powderblue";
			tableCap.value = "Blue";
		} else {
			tableCap.style.color = "gold";
			tableCap.value = "Click";
		}
	}
</script>
<body>
	<input type="button" value="Click" onclick="setColor()">
	<p></p>
	<table width=500 border=1>
		<caption id="tableCap">Guests</caption>
		<tr>
			<td>ID</td>
			<td>Name</td>
			<td>Title</td>
			<td>Content</td>
		</tr>
		<%
			// * rs.next() 리턴값 = T/F (레코드 있으면 T, 없으면 F)
			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString("id")%></td>
			<td><%=rs.getString("name")%></td>
			<td><a href="Test_content.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("title")%></a></td>
			<td><%=rs.getString("content")%></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan=4><a href="Test_input.html"> Write </a></td>
		</tr>
	</table>

</body>


<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>