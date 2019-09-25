<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 전체동의 -->
<input type="checkbox" id="agree_master" onclick="AgreeAll(this)">
<!-- 전체동의 스크립트 -->
<script src="../Etc/signup_agreement.js"></script>

<!-- 세부 동의 -->
<input type="checkbox" name="agree1" id="" class="agree" onclick="Check()">
<input type="checkbox" name="agree2" id="" class="agree" onclick="Check()">
<input type="checkbox" name="agree3" id="" class="agree" onclick="Check()">
<input type="checkbox" name="agree4" id="" class="agree" onclick="Check()">

</body>
</html>