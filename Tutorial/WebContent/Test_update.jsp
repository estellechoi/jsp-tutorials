<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false";
	String user = "root";
	String pw = "apmsetup";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement();

	// id �� �ޱ�
	// request.getParameter("x"); html <input name="x"> ����� �Է°�(value) ȣ�� 
	String id = request.getParameter("id");

	// ������
	String sql = "select*from guest where id=" + id;

	// ��������
	ResultSet rs = stmt.executeQuery(sql);

	// ������ ���� (������ �̵�)
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form action="Test_update_ok.jsp" method="post">
		<input type="hidden" name="id" value="<%=id%>"> <!-- ��Ÿ���� �ʰ�, ���� ��� �ѱ�� ���� input �Ӽ�-->
		<input type="submit" value="Click">
		<p></p>
		User name
		<p></p>
		<input type="text" name="name" value="<%=rs.getString("name")%>" disabled>
		<p></p>
		Title
		<p></p>
		<input type="text" name="title" value="<%=rs.getString("title")%>">
		<p></p>
		Content
		<p></p>
		<textarea name="content" cols="40" rows="5"><%=rs.getString("content")%></textarea>
		<p></p>

	</form>

</body>
</html>