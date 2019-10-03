<%@page import="download.DownloadDAO"%>
<%@page import="download.DownloadBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
		String name = multi.getParameter("name");
		String pass = multi.getParameter("pass");
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");

		String file = multi.getFilesystemName("file");
		String org_file = multi.getOriginalFileName("file");
		// 자바빈   패키지 gallery 파일이름 GalleryBean
		// GalleryBean fb 객체생성
		DownloadBean db = new DownloadBean();
		// 자바빈 멤버변수 <= 파라미터 저장
		db.setName(name);
		db.setPass(pass);
		db.setSubject(subject);
		db.setContent(content);
		db.setFile(file);
		// 디비자바파일 패키지 gallery 파일이름 GalleryDAO
		// GalleryDAO fdao 객체생성
		DownloadDAO ddao = new DownloadDAO();
		// insertfile(fb) 메서드호출
		ddao.insertFile(db);

		// 글목록 이동 list.jsp 
		response.sendRedirect("downloadBoard.jsp");
	%>
</body>
</html>