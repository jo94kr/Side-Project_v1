<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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
	<h1>WebContent/jsp5/deletePro.jsp</h1>
	<%
		//int num =  파라미터 num 가져와서 저장
		int num = Integer.parseInt(request.getParameter("num"));
		String pass = request.getParameter("pass");

		BoardBean bb = new BoardBean();

		// 멤버변수 <= 파라미터 값
		bb.setNum(num);
		bb.setPass(pass);

		// BoardDAO bdao 객체생성
		BoardDAO bdao = new BoardDAO();

		// int check = checkNum(bb)
		int check = bdao.checkNum(bb);

		if (check == 1) {
			bdao.deleteBoard(bb);
			response.sendRedirect("list.jsp");
		}

		else if (check == 0) {
	%>
	<script>
		alert("비밀번호틀림");
		history.back(); //뒤로이동
	</script>
	<%
		}

		else if (check == -1) {
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