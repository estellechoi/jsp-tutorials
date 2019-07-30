<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!doctype html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>유진의 블로그</title>
<link rel="stylesheet" href="../Style/commonStyle.css">
<style>
	
	#aa {
		background-image: url("../Img/paris_cut.jpg");
		margin: 10px;
		border: none;
		border-radius: 10px;
		opacity: 0.5;
		color: white;
		font-size: 30px;
		font-weight: bold;
		font-style: italic;
		display: flex;
		justify-content: center;
		align-items: flex-start;
	}
	
</style>
</head>

<body>
	<%@ include file="../Common/header.jsp"%>
	<section>
		<%@ include file="../Common/sidebar.jsp"%>
		<article id="aa"> 이벤트 확인하러 가기 >> </article>
		<article id="bb"></article>
		<article id="cc"></article>
	</section>
	<%@ include file="../Common/footer.jsp"%>
</body>

</html>