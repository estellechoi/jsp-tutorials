<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String db="jdbc:mysql://localhost:3307/hostel?useSSL=false";
String user="root";
String pw = "1234";
Connection conn = DriverManager.getConnection(db,user,pw);
Statement stmt = conn.createStatement();

// 사용자 입력값
request.setCharacterEncoding("UTF-8");
String userid = request.getParameter("userid");
String password = request.getParameter("password");

// 아이디/비밀번호 동시에 만족하는 데이터 존재여부 확인
String sql="select * from member where userid='"+userid+"' and password='"+password+"'";
ResultSet rs = stmt.executeQuery(sql);

// 검토
// * 세션변수 : session.setAttribute(변수명, 값);
//   전역변수 (모든 문서에서 언제나 접근 가능), 자주 사용하는 값을 전역변수 session에 저장
if(rs.next()) {
	session.setAttribute("userid",rs.getString("userid"));
	session.setAttribute("name",rs.getString("name"));
	response.sendRedirect("../Home/home.jsp");
}
else {
	response.sendRedirect("../SignUp/signin.jsp");
}


// 돌아가자
// response.sendRedirect("../Home/home.jsp");

stmt.close();
conn.close();
%>