<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
	function result() {
		// join.jsp id상자 <= 검색한 id
		opener.document.fr.id.value = document.wfr.userid.value;
		opener.document.fr.idcheck.value = "idcheck";
		// 창닫기
		window.close();
	}
</script>
</head>
<body>
	<%
		// userid 파라미터 가져오기
		String id = request.getParameter("userid");
		// MemberDAO 객체생성
		MemberDAO mdao = new MemberDAO();

		// int check = idcheck() 메서드호출
		int check = mdao.idcheck(id);

		// check == 1 아이디중복
		if (check == 1) {
			out.print("중복된 아이디입니다.");
	%>
	<form action="join_idcheck.jsp" method="post" name="wfr">
		아이디:<input type="text" name="userid" value="<%=id%>"> <input type="submit" value="아이디중복확인">
	</form>
	<%
		}
		// check == 0 아이디사용가능
		else if (check == 0) {
			out.print("사용가능한 아이디입니다.");
	%>
	<form action="join_idcheck.jsp" method="post" name="wfr">
		아이디:<input type="text" name="userid" value="<%=id%>" readonly><input type="button" value="아이디사용" onclick="result()">
	</form>
	<%
		}
	%>
</body>
</html>