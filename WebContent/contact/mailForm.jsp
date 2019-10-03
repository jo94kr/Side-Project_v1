<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>mail</title>

<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
		String id = (String) session.getAttribute("id");

		if (id == null) {
			response.sendRedirect("../member/login.jsp");
		}

		else {
			//MemberDAO 객체생성
			MemberDAO mdao = new MemberDAO();

			// int check = idcheck(id) 메서드호출

			MemberBean mb = mdao.getMember(id);
	%>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 메인이미지 -->
		<div id="sub_img_center"></div>
		<!-- 메인이미지 -->

		<!-- 왼쪽메뉴 -->
		<jsp:include page="../inc/sub_menu.jsp" />
		<!-- 왼쪽메뉴 -->
		<article>
			<h1>Contact</h1>
			<form action="mailSend.jsp" method="post">
				<table id="notice">
					<tr>
						<td>보내는 사람 메일 :</td>
						<td><input type="text" name="sender" value="<%=mb.getEmail()%>"></td>
					</tr>
					<tr>
						<td>받는 사람 메일 :</td>
						<td><input type="text" name="receiver" value="testjo0321@gmail.com" readonly></td>
					</tr>
					<tr>
						<td>제목 :</td>
						<td><input type="text" name="subject"></td>
					</tr>
					<tr>
						<td>내용 :</td>
						<td><textarea name="content" cols=40 rows=20></textarea></td>
					</tr>
					<tr>
						<td align=center colspan=2><input type="submit" value="보내기"></td>
					</tr>
				</table>
			</form>
		</article>
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>
	<%
		}
	%>
</body>
</html>
