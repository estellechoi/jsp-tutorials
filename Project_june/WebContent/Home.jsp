<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	// 1. DB ���� ��ü
	String db = "jdbc:mysql://localhost:3306/member?useSSL=false";
	String user = "root";
	String pw = "apmsetup";
	Connection conn = DriverManager.getConnection(db, user, pw);

	// 2. ������ ��Ʈ�� ��ü
	Statement stmt = conn.createStatement();

	// 3. ������ ���� ��ü
	ResultSet rs;

	// 4. ������
	String sql = "";

	// 5. ������ ���� �޼ҵ�
	stmt.executeQuery(sql);
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