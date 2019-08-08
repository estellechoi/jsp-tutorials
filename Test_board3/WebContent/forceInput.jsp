<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root",
			"1234");
	Statement stmt = conn.createStatement();

	// 임의의 값
	String title = "강제 데이터";
	String content = "강제 데이터";
	String user = "작성자";
	String pwd = "1";

	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String writeday = sdf.format(today);

	for (int i = 1; i <= 807; i++) {

		// DB의 데이터는 정수형으로 구성되어있음 
		// 실수형 데이터를 넣었더니 "data too long for age" 에러 발생
		// 자동으로 정수형 변환 후 데이터로 저장하는 것이 아닌가보네? (반올림)
		String age = ((int) Math.random() * 100) + "";
		String sex = ((int) Math.random() * 2) + "";

		String sql = "insert into testboard(title, content, user, age, sex, pwd, readnum, writeday)";
		sql = sql + " values(?,?,?,?,?,?,?,?)";

		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, title + i);
		pstmt.setString(2, content + i);
		pstmt.setString(3, user + i);
		pstmt.setString(4, age);
		pstmt.setString(5, sex);
		pstmt.setString(6, pwd);
		pstmt.setString(7, "0");
		pstmt.setString(8, writeday);

		pstmt.executeUpdate();
	}

	conn.close();
	stmt.close();

	// 	response.sendRedirect("list.jsp");
%>
<script>
	location = "list.jsp";
</script>