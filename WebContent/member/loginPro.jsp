<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		// 한글처리
		request.setCharacterEncoding("utf-8");

		// 파라미터 가져오기
		//request  id,pass 파라미터 가져와서 => 변수 저장
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");

		// MemberDAO mdao 객체생성
		MemberDAO mdao = new MemberDAO();

		// 로그인 인증(폼아이디,비밀번호 / 디비아이디,비밀번호 일치 확인
		//		=>일치하면 권한부여/페이지 상관없이 값을 저장사용)
		// int check = userCheck(id,pass)메서드호출
		int check = mdao.userCheck(id, pass);

		// check==1 세션값 생성 "id",id  main.jsp 이동
		if (check == 1) {
			// 세션값 생성  "id",id
			session.setAttribute("id", id);
			// 이동 main.jsp 
			response.sendRedirect("../main/main.jsp");
		}
		// check==0 "비밀번호틀림" 뒤로이동
		else if (check == 0) {
	%>
	<script>
		alert("비밀번호틀림");
		history.back(); //뒤로이동
	</script>
	<%
		}
		// check==-1 "아이디없음" 뒤로이동
		else if (check == -1) {
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