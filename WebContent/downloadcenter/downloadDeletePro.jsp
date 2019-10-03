<%@page import="download.DownloadDAO"%>
<%@page import="download.DownloadBean"%>
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
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8"); // 이름은 한글이니까 한글처리 먼저
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		String name = request.getParameter("name");
		String id = (String) session.getAttribute("id");

		DownloadBean db = new DownloadBean();

		db.setNum(num);
		db.setName(name);

		DownloadDAO ddao = new DownloadDAO();

		if (id.equals(name)) {
			ddao.deleteFile(db);
			response.sendRedirect("downloadBoard.jsp?pageNum=" + pageNum);
		}

		else {
	%>
	<script>
		alert("글없음");
		history.back(); //뒤로이동
	</script>
	<%
		}
	%>
</body>
</html>