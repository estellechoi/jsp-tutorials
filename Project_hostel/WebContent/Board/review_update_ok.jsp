<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!-- 파일 불러오기 -->
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%
	String path = "c:/users/alfo1-2/jspwork_git/Project_hostel/WebContent/Image";
	int max = 1024 * 1024 * 10;
	MultipartRequest multi = new MultipartRequest(request, path, max,
			"UTF-8", new DefaultFileRenamePolicy());

	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3307/hostel?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();
	request.setCharacterEncoding("UTF-8");

	String id = multi.getParameter("id");
	String title = multi.getParameter("title");
	String content = multi.getParameter("content");
	String filename = multi.getFilesystemName("filename");

	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(today);

	String sql;
	
	if (filename != null) {
		sql = "update review set title='" + title + "', content='"
				+ content + "', filename='" + filename + "', writeday='"
				+ writeday + "'";
	}
	else {
		sql = "update review set title='" + title + "', content='"
				+ content + "', writeday='"
				+ writeday + "'";		
	}

	sql = sql + " where id=" + id;
	stmt.executeUpdate(sql);

	response.sendRedirect("review_content_r.jsp?id=" + id);

	stmt.close();
	conn.close();
%>