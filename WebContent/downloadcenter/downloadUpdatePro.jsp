<%@page import="download.DownloadDAO"%>
<%@page import="download.DownloadBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Driver"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//한글처리
		// request.setCharacterEncoding("utf-8");
		// cos.jar 프로그램 이용  파일업로드
		// MultipartRequest 객체생성
		//MultipartRequest multi=new MultipartRequest(request,업로드할폴더명,파일최대크기,한글처리,파일명이 동일 이름변경);
		//  upload 폴더 만들기 => upload 물리적 경로
		String uploadPath = request.getRealPath("/upload");
		System.out.println(uploadPath);
		int maxSize = 5 * 1024 * 1024; //5M
		MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8",
				new DefaultFileRenamePolicy());

		//request  name,pass,subject,content 파라미터 가져와서 => 변수 저장
		int num = Integer.parseInt(multi.getParameter("num"));
		String pageNum = multi.getParameter("pageNum");
		String name = multi.getParameter("name");
		String pass = multi.getParameter("pass");
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");
		String file = multi.getFilesystemName("file");
		String oldfile = multi.getParameter("oldfile");
		String org_file = multi.getOriginalFileName("file");

		String id = (String) session.getAttribute("id");

		DownloadBean db = new DownloadBean();
		db.setNum(num);
		db.setName(name);
		db.setPass(pass);
		db.setSubject(subject);
		db.setContent(content);

		if (file == null) {
			db.setFile(oldfile);
		} else {
			db.setFile(file);
		}

		DownloadDAO ddao = new DownloadDAO();

		if (id.equals(name)) {
			ddao.updateFile(db);
			response.sendRedirect("downloadBoard.jsp?pageNum=" + pageNum);
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
