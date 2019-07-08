<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<!-- LocalDateType은 시분초 -->
<%
	// 요일
	LocalDate today = LocalDate.of(2019, 7, 1); // LocalDate.now(); 현재 날짜
	int day = today.getDayOfWeek().getValue(); // 월 ~ 일 : 1 ~ 7
	if (day == 7) {
		day = 0;
	}
	out.print(day + "<br>");

	// 윤년 체크 (예전 방법 : 400으로 나뉘어진면 윤년 ...)
	boolean leap = today.isLeapYear();
	out.print(leap + "<br>");

	// 월의 일수
	double length = today.lengthOfMonth();
	out.print((int) length + "<br>");

	// 몇 주 (Math.ceil(); 올림 메소드 사용)
	// ※ (length + day) 정수와 정수의 계산 결과 값은 자동 내림되어 정수가 된다 (소수점이 사라짐 !)
	//    해결방법 : length or day 중 한 개의 자료형을 double로 바꿔준다
	int week = (int) Math.ceil((length + day) / 7);
	out.print(week + "<br>");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/cal.css">
</head>
<body>
	<table>
		<caption><%=today.getMonth()%></caption>
		<tr>
			<td>일</td>
			<td>월</td>
			<td>화</td>
			<td>수</td>
			<td>목</td>
			<td>금</td>
			<td>토</td>
		</tr>
		<%
			for (int i = 0; i < week; i++) {
		%>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<%
			}
		%>
	</table>

</body>
</html>