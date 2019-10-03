<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	<%
		// cos.jar 프로그램 이용 파일업로드	
		// MultipartRequest 객체생성
		//	MultipartRequest multi = new MultipartRequest(request, 업로드할폴더명, 파일최대크기, 한글처리, 파일명이 동일하면 이름변경);
		// upload 폴더 만들기 => upload 물리적 경로
		String uploadPath = request.getRealPath("/upload");
		// 첨부파일 크기
		int maxSize = 5 * 1024 * 1024; // 5M
		MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8",
				new DefaultFileRenamePolicy());

		//int num =  파라미터 num 가져와서 저장
		int num = Integer.parseInt(multi.getParameter("num"));
		String pageNum = multi.getParameter("pageNum");
		String pass = multi.getParameter("pass");
		String name = multi.getParameter("name");
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");
		String oldfile = multi.getParameter("oldfile");
		String file = multi.getFilesystemName("file");
		String org_file = multi.getOriginalFileName("file");
		String id = (String) session.getAttribute("id");

		// BoardBean bb
		BoardBean bb = new BoardBean();

		// 멤버변수 <= 파라미터 값
		bb.setNum(num);
		bb.setPass(pass);
		bb.setName(name);
		bb.setSubject(subject);
		bb.setContent(content);

		if (file == null) {
			bb.setFile(oldfile);
		} else {
			bb.setFile(file);

		}

		// BoardDAO bdao 객체생성
		BoardDAO bdao = new BoardDAO();

		if (id.equals(name)) {
			bdao.updateBoard(bb);
			response.sendRedirect("notice.jsp?pageNum=" + pageNum);
		} else {
	%>
	<script>
		alert("회원정보 불일치");
		history.back(); //뒤로이동
	</script>
	<%
		}
	%>
</body>
</html>