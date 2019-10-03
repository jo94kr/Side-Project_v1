<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="board.BoardBean"%>
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
		// 한글처리
		request.setCharacterEncoding("utf-8");
		//id, pass,name 파라미터 값 변수에 저장
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String phone = request.getParameter("phone");

		MemberDAO mdao = new MemberDAO();
		MemberBean mb = new MemberBean();
		// MemberBean mb 객체 생성 멤버 변수 id,pass,name 저장
		mb.setId(id);
		mb.setName(name);
		mb.setEmail(email);
		mb.setAddress(address);
		mb.setPhone(phone);
		// updateMember(mb) 호출
		mdao.updateMember(mb);
		// main.jsp 이동
		response.sendRedirect("../main/main.jsp");
	%>
</body>
</html>