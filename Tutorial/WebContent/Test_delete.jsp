<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
// DB 접속
String db = "jdbc:mysql://localhost:3306/hotel?useSSL=false";
String user = "root";
String pw = "apmsetup";
Connection conn = DriverManager.getConnection(db,user,pw);

//※ 여기서는 데이터 삭제만 하므로 ResultSet rs; (데이터 수령 객체) 필요 없다 !

// 쿼리 컨트롤 객체
Statement stmt = conn.createStatement();

// 사용자 입력 레코드
String id = request.getParameter("id");

// 쿼리문
String sql = "delete from guest where id="+id;

// 쿼리 실행 메소드 (추가/수정)
// select → stmt.executeQuery(sql);
stmt.executeUpdate(sql);

// Test_list.jsp로 이동
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