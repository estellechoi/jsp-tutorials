<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%
	String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false";
	String user = "root";
	String pw = "apmsetup";
	
	// �����ͺ��̽� ���� ��ü
	Connection conn = DriverManager.getConnection(db, user, pw);

	// ������ ����ϰ� ���ִ� ��ü
	Statement stmt = conn.createStatement();
	
	// ������ ���� ��ü
	ResultSet rs;

	// ������
	String sql = "select*from guest";
	
	// �������� �޼ҵ�(������) ���ϰ� ��  ������ ���� ��ü
	rs = stmt.executeQuery(sql);
	
	// ���ڵ������� ��Ʈ��
	rs.next();
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