<%@page import="gallery.GalleryDAO"%>
<%@page import="gallery.GalleryBean"%>
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

		GalleryBean gb = new GalleryBean();

		gb.setNum(num);
		gb.setName(name);

		GalleryDAO gdao = new GalleryDAO();

		if (id.equals(name)) {
			gdao.deleteGallery(gb);
			response.sendRedirect("gallery.jsp?pageNum=" + pageNum);
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