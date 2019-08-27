<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%
	//
	// * new DefaultFileRenamePolicy() 파일명 중복시 자동으로 파일명을 바꾸어 저장
	String path="c:/users/alfo1-2/jspwork_git/Project_hostel/WebContent/Image";
	int max = 1024*1024*10;
	MultipartRequest multi = new MultipartRequest(request, path, max, "UTF-8", new DefaultFileRenamePolicy());

	// DB 연결
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/hostel?useSSL=false", "root", "1234");
	Statement stmt = conn.createStatement();
	
	// writeday
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(today);
	
	
	request.setCharacterEncoding("UTF-8");
	String userid = multi.getParameter("userid");
	String name = multi.getParameter("name");
	String title = multi.getParameter("title");
	String content = multi.getParameter("content");
	
	// 사용자가 첨부한 파일 읽어오기
	// getFilesystemName(); 실제 저장된 파일명
	String filename = multi.getFilesystemName("filename");
	
	String sql = "insert into review(userid, name, title, content, filename, writeday)";
	sql = sql + " values('"+userid+"', '"+name+"', '"+title+"', '"+content+"', '"+filename+"', '"+writeday+"')";
	
	stmt.executeUpdate(sql);
	
	response.sendRedirect("review_list.jsp");
	
	stmt.close();
	conn.close();
%>
