<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
// DB ����
String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false";
String user = "root";
String pw = "apmsetup";
Connection conn = DriverManager.getConnection(db,user,pw);

//�� ���⼭�� ������ ������ �ϹǷ� ResultSet rs; (������ ���� ��ü) �ʿ� ���� !

// ���� ��Ʈ�� ��ü
Statement stmt = conn.createStatement();

// ����� �Է� ���ڵ�
String id = request.getParameter("id");

// ������
String sql = "delete from guest where id="+id;

// ���� ���� �޼ҵ� (�߰�/����)
// select �� stmt.executeQuery(sql);
stmt.executeUpdate(sql);

// Test_list.jsp�� �̵�
response.sendRedirect("Test_list.jsp");

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