<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding = "UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.io.*" %> <!-- ?? -->
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%
	// DB 연결
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root", "1234");
	Statement stmt = conn.createStatement();
		
	// 업로드파일 객체 multi 생성
	String path = "c:/users/alfo1-2/jspwork_git/Test_upload/WebContent/imsi";
	int max = 1024*1024*10;
	MultipartRequest multi = new MultipartRequest(request, path, max, "UTF-8", new DefaultFileRenamePolicy());
	
	// * DB 입력값들
	String user = multi.getParameter("user");
	String title = multi.getParameter("title");
	String content = multi.getParameter("content");
	// 이미지 파일명
	String img = multi.getFilesystemName("image"); // 실제 저장된 파일명
	String oimg = multi.getOriginalFileName("image"); // 사용자가 요청한 파일명
	// 작성일
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(today); // 포맷 적용
	
	// DB 쿼리
	String sql = "insert into review(user, title, content, img, oimg, writeday)";
	sql = sql + " values('"+user+"', '"+title+"', '"+content+"', '"+img+"', '"+oimg+"', '"+writeday+"')";
	stmt.executeUpdate(sql);
%>