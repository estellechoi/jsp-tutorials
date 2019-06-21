<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
String db="jdbc:mysql://localhost:3307/hostel?useSSL=false";
String user="root";
String pw = "1234";
Connection conn = DriverManager.getConnection(db,user,pw);
Statement stmt = conn.createStatement();

// 사용자 입력값
request.setCharacterEncoding("utf-8");
String userid = request.getParameter("userid");
String password = request.getParameter("password");

// 아이디/비밀번호 동시에 만족하는 데이터 존재여부 확인
String sql="select * from member where userid='"+userid+"' and password='"+password+"'";
ResultSet rs = stmt.executeQuery(sql);

// 검토
// 세션변수(session) : session.setAttribute(변수명, 값);
// 세션변수는 전역변수 (값이 한 번 들어가면 해당값이 계속 존재, 페이지마다 값을 줄 필요가 없음)
if(rs.next()) {
	session.setAttribute("userid",rs.getString("userid"));
}
else {
	response.sendRedirect("../SignUp/signin.jsp");
}


// 돌아가자
// response.sendRedirect("../Home/home.jsp");

stmt.close();
conn.close();
%>