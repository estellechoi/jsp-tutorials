<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	input {
		font-size: 12px;
	}
</style>
<!-- daum 도로명주소검색 API 시작 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 우편번호 검색 버튼 클릭하여 함수 호출
	function search_address() {
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
</script>
<!-- daum 도로명주소검색 API 끝 -->
</head>
<body>
	<form action="product_buynow_address_add_ok.jsp" method="post">
		<table>
			<caption>배송지 등록</caption>
			<input type="hidden" name="email" value="<%=email%>">
			<tr>
				<th>배송지명</th>
				<td><input type="text" name="destination"></td>
			</tr>
			<tr>
				<th>수령인</th>
				<td><input type="text" name="recipient"></td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input type="text" name="zip" id="zip">
					<input type="button" value="우편번호 찾기" onclick="search_address()"><p></p>
					<input type="text" name="address1" id="address1"><p></p>
					<input type="text" name="address2" id="address2">
				</td>
			</tr>
			<tr>
				<th>휴대전화</th>
				<td><input type="text" name="cell" placeholder="000-0000-0000"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="checkbox" name="change_member" value="1"> 기본 배송지로 지정하기 <p></p>
					<input type="submit" value="저장">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>