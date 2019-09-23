<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
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
	<h1>WebContent/jsp4/updatePro.jsp</h1>
	<%
		String id = request.getParameter("userid");
	%>
	<form action="updatePassPro.jsp?userid=<%=id%>" method="post" name="fr">
		변경할 비밀번호 <input type="password" name="pass1">
		<br>
		변경할 비밀번호 확인 <input type="password" name="pass2">
		<br>
		<input type="submit" value="비밀번호 변경"><input type="button" value="취소" onclick="window.close()">
	</form>
</body>
</html>