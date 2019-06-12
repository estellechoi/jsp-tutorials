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

	// 사용자가 선택한 parameter("id") 가져오기
	// 링크로 값 보낼 때 (form tag X) : Get 방식
	// <a href= "이동할 문서?변수=값"> </a> → 주소창에 링크 보여짐
	String id = request.getParameter("id");

	String sql = "select*from guest where id=" + id;
	rs = stmt.executeQuery(sql);
	
	// 포인터 이동 (id 조건으로 레코드를 1줄만 가져오니까 한 번 이동)
	rs.next();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<table width=500 border=1>
		<tr>
			<td> Name </td>
			<td> <%=rs.getString("name")%> </td>
		</tr>
		<tr>
			<td> Title </td>
			<td> <%=rs.getString("title")%> </td>
		</tr>
		<tr>
			<td> Content </td>
			<td> <%=rs.getString("content")%> </td>
		</tr>
		<tr>
			<td colspan=2 align="center"><a href="Test_delete.jsp?id=<%=rs.getString("id") %>"> 삭제 </a></td>
		</tr>

	</table>

</body>
</html>