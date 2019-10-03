<%@page import="download.DownloadBean"%>
<%@page import="download.DownloadDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_member"></div>
		<!-- 본문메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<jsp:include page="../inc/sub_menu.jsp" />
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article>
			<h1>Gallery Update</h1>
			<%
				request.setCharacterEncoding("utf-8");
				int num = Integer.parseInt(request.getParameter("num"));
				String pageNum = request.getParameter("pageNum");
				DownloadDAO ddao = new DownloadDAO();
				DownloadBean db = ddao.getFile(num);
			%>
			<form action="downloadUpdatePro.jsp" method="post" enctype="multipart/form-data">
				<input type="hidden" name="num" value="<%=num%>"> <input type="hidden" name="pageNum" value="<%=pageNum%>"> <input type="hidden" name="oldfile" value="<%=db.getFile()%>">
				<table id="notice">
					<tr>
						<td>작성자</td>
						<td><input type="text" name="name" value="<%=db.getName()%>"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" value="<%=db.getSubject()%>"></td>
					</tr>
					<tr>
						<td>파일</td>
						<%
							if (db.getFile() != null) {
						%>
						<td><input type="file" name="file"> <br> <a href="../upload/<%=db.getFile()%>"><%=db.getFile()%></a> <br></td>
						<%
							} else {
						%>
						<td><input type="file" name="file"></td>
						<%
							}
						%>

					</tr>
					<tr>
						<td>내용</td>
						<td><textarea name="content" rows="10" cols="20"><%=db.getContent()%></textarea></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="수정"><input type="button" value="돌아가기" onclick="history.back()"></td>
					</tr>
				</table>
			</form>
			<div class="clear"></div>
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