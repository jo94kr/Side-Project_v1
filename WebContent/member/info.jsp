<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/member/info.jsp</h1>
	<%
		// 세션값 가져오기 "id"
		String id = (String) session.getAttribute("id");

		// MemberDAO 객체생성
		MemberDAO mdao = new MemberDAO();
		// 리턴받은 값을 저장할 변수=getMember(전달할값) 메서드 호출
		MemberBean mb = mdao.getMember(id);

	%>
	아이디 :<%=mb.getId()%><br>
	비밀번호 :<%=mb.getPass()%><br>
	이름:<%=mb.getName()%><br>
	가입날짜:<%=mb.getReg_date()%><br>
</body>
</html>

