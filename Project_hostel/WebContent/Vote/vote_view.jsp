<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../Common/DBconnection.jsp"%>
<%
	sql = "select*from vote where id=1";
	rs = stmt.executeQuery(sql);
	rs.next();
	// 전체 투표수
	int total = rs.getInt("a1") + rs.getInt("a2") + rs.getInt("a3")
			+ rs.getInt("a4") + rs.getInt("a5") + rs.getInt("a6")
			+ rs.getInt("a7");

	// 항목별 투표 비율 구하기
	double a1 = (rs.getInt("a1") * 100 / total);
	double a2 = (rs.getInt("a2") * 100 / total);
	double a3 = (rs.getInt("a3") * 100 / total);
	double a4 = (rs.getInt("a4") * 100 / total);
	double a5 = (rs.getInt("a5") * 100 / total);
	double a6 = (rs.getInt("a6") * 100 / total);
	double a7 = (rs.getInt("a7") * 100 / total);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
section:nth-child(1) {
	padding-top: 50px;
	text-align: center;
}

section:nth-child(1) a {
	text-decoration: none;
	color: #5566BC;
	font-weight: bold;
}

section:nth-child(1) a:hover {
	text-decoration: underline;
}

section:nth-child(2) {
	padding-top: 50px;
	margin : auto;
	width: 842px;
	margin: auto;
}

#summary {
	border: 1px solid lightgrey;
	border-radius: 10px;
	box-shadow: 1px 1px 3px lightgrey;
}

#summary td {
	width: 100px;
	text-align: center;
}

#graph {
	border: 1px solid lightgrey;
	border-radius: 10px;
	box-shadow: 1px 1px 3px lightgrey;
	width: 840px;
}

#graph .field {
	text-align: center;
	width: 120px;
	font-size: 14px;
	font-weight: bold;
}

#graph .result {
	text-align: left;
}

#graph tr {
	height: 40px;
}

#graph td div {
	height: 30px;
	color: white;
	font-size: 13px;
	padding-left: 10px;
	overflow: hidden;
	display: table-cell;
	vertical-align: middle;
	background: #5566BC;
}

#a1 {
	width: <%=a1 * 4%>px;
}

#a2 {
	width: <%=a2 * 10%>px;
}

#a3 {
	width: <%=a3 * 10%>px;
}

#a4 {
	width: <%=a4 * 10%>px;
}

#a5 {
	width: <%=a5 * 10%>px;
}

#a6 {
	width: <%=a6 * 10%>px;
}

#a7 {
	width: <%=a7 * 10%>px;
}
</style>
</head>
<body>
	<section>
		<a href="../Vote/vote.jsp">재투표</a>
	</section>
	<section>

		<table id="graph">
			<caption>
				<h3>당신이 좋아하는 안주는 ?</h3>
			</caption>
			<tr>
				<td class="field">생선회</td>
				<td class="result">
					<div id="a1">
						<%=a1%>
						%
					</div>
				</td>
			</tr>
			<tr>
				<td class="field">소곱창</td>
				<td class="result">
					<div id="a2"><%=a2%>
						%
					</div>
				</td>
			</tr>
			<tr>
				<td class="field">두부김치</td>
				<td class="result">
					<div id="a3"><%=a3%>
						%
					</div>
				</td>
			</tr>
			<tr>
				<td class="field">양꼬치</td>
				<td class="result">
					<div id="a4"><%=a4%>
						%
					</div>
				</td>
			</tr>
			<tr>
				<td class="field">초밥</td>
				<td class="result">
					<div id="a5"><%=a5%>
						%
					</div>
				</td>
			</tr>
			<tr>
				<td class="field">감자탕</td>
				<td class="result">
					<div id="a6"><%=a6%>
						%
					</div>
				</td>
			</tr>
			<tr>
				<td class="field">족발</td>
				<td class="result">
					<div id="a7"><%=a7%>
						%
					</div>
				</td>
			</tr>
		</table>
		<p></p>
		<table id="summary">
			<tr style="font-size: 13px">
				<td><b>생선회</b></td>
				<td><b>소곱창</b></td>
				<td><b>두부김치</b></td>
				<td><b>양꼬치</b></td>
				<td><b>초밥</b></td>
				<td><b>감자탕</b></td>
				<td><b>족발</b></td>
				<td><b>총 투표수</b></td>
			</tr>
			<tr>
				<td><%=rs.getInt("a1")%></td>
				<td><%=rs.getInt("a2")%></td>
				<td><%=rs.getInt("a3")%></td>
				<td><%=rs.getInt("a4")%></td>
				<td><%=rs.getInt("a5")%></td>
				<td><%=rs.getInt("a6")%></td>
				<td><%=rs.getInt("a7")%></td>
				<td><%=total%></td>
			</tr>
		</table>
	</section>
</body>
</html>