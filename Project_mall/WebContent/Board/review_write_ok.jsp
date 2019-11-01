<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.sql.*"%>
<%@ page import="mall.Jdbc.Connect"%>
<%
	// DB 연결
	Connection conn = Connect.connection_static();

	// 그림파일 저장 경로
	String path = "C://users/alfo1-2/jspwork_git/Project_mall/WebContent/Board/Image";
	// 파일 최대 크기
	int max_size = 1024 * 1024 * 10;
	// + 인코딩 / 동명 파일 업로드시 자동으로 파일명 변경 후 저장 처리
	MultipartRequest multi = new MultipartRequest(request, path, max_size, "UTF-8", new DefaultFileRenamePolicy());

	// * 사용자 입력값 가져오기
	int id_product = Integer.parseInt(multi.getParameter("id_product"));
	String star = multi.getParameter("star");
	String height = multi.getParameter("height");
	String weight = multi.getParameter("weight");
	String content = multi.getParameter("content");
	String image = multi.getFilesystemName("image"); // 파일명
	String email = session.getAttribute("email").toString();
	String username = session.getAttribute("username").toString();
	
	String sql = "insert into review(email, username, star, height, weight, image, content, id_product, writeday)";
	sql = sql + " values(?,?,?,?,?,?,?, now())";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, email);
	pstmt.setString(2, username);
	pstmt.setString(3, star);
	pstmt.setString(4, height);
	pstmt.setString(5, weight);
	pstmt.setString(6, image);
	pstmt.setString(7, content);
	pstmt.setInt(8, id_product);
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
	
	// 페이지 이동
	response.sendRedirect("../Product/product_content.jsp?id="+id_product);
%>