<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
//DB ������ ���� ������
String db="jdbc:mysql://localhost:3306/hotel?useSSL=false";
String user="root";
String pw="apmsetup";

// DB ����
Connection conn = DriverManager.getConnection(db,user,pw);

// DB ���� ��Ʈ�� ��ü ����
Statement stmt = conn.createStatement();

// DB ������ �������� ��ü ���� (sql select ������ ������� ������ ��ü)
ResultSet rs;

// ������ ����
String sql = "select*from guest";
rs = stmt.executeQuery(sql);

// rs.getString(); rs�� ����� �� ���ڿ��� ���
// rs.getInt(); ������ ���

// * ���ڵ������� (default position �� table field row)
// rs.next(); to move record pointer (row by row)
// * if points a row without records, it values "false"(boolean).
// while statement : ������ true�� �� �ݺ� ����
while(rs.next()) {
	out.println(rs.getString("name"));
	out.println(rs.getString("title"));
	out.println("<p>");	
}

//rs.next();
//out.println(rs.getString("name"));
//out.println(rs.getString("title"));
//out.println("<p>");
//rs.next();
//out.println(rs.getString("name"));
//out.println(rs.getString("title"));
//out.println("<p>");

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