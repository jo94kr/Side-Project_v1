<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
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
	<h1>WebContent/member/deletePro.jsp</h1>
	<%
		// id,pass 파라미터 가져오기
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");

		MemberBean mb = new MemberBean();

		mb.setId(id);
		mb.setPass(pass);

		//MemberDAO 객체생성
		MemberDAO mdao = new MemberDAO();

		// int check = userCheck(id, pass)
		int check = mdao.userCheck(id, pass);

		// check == 1 이면 수정작업
		if (check == 1) {
			// 삭제 deleteMember(id) 호출
			mdao.deleteMember(mb);

			// 세션값 초기화
			session.invalidate();

			response.sendRedirect("../main/main.jsp");
		} else if (check == 0) {
	%>
	<script>
		alert("비밀번호틀림");
		history.back(); //뒤로이동
	</script>
	<%
		} else if (check == -1) {
	%>
	<script>
		alert("아이디없음");
		history.back(); //뒤로이동
	</script>
	<%
		}
	%>

</body>
</html>