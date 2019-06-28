<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Image/structure.css?ver=1">
<script>
	function goEvent() {
		// 		document.getElementsByClassName('pop')[1].innerHTML = "이름 <input type='text' name='name'>";
		// 		document.getElementsByClassName('pop')[2].innerHTML = "번호 <input type='text' name='phone'>";
		// 		document.getElementsByClassName('pop')[3].innerHTML = "<input type='submit' value='신청하기'>";	
		document.querySelectorAll('.pop')[1].innerHTML = "이름 <input type='text' name='name'>";
		document.querySelectorAll('.pop')[2].innerHTML = "번호 <input type='text' name='phone'>";
		document.querySelectorAll('.pop')[3].innerHTML = "<input type='submit' value='신청하기'>";
	}
	function closePop() {
		document.querySelector('#popup').style.display = "none";
	}
</script>
</head>
<body>
	<!-- 팝업 -->
	<div id="popup">
		<form action="../Home/event_ok.jsp" method="post">
			<table>
				<tr>
					<td class="pop">여름맞이 이벤트</td>
				</tr>
				<tr>
					<td class="pop">기간 : 2019년 6월 30일 ~ 2019년 8월 31일</td>
				</tr>
				<tr>
					<td class="pop">내용 : 전 숙박고객에게 BBQ 제공</td>
				</tr>
				<tr>
					<td class="pop">
						<input type="button" value="신청" onclick="goEvent()">
						<input type="button" value="닫기" onclick="closePop()">
					</td>
				</tr>
			</table>
		</form>
	</div>

	<!-- 본문 시작 -->

	<%@ include file="../Common/header.jsp"%>
	<section>
		<article id="image">Arizona</article>
		<article id="about">
			<div>
				<img src="../Image/paris_cut.jpg" alt="이미지">
			</div>
			<div>
			</div>
		</article>
		<article id="reserve">객실 / 예약 링크</article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>
</html>