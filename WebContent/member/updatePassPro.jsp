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

	<%
		String id = request.getParameter("userid");
		String pass1 = request.getParameter("pass1");
		String pass2 = request.getParameter("pass2");

		MemberDAO mdao = new MemberDAO();

		if (pass1.equals(pass2)) {
			MemberBean mb = new MemberBean();

			mb.setId(id);
			mb.setPass(pass1);
			mdao.updatePassword(mb);
<<<<<<< HEAD
			response.sendRedirect("updateForm.jsp?userid=" + id);
=======
	%>
	<script type="text/javascript">
		alert("비밀번호 변경완료!");
		window.close();
	</script>
	<%
>>>>>>> refs/remotes/origin/master
		} else {
	%>
	<script type="text/javascript">
		alert("비밀번호가 일치하지 않습니다!");
		history.back();
	</script>
	<%
		}
	%>

</body>
</html>