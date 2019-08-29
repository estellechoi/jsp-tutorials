<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.sql.*" %>
<!-- LocalDateType은 시분초 -->
<%
	String db = "jdbc:mysql://localhost:3307/hostel?useSSL=false";
	String user = "root";
	String pw = "1234";
	Connection conn = DriverManager.getConnection(db, user, pw);
	Statement stmt = conn.createStatement();
	
	// 날짜 표시
	int yy;
	int mm;
	// 1) 선택된 날짜 있는 경우
	if (request.getParameter("yy") != null && request.getParameter("mm") != null) {
		yy = Integer.parseInt(request.getParameter("yy"));
		mm = Integer.parseInt(request.getParameter("mm"));
	}
	// 2) 디폴트 (현재날짜)
	else {
	 	LocalDate xday = LocalDate.now();
		yy = xday.getYear();
		mm = xday.getMonthValue();
	}
	
	// 요일
	LocalDate today = LocalDate.of(yy, mm, 1);
	int day = today.getDayOfWeek().getValue(); // 월 ~ 일 : 1 ~ 7
	if (day == 7) {
		day = 0;
	}

	// 윤년 체크 (예전 방법 : 400으로 나뉘어진면 윤년 ...)
	boolean leap = today.isLeapYear();

	// 월의 일수
	double length = today.lengthOfMonth();

	// 몇 주 (Math.ceil(); 올림 메소드 사용)
	// ※ (length + day) 정수와 정수의 계산 결과 값은 자동 내림되어 정수가 된다 (소수점이 사라짐 !)
	//    해결방법 : length or day 중 한 개의 자료형을 double로 바꿔준다
	int week = (int) Math.ceil((length + day) / 7);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css">
<link rel="stylesheet" href="../Image/cal.css?ver=2">
<script>
	function moveCal() {
		var yy = document.getElementById("year").value;
		var mm = document.getElementById("month").value;;
		location = "../Booking/callendar_now.jsp?yy="+yy+"&mm="+mm;
	}
</script>
</head>
<body>
	<%@ include file="../Common/header.jsp"%>
	<section id="sectionCalBox">
		<div id="calBox">
			<table>
				<caption>
					<select name="year" id="year" onchange="moveCal()">
					<%
					String yearSelected = "";
					for (int i = yy + 3; i >= yy - 1; i--) {
						if (i == yy) {
							yearSelected = "selected";
						} else {
							yearSelected = "";
						}
					%>
						<option value="<%=i%>" <%=yearSelected%>><%=i%></option>
					<%
					}
					%>
					</select>
					<select name="month" id="month" onchange="moveCal()">
					<%
					String monthSelected = "";
					for (int i=1; i<=12; i++) {
						if (i == mm) {
							monthSelected = "selected";
						} else {
							monthSelected = "";
						}
					%>
						<option value="<%=i%>" <%=monthSelected%>><%=i%></option>
					<%
					}
					%>
					</select>
				</caption>
				<tr id="field">
					<td>일</td>
					<td>월</td>
					<td>화</td>
					<td>수</td>
					<td>목</td>
					<td>금</td>
					<td>토</td>
				</tr>
				<!-- 1 ~ length 까지 일수 출력 -->
				<%
					int date = 1;
					String dateColor;
					for (int i = 0; i < week; i++) {
				%>
				<tr>
					<%
						for (int j = 0; j < 7; j++) {
							switch (j) {
								case 0: dateColor = "red"; break;
								case 6: dateColor = "blue"; break;
								default: dateColor = "black";
							}
							if (date - day <= length && date - day >= 1) {
							// if (date > length || (date <= j) && (i == 1)) { <td></td> }
							// else { <td><%=date</td>}
					%>
							<td>
									<div class="date" style="color:<%=dateColor%>"><%=date - day%></div>
							<%
								String nowday = yy + "-" + mm + "-" + (date - day); // 1 ~ 31일 'yy-MM-dd'
								String sql = "select*from booking where checkinDate <= '"+nowday+"' and";
								sql = sql + " checkoutDate > '"+nowday+"' and room='방1'";
								ResultSet rs = stmt.executeQuery(sql);			
								if (rs.next()) { // 예약불가인 경우
							%>
									<div class="rooms" style="color: darkgrey">room1</div>
							<%
								} else {
							%>
									<div class="rooms"><a href="booking_input.jsp?room=방1&yy=<%=yy%>&mm=<%=mm%>&dd=<%=date - day%>">room1</a></div>
							<%
								}
								sql = "select*from booking where checkinDate <= '"+nowday+"' and";
								sql = sql + " checkoutDate > '"+nowday+"' and room='방2'";
								rs = stmt.executeQuery(sql);			
								if (rs.next()) { // 예약불가인 경우
							%>
									<div class="rooms" style="color: darkgrey">room2</div>
							<%
								} else {
							%>
									<div class="rooms"><a href="booking_input.jsp?room=방2&yy=<%=yy%>&mm=<%=mm%>&dd=<%=date - day%>">room2</a></div>
							<%
								}
								sql = "select*from booking where checkinDate <= '"+nowday+"' and";
								sql = sql + " checkoutDate > '"+nowday+"' and room='방3'";
								rs = stmt.executeQuery(sql);			
								if (rs.next()) { // 예약불가인 경우
							%>
									<div class="rooms" style="color: darkgrey">room3</div>
							<%
								} else {
							%>
									<div class="rooms"><a href="booking_input.jsp?room=방3&yy=<%=yy%>&mm=<%=mm%>&dd=<%=date - day%>">room3</a></div>
							<%
								}
							%>					
							</td>
					<%
							} else {
					%>
							<td></td>
					<%
							}
							date = date + 1;
						}
					%>
				</tr>
				<%
					}
				%>
			</table>
		</div>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>