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

	// ����ڰ� ������ parameter("id") ��������
	// ��ũ�� �� ���� �� (form tag X) : Get ���
	// <a href= "�̵��� ����?����=��"> </a> �� �ּ�â�� ��ũ ������
	String id = request.getParameter("id");

	String sql = "select*from guest where id=" + id;
	rs = stmt.executeQuery(sql);
	
	// ������ �̵� (id �������� ���ڵ带 1�ٸ� �������ϱ� �� �� �̵�)
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
			<td colspan=2 align="center"><a href="Test_delete.jsp?id=<%=rs.getString("id") %>"> ���� </a></td>
		</tr>

	</table>

</body>
</html>