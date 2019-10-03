<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/jsp5/deletePro.jsp</h1>
	<%
		//int num =  파라미터 num 가져와서 저장
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		String name = request.getParameter("name");
		String id = (String) session.getAttribute("id");

		BoardBean bb = new BoardBean();

		// 멤버변수 <= 파라미터 값
		bb.setNum(num);
		bb.setName(name);

		// BoardDAO bdao 객체생성
		BoardDAO bdao = new BoardDAO();

		if (id.equals(name)) {
			bdao.deleteBoard(bb);
			response.sendRedirect("notice.jsp?pageNum=" + pageNum);
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