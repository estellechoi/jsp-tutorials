<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	// 문서가 로드될 때 함수 실행
	window.onload = function() {
		// 디폴트 : 성인 2인
		// document.people.adult.selectedIndex = 1; (form 과 select name으로 접근)
		document.getElementById("adult").value = "2";
		// 디폴트 금액 : 1박 가격
		document.getElementById("amount").innerText = "150,000";
	}
	
	// 선택값이 바뀔 때 실행 (onchange)
	function cal() {
		// 숙박일수
		var nights = parseInt(document.getElementById("nights").value);
		var amount = nights * 150000; // * 연산은 문자도 숫자로 인식해 계산해준다 (parseInt 생략 가능)
		
		// 추가 인원 (성인 2인 외 추가인원에 대한 금액 합산)
		var adult = parseInt(document.getElementById("adult").value);
		var child = parseInt(document.getElementById("child").value); // eval ?
				
		if(adult <= 1) {
			adult = 0;
		}
		else {
			adult = adult -2;
		}
		
		// 금액 합산
		amount = adult * 10000;
		document.getElementById("amount").innerText = amount + "";
	}
</script>
</head>
<body>
	<form action="" name="people">
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
		
		금액 합계 : <span id="amount"></span> 원
	</form>
</body>
</html>