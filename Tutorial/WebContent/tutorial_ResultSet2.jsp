<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*" %>

<%
String db="jdbc:mysql://localhost:3306/hotel?useSSL=false";
String user="root";
String pw="apmsetup";
Connection conn = DriverManager.getConnection(db,user,pw);

Statement stmt = conn.createStatement();
ResultSet rs;

String sql = "select*from guest";
rs = stmt.executeQuery(sql);

while(rs.next()) {
%>
<tr>
	<td> <%=rs.getString("name")%></td>
	<td><%=rs.getString("title")%></td>
	<td><%=rs.getString("content")%></td>
</tr>
<%	
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