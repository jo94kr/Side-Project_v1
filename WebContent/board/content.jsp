<%@page import="java.util.List"%>
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
	<h1>WebContent/board/content.jsp</h1>
	<%
		// int num =  파라미터 num 가져와서 저장
		int num = Integer.parseInt(request.getParameter("num"));

		// BoardDAO bdao 객체생성
		BoardDAO bdao = new BoardDAO();

		// updateReadcount(num) 조회수 증가 메서드 호출
		// BoardBean bb = getBoard(num)  num에 해당하는 게시판 글 가져오기
		BoardBean bb = bdao.getBoard(num);
	%>
	<table border="1">
		<tr>
			<td>글번호</td>
			<td><%=bb.getNum()%></td>
			<td>글쓴날짜</td>
			<td><%=bb.getDate()%></td>
		</tr>
		<tr>
			<td>글쓴이</td>
			<td><%=bb.getName()%></td>
			<td>조회수</td>
			<td><%=bb.getReadcount()%></td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3"><%=bb.getSubject()%></td>
		</tr>
		<%
			if (bb.getFile() != null) {
		%>
		<tr>
			<td>파일</td>
			<td colspan="3"><a href="../upload/<%=bb.getFile()%>"><%=bb.getFile()%></a> <img src="../upload/<%=bb.getFile()%>" width="50" height="50"></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td>내용</td>
			<td colspan="3"><%=bb.getContent()%></td>
		</tr>
		<tr>
			<td colspan="4"><input type="button" value="글수정" onclick="location.href='updateForm.jsp?num=<%=num%>'"> <input type="button" value="글삭제" onclick="location.href='deleteForm.jsp?num=<%=num%>'"> <input type="button" value="글목록" onclick="location.href='../center/notice.jsp'"></td>
		</tr>
	</table>
</body>
</html>