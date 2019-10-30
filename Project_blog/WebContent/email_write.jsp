<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <form action="email.jsp" method="post">
	  <table>
	  	<tr>
	  		<th>받는 사람</th>
	  		<td><input type="text" name="recipient"></td>
	  	</tr>
	  	<tr>
	  		<th>제목</th>
	  		<td><input type="text" name="title"></td>
	  	</tr>
	  	<tr>
	  		<th>내용</th>
	  		<td>
	  			<textarea name="content" cols="40" rows="4"></textarea>
	  		</td>
	  	</tr>
	  	<tr>
	  		<th></th>
	  		<td><input type="submit" value="보내기"></td>
	  	</tr>
	  </table>
  </form>
</body>
</html>