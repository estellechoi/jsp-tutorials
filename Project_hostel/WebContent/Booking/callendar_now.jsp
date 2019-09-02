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
	Statement stmt2 = conn.createStatement();
	
	// * 날짜 표시
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
	
	// 월별 1일의 요일 구하기
	LocalDate today = LocalDate.of(yy, mm, 1);
	int day = today.getDayOfWeek().getValue();
	
	// 월 ~ 일 : 1 ~ 7 (일요일의 값을 0으로 바꿔주기)
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
<link rel="stylesheet" href="../Image/cal.css">
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
		<%
		if(session.getAttribute("userid") == null) {
		%>
		<div id="alertSignIn"><a href="../SignUp/signin.jsp">로그인 후 예약이 가능합니다 !</a></div>
		<%
		}
		%>
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
					<td style="color: red">일</td>
					<td>월</td>
					<td>화</td>
					<td>수</td>
					<td>목</td>
					<td>금</td>
					<td style="color: blue">토</td>
				</tr>
				<!-- 1 ~ length 까지 일수 출력 -->
				<%
				// * 해당되는 주의 수만큼 <tr> 반복
					int date = 1;
					String dateColor;
					for (int i = 0; i < week; i++) {
				%>
				<tr>
					<%
						// * 요일별 <td> 반복
						for (int j = 0; j < 7; j++) {
								switch (j) {
									case 0: dateColor = "red"; break;
									case 6: dateColor = "blue"; break;
									default: dateColor = "black";
								}
// 							if (date - day <= length && date - day >= 1) {
								// 1 - 4 <= 31 && 1 - 4 >= 1
							// if (date > length || (date <= j) && (i == 1)) { <td></td> }
							// else { <td><%=date</td>}
								
								
								
								// * day = 해당 월 1일의 요일 인덱스 (일 0 ~ 토 6)
							if (day > j && i == 0 || length < date) {
								// j(행)가 1일의 요일보다 작고, 첫 주(i) || 날짜가 월의 총 일수를 초과
								%>
								<td class="roomlink"></td>
								<%
							}
							else {
					%>
								<td  class="roomlink">
									<!-- 날짜 출력 -->
										<div class="date" style="color:<%=dateColor%>"><%=date - day%></div>
								<%
								// * 오늘 날짜와 달력상의 날짜 비교하기 ! (오늘 날짜보다 이전이면 링크 비활성화)
								LocalDate realDate = LocalDate.now();
								LocalDate calDate = LocalDate.of(yy, mm, date - day);
								if (realDate.compareTo(calDate) <= 0) { // realDate - calDate
									// * 방의 개수만큼  while문 실행
									ResultSet rs, rs2;
									// * 방 이름 변수
									String room;
									String sql = "select*from room order by price asc";
									rs = stmt.executeQuery(sql);
									while(rs.next()) {
										room = rs.getString("name");
										String nowday = yy + "-" + mm + "-" + (date - day); // 1 ~ 31일 'yy-MM-dd'
										sql = "select*from booking where checkinDate <= '"+nowday+"' and";
										sql = sql + " checkoutDate > '"+nowday+"' and room='" + room + "'";
										rs2 = stmt2.executeQuery(sql);
										// * 해당 날짜에 데이터가 있다면 예약불가
										if (rs2.next()) {
		
								%>
										<!-- 방 예약링크 출력 -->
											<div class="rooms" style="color: darkgrey"><%=room%></div>
								<%
										// * 데이터가 없으면 예약 가능
										} else {
								%>
											<!-- 로그인 여부에 따라 버튼 활성/비활성화 -->
											<div class="rooms">
											<%
											if(session.getAttribute("userid") != null) {
											%>
												<a href="javascript:goToInput('<%=room%>', '<%=yy%>', '<%=mm%>', '<%=date - day%>')"><%=room%></a>
											<%
											} else {
											%>
												<%=room%>
											<%
											}
											%>
											</div>
								<%
										}
									}
								}
								%>
								</td>
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
			<!--
			* 예약 페이지 링크 스크립트
			(explorer 브라우저에서 get 전송시 방이름 한글 인코딩을 위해 / 크롬은 브라우저에서 자체 인코딩) 
			* request.setCharacterEncoding("UTF-8"); 은 Java 사용을 위한 인코딩
			* <script> encodeURIComponent(n); 은 웹 브라우저 JSP 값 전송을 위한 인코딩
			-->
			<script>
			function goToInput(room, yy, mm, dd) {
				room = encodeURIComponent(room);
				location = "booking_input.jsp?room="+room+"&yy="+yy+"&mm="+mm+"&dd="+dd;
			}
			</script>
		</div>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>