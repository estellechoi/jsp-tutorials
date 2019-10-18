<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- daum 도로명주소검색 API 시작 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 우편번호 검색 버튼 클릭하여 함수 호출
	function SearchZip() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	// 사용자가 도로명 주소를 선택했을 경우
	            if (data.userSelectedType === 'R') { 
	                addr = data.roadAddress;
	                
	            // 사용자가 지번 주소를 선택했을 경우(J)
	            } else { 
	                addr = data.jibunAddress;
	            }
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById("zip").value = data.zonecode; // 우편번호
	            document.getElementById("address1").value = addr;  // 주소
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("address2").focus();
	        }
	    }).open();	
	}
	
	function SubmitAddress(form) {
		var cell1 = form.cell1.value;
		var cell2 = form.cell2.value;
		var cell3 = form.cell3.value;
		form.cell.value = cell1 + "-" + cell2 + "-" + cell3;
		
		if (form.destination.value == "") {
			document.getElementById("destination").style.color = "red";
			return false;
		}
		else if (form.recipient.value == "") {
			document.getElementById("recipient").style.color = "red";
			return false;
		}
		else if (form.zip.value == "" || form.address2.value == "") {
			document.getElementById("address").style.color = "red";
			return false;
		}
		else if (form.cell.value.length < 13) {
			document.getElementById("cell").style.color = "red";
			return false;
		}
		else {
			return true;
		}
	}
	
	// 취소
	function Back() {
		history.back();
	}
</script>
<style>
	table {
		width: 800px;
		margin: auto;
	}
	
	table caption {
		padding-top: 30px;
		padding-bottom: 30px;
		font-size: 14px;
		font-weight: bold;
		letter-spacing: 5px;
		color: #495164;
	}
	
	table td {
		padding: 10px;
	}
	
	input[type=button], [type=submit] {
		border: 1px solid #495164;
		border-radius: 5px;
		background: #495164;
		color: white;
		font-size: 12px;
		font-weight: bold;
	}
</style>
</head>
<body>
	<form action="address_add_ok.jsp" method="post" onsubmit="return SubmitAddress(this)">
		<input type="hidden" name="email" value="<%=session.getAttribute("email")%>">
		<table>
			<caption><%=session.getAttribute("username")%>의 배송지 추가</caption>
			<tr>
				<th id="destination">배송지명</th>
				<td><input type="text" name="destination" placeholder="집, 회사,.."></td>
			</tr>
			<tr>
				<th id="recipient">수령인</th>
				<td><input type="text" name="recipient"></td>
			</tr>
			<tr>
				<th id="address">주소</th>
				<td>
					<input type="text" name="zip" id="zip" size="5">
					<input type="button" value="우편번호 찾기" onclick="SearchZip()"><br>
					<input type="text" name="address1" id="address1"><br>
					<input type="text" name="address2" id="address2">
				</td>
			</tr>
			<tr>
				<th id="cell">휴대전화</th>
				<td>
					<input type="hidden" name="cell">
					<input type="text" name="cell1" size="5">-
					<input type="text" name="cell2" size="5">-
					<input type="text" name="cell3" size="5">
				</td>
			</tr>
			<tr>
				<th></th>
				<td>
					<input type="submit" value="저장">
					<input type="button" value="취소" onclick="Back()">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>