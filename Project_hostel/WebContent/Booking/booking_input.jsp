<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String room = request.getParameter("room");
	String yy = request.getParameter("yy");
	String mm = request.getParameter("mm");
	String dd = request.getParameter("dd");
	if (mm.length() == 1) {
		mm = "0" + mm;
	}
	if (dd.length()== 1) {
		dd = "0" + dd;
	}
	String date = yy + "-" + mm + "-" + dd + "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css">
<style>
	table {
		margin: auto;
		width: 1000px;
	}
	table caption {
		font-weight: bold;
		font-size: 25px;
		padding-top: 50px;
		padding-bottom: 50px;
	}
	table td:nth-child(1) {
		width: 200px;
		height: 50px;
	}
</style>
<script>
	var nightsAmount = 150000; // 숙박요금 초기값
	var serviceAmount = 0; // 서비스요금 초기값


	// 문서가 로드될 때 함수 실행
	window.onload = function() {
		// 디폴트 : 성인 2인
		// document.select.adult.selectedIndex = 1; (form 과 select name으로 접근)
		document.getElementById("adult").value = "2";
		// 디폴트 금액 : 1박 가격
		document.getElementById("amount").innerText = "150,000";
	}
	
	// * 숙박일수 및 인원수 선택값이 바뀔 때 실행 (onchange)
	function cal() {
		// 숙박일수
		var nights = parseInt(document.getElementById("nights").value);
		var amount = nights * 150000; // * 연산은 문자도 숫자로 인식해 계산해준다 (parseInt 생략 가능)
		
		// 추가 인원 (성인 2인 외 추가인원에 대한 금액 합산)
		var adult = parseInt(document.getElementById("adult").value);
		var child = parseInt(document.getElementById("child").value); // eval ?
				
		// 최대 인원수 체크
		if (adult + child > 6) {
			alert("인원수 초과 !");
			// 인원수 초과 안되도록 자동 지정
			switch (adult) {
				case 1: child = 5; break;
				case 2: child = 4; break;
				case 3: child = 3; break;
				case 4: child = 2; break;
				case 5: child = 1; break;
				case 6: child = 0; break;
			}
		
			document.getElementById("child").value = child + "";
		}
		
		// else 노필요 !
		
		if (adult <= 1) {
			adult = 0;
		}
		else {
			adult = adult -2;
		}
		
		// 숙박 금액 합산
		amount = amount + (adult * 10000);
		nightsAmount = amount; // 콤마 붙이기 전 추후 총 결제금액 합산을 위한 저장
		document.select.amountNights.value = nightsAmount; // 값 전송을 위한 input hidden 값 부여
		document.getElementById("amount").innerText = comma(amount);
		document.getElementById("amountTotal").innerText = comma(amount);
	}
	
	// * 금액에 콤마 표시하기 (정규식 사용)
	function comma(amount) {
		amount = amount + ""; // replace() 함수 사용을 위해 문자열로 변환
		amount = amount.replace(/\B(?=(\d{3})+(?!\d))/g,",");
		return amount;
	}
	
	// * 추가서비스 금액 계산
	function calService() {
		// 서비스 가격 배열
		var sv = new Array();
		var amount = 0;
		
		// checked = false 일 때 가격 0 으로 설정
		for (var i = 0; i <= 2; i++) {
			if (document.getElementsByClassName("service")[i].checked) {
				sv[i] = parseInt(document.getElementsByClassName("service")[i].value);
			}
			else {
				sv[i] = 0;
			}
			// 금액 합산
			amount = amount + sv[i];
		}
		
		serviceAmount = amount;	// 콤마 붙이기 전 총 결제금액 합산을 위한 저장
		document.select.amountService.value = serviceAmount; // 값 전송을 위한 input hidden 값 부여
		document.getElementById("amountService").innerText = comma(amount);
		document.getElementById("amountTotal").innerText = comma(nightsAmount + serviceAmount);
	}
</script>
</head>
<body>
<%@ include file="../Common/header.jsp" %>
	<section>
		<form action="booking_input_ok.jsp" method="post" name="select">
			<input type="hidden" name="amountNights">
			<input type="hidden" name="amountService">
			<input type="hidden" name="room" value="<%=room%>">
			<input type="hidden" name="checkinYY" value="<%=yy%>">
			<input type="hidden" name="checkinMM" value="<%=mm%>">
			<input type="hidden" name="checkinDD" value="<%=dd%>">
			<table>
				<caption>여행 예약</caption>
					<tr>
						<td>선택한 방</td>
						<td><%=room%></td>
					</tr>
					<tr>
						<td>예약자</td>
						<td><input type="text" name="userid" value="<%=session.getAttribute("userid")%>"></td>
					</tr>
					<tr>
						<td>체크인</td>
						<td><%=date%></td>
					</tr>
					<tr>
						<td>예약 상세</td>
						<td>
							방1 (2인실, 최대 6인 숙박 가능)
								<select name="nights" id="nights" onchange="cal()">
									<option value="1">1박</option>
									<option value="2">2박</option>
									<option value="3">3박</option>
									<option value="4">4박</option>
								</select>
								
							성인
							<select name="adult" id="adult" onchange="cal()">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
							</select>
							
							아동
							<select name="child" id="child" onchange="cal()">
								<option value="0">없음</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
							</select>
									
							숙박 금액 : <span id="amount"></span> 원
							<p></p>
							
							서비스 추가 <br>
							<!-- breakfast -->
							<input type="checkbox" class="service" name="breakfast" onclick="calService()" value="30000"> 조식 30,000 원 <br>
							<!-- spa -->
							<input type="checkbox" class="service" name="spa" onclick="calService()" value="50000"> 스파 50,000 원 <br>
							<!-- guide -->
							<input type="checkbox" class="service" name="guide" onclick="calService()" value="20000"> 가이드투어 20,000 원 <p></p>
							서비스 금액 : <span id="amountService">0</span> 원<p></p>
							총 결제 금액 : <span id="amountTotal">150,000</span> 원<p></p>
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="예약하기"></td>
					</tr>
			</table>
		</form>
	</section>
<%@ include file="../Common/footer.jsp" %>
</body>
</html>