<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	// DB ����
	String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false"; // db�� : hotel
	String user = "root";
	String pw = "apmsetup";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement(); // ���� ��ü

	// ����� �Է°� �������� (���� �� ���� ���� ������� ��� ������ ���ΰ� ?)
	String id = request.getParameter("id");
	String guestTitle = request.getParameter("title");
	String guestContent = request.getParameter("content");
	
	// ������
	// update "table" set "field"='new record', "field"='new record' where "field"='record';
	String sql = "update guest set title='"+guestTitle+"', content='"+guestContent+"' where id=" + id;

	stmt.executeUpdate(sql);

	// �� Test_content.jsp?id=x �� �̵�
	response.sendRedirect("Test_content.jsp?id="+id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>