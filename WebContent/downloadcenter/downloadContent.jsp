<%@page import="download.DownloadBean"%>
<%@page import="download.DownloadDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
		<div id="sub_img_center"></div>
		<!-- 본문메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<jsp:include page="../inc/sub_menu.jsp" />
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<%
			//int num = 파라미터 num 가져오기
			int num = Integer.parseInt(request.getParameter("num"));
			String pageNum = request.getParameter("pageNum");
			DownloadDAO ddao = new DownloadDAO();
			ddao.updateReadCount(num);
			DownloadBean db = ddao.getFile(num);
			String content = db.getContent();
			if (content != null) {
				content = content.replace("\r\n", "<br>");
			}
		%>
		<!-- 게시판 -->
		<article>
			<h1>Gallery Content</h1>
			<table id="notice">
				<tr>
					<th class="tno">글번호</th>
					<td><%=db.getNum()%></td>
					<th class="tno">글쓴날짜</th>
					<td><%=db.getDate()%></td>
				</tr>
				<tr>
					<th class="tno">글쓴이</th>
					<td><%=db.getName()%></td>
					<th class="tno">조회수</th>
					<td><%=db.getReadcount()%></td>
				</tr>
				<tr>
					<th class="tno">제목</th>
					<td colspan="3"><%=db.getSubject()%></td>
				</tr>
				<tr>
					<th class="tno">첨부파일</th>
					<td colspan="3"><a href="file_down2.jsp?file_name=<%=db.getFile()%>"><%=db.getFile()%> 다운로드</a></td>
				</tr>
				<tr>
					<th class="tno">내용</th>
					<td colspan="3"><%=content%></td>
				</tr>
			</table>
			<div id="table_search">
				<%
					// 세션값 가져오기
					String id = (String) session.getAttribute("id");

					// 세션값 있으면
					if (id != null) {
						//   세션값  글쓴이 일치하면  글수정 글삭제 버튼 보이기
						if (id.equals(db.getName())) {
				%>
				<input type="button" value="글수정" class="btn" onclick="location.href='downloadUpdate.jsp?num=<%=db.getNum()%>&pageNum=<%=pageNum%>'"> <input type="button" value="글삭제" class="btn" onclick="location.href='downloadDelete.jsp?num=<%=db.getNum()%>&pageNum=<%=pageNum%>&name=<%=db.getName()%>'">
				<%
					}
					}
				%>

				<input type="button" value="글목록" class="btn" onclick="location.href='downloadBoard.jsp?num=<%=db.getNum()%>&pageNum=<%=pageNum%>'">
			</div>
			<div class="clear"></div>
			<div id="page_control"></div>
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