<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
// DB ����
String db="jdbc:mysql://localhost:3306/checkin?useSSL=false";
String user="root";
String pw="apmsetup";
Connection conn = DriverManager.getConnection(db,user,pw);
// ���� ���� ��ü
Statement stmt = conn.createStatement();

// ����� �Է°� ����
String username = request.getParameter("name");
String usercity = request.getParameter("city");
String usercomment = request.getParameter("comment");

// ������
// insert into "table"("field", "field") values("����", ����); ���ڵ� �߰�
String sql = "insert into board(name, city, comment) values('"+username+"','"+usercity+"','"+usercomment+"')";

stmt.executeUpdate(sql);

// back to home.jsp
response.sendRedirect("home.jsp");

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