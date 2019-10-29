<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.Jdbc.Connect"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String pwd_before = request.getParameter("pwd_before");
	String pwd = request.getParameter("pwd");
	String pwd_check = request.getParameter("pwd_check");
	
	// DB 연결
	Connection conn = Connect.connection_static();
	Statement stmt = conn.createStatement();
	
	String sql = "select pwd from member where email='" + session.getAttribute("email") + "'";
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	String pwd_rs = rs.getString("pwd");
	
	if (pwd_before.equals(pwd_rs)) {
		// 이중 체크
		if (pwd.equals(pwd_check)) {
			sql = "update member set pwd='"+pwd+"' where email='" + session.getAttribute("email") + "'";
			stmt.executeUpdate(sql);
			%>
			<script>
				alert("비밀번호가 변경되었습니다.");
			</script>
			<%	
			response.sendRedirect("account.jsp");
		}
		else {
				%>
				<script>
					history.back();
					alert("새 비밀번호가 일치하지 않습니다.");
				</script>
				<%			
		}
	}
	else {
		// 이중 체크
		%>
		<script>
			history.back();
			alert("이전 비밀번호가 틀렸습니다.");
		</script>
		<%
	}
	
	stmt.close();
	conn.close();
%>