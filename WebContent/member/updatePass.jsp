<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<h1>WebContent/jsp4/updatePro.jsp</h1>
	<%
		String id = request.getParameter("userid");
	%>

	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_member"></div>
		<!-- 본문메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="#">Join us</a></li>
				<li><a href="#">Privacy policy</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article>
			<h1>비밀번호 변경</h1>
			<form action="updatePassPro.jsp?userid=<%=id%>" id="join" method="post" name="fr">
				<fieldset>
					<label> 변경할 비밀번호</label> <input type="password" name="pass1">
					<br>
					<label>변경할 비밀번호 확인</label> <input type="password" name="pass2">
					<br>
				</fieldset>
				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" class="submit" value="비밀번호 변경"><input type="button" value="취소" class="cancel" onclick="history.back()">
				</div>
			</form>
		</article>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->

		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>