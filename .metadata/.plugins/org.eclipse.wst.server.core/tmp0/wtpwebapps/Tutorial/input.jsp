<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
// DB ����
String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false"; // db�� : hotel
String user = "root";
String pw = "apmsetup";
Connection conn = DriverManager.getConnection(db,user,pw);

// form input value ��������, ����ϱ�
String guestName = request.getParameter("name"); // name="name"
String guestTitle = request.getParameter("title"); // name="title"
String guestContent = request.getParameter("content"); // name="content"

//DB ��Ʈ�� ��ü ����
Statement stmt = conn.createStatement();

//������
String sql = "insert into guest(name, title, content)";
sql=sql+"values('"+guestName+"','"+guestTitle+"','"+guestContent+"')";

// ���� ����
out.println(sql);
//stmt.executeUpdate(sql);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
input page

</body>
</html>