<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/java?useSSL=false", "root", "1234");
	Statement stmt = conn.createStatement();
	String sql = "select distinct title from movie";
	ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		width: 1000px;
		margin: auto;
		border: 1px solid #eeeeee;
		border-radius: 10px;
		box-shadow: 3px 3px 5px 3px grey;
		padding-top: 20px;
		padding-bottom: 20px;
	}
	
	table caption {
		padding-top: 20px;
		padding-bottom: 20px;
		font-weight: bold;
	}
	
	table td {
		text-align: center;
		font-size: 13px;
		padding-top: 20px;
		padding-bottom: 20px;
	}
	
	table td input[type=submit],[type=button] {
		border-radius: 5px;
		background: #4d4d4d;
		color: white;
		padding: 3px;
	}
	
	li {
		list-style-type: none;
		color: black;
		text-decoration: none;
	}
</style>
<script>
	function escapeBooking() {
		location = "booking_view.jsp";
	}
</script>
</head>
<body>
	<%@ include file="../Common/header.jsp" %>
	<section>
		<form action="booking_time.jsp" method="post">
			<input type="hidden" name="movie" value="샘플">
			<table>
				<caption>빠른 예매</caption>
				<tr>
					<td>영화</td>
					<td>극장</td>
					<td>날짜</td>
					<td>시간</td>
				</tr>
				<tr>
					<td>
						<ul>
						<%
						while(rs.next()) {
							%>
							<li><a href="javascript:getSite('<%=rs.getString("title")%>')"><%=rs.getString("title")%></a></li>
							<%
						}
						%>
						</ul>
					</td>
					<script>
						var xml = new XMLHttpRequest();
						function getSite(title) {
							xml.open("post", "booking_getSite.jsp?title="+title);
							xml.send();
						}

						xml.onreadystatechange = function() {
							if(xml.readyState == 4) {
								document.getElementById("site").innerHTML = xml.responseText;
							}
						}
					</script>
					<td>
						<ul id="site"></ul>
					</td>
					<script>
						var xml2 = new XMLHttpRequest();
						function getDate(title, site) {
							xml2.open("post", "booking_getDate.jsp?title="+title+"&site="+site);
							xml2.send();
						}
	
						xml2.onreadystatechange = function() {
							if(xml2.readyState == 4) {
								document.getElementById("date").innerHTML = xml2.responseText;
							}
						}					
					</script>
					<td>
						<ul id="date"></ul>
					</td>
					<script>
						var xml3 = new XMLHttpRequest();
						function getDate(title, site, date) {
							xml3.open("post", "booking_getTime.jsp?title="+title+"&site="+site+"&date="+date);
							xml3.send();
						}
	
						xml3.onreadystatechange = function() {
							if(xml3.readyState == 4) {
								document.getElementById("time").innerHTML = xml3.responseText;
							}
						}
					</script>				
					<td>
						<ul id="time"></ul>
					</td>
				</tr>
				<tr>
					<td colspan="4"><input type="submit" value="예매"></td>
				</tr>
			</table>
		</form>
	</section>
</body>
</html>