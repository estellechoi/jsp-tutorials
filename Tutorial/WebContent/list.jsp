<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*" %>

<%
String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false";
String user = "root";
String pw = "apmsetup";
Connection conn = DriverManager.getConnection(db,user,pw);

// DB ��Ʈ�� ��ü ����
Statement stmt = conn.createStatement();

// DB ������ �����ͼ� �����ϴ� ��ü ���� (sql select ������ ������� ������ ��ü)
ResultSet rs;

// ������
String sql = "select*from guest";
// ������ ����޼ҵ带 rs�� ���� (������ �����Դ� !)
rs = stmt.executeQuery(sql);

// rs.next(); (���ڵ������� �̵� �޼ҵ�)
// while(rs.next()){} �� rs.next()�� ������� true �̸� �����ϴ� �ݺ���
while(rs.next()) {
	out.println(rs.getString("name"));
	out.println(rs.getString("title"));
	out.println("<p>");
}

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