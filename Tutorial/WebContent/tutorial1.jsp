<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import = "java.sql.*" %>

<%
// DB ����
String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false"; // db�� : hotel
String user = "root";
String pw = "apmsetup";
Connection conn = DriverManager.getConnection(db,user,pw);

// form input value ��������, ����ϱ�
String a = request.getParameter("xx"); // <input name="xx">
String b = request.getParameter("yy"); // <input name="xx">

//DB ��Ʈ�� ��ü ����
Statement stmt = conn.createStatement();

//������
String sql = "insert into guest(field name,field name)";
sql=sql+"values('"+a+"','"+b+"')";

// ���� ����
// stmt.executeUpdate(sql);
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
Tutorial.
</body>
</html>