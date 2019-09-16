<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/board/list.jsp</h1>
	<%
		// BoardDAO bdao 객체생성  
		BoardDAO bdao = new BoardDAO();
		// 게시판 전체 글개수  가져오기  select count(*)
		int count = bdao.getBoardCount();
		// 한 화면에 보여줄 글개수 설정
		int pageSize = 3;
		// 현페이지 가져오기
		//  http://localhost:8080/StudyJSP/board/list.jsp
		//  http://localhost:8080/StudyJSP/board/list.jsp?pageNum=3
		String pageNum = request.getParameter("pageNum");
		// pageNum 없으면  pageNum="1" 설정
		if (pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		// 시작하는 행번호 구하기 => 식구하기 => 알고리즘
		// pageNum(currentPage)  pageSize  => startRow  
		//    1                     10     =>  0*10+1=> 0+1=> 1
		//    2                     10     =>  1*10+1=>10+1=> 11
		//    3                     10     =>  2*10+1=>20+1=> 21

		int startRow = (currentPage - 1) * pageSize + 1;
		// pageNum  pageSize => endRow
		//    1         10     =>   10
		//    2         10     =>   20
		int endRow = currentPage * pageSize;

		// List boardList = getBoardList()호출
		// select * from board order by num desc  첫행 ,몇개
		// select * from board order by num desc  limit 첫행-1 ,몇개
		// List boardList=bdao.getBoardList();
		// List boardList=bdao.getBoardList(첫행,몇개);
		List boardList = bdao.getBoardList(startRow, pageSize);
	%>
	<h1>
		글목록 [ 게시판 글개수 :
		<%=count%>
		]
	</h1>
	<table border="1">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>날짜</td>
			<td>조회수</td>
		</tr>
		<%
			for (int i = 0; i < boardList.size(); i++) {
				//  BoardBean bb = 배열 첫번째 칸  배열이름.get()
				BoardBean bb = (BoardBean) boardList.get(i);
		%><tr>
			<td><%=bb.getNum()%></td>
			<td><a href="content.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject()%></a></td>
			<td><%=bb.getName()%></td>
			<td><%=bb.getDate()%></td>
			<td><%=bb.getReadcount()%></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="5"><input type="button" value="글작성" onclick="location.href='fwriteForm.jsp'"></td>
		</tr>
	</table>
	<%
		// 전체 페이지수 구하기     전체글개수 50 한화면 글개수 10 => 전체 페이지수 5+0 => 5
		//                  전체글개수 55 한화면 글개수 10 => 전체 페이지수 5+1 =>6 
		//int pageCount=count/pageSize + (조건?참값:거짓값);
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		// 한화면에 보여줄  페이지 개수 설정
		int pageBlock = 3;
		// 시작하는 페이지 번호 구하기  1~10 => 1 
		// pageNum(currentPage)  pageBlock  => startPage
		//   1~ 10                  10      =>  ((1~10)/10)*10+1=>0*10+1=>  0+1=>1
		//   11~ 20                 10      =>  ((11~20)/10)*10+1=>1*10+1=> 10+1=>11
		//   21~ 30                 10      =>  ((21~30)/10)*10+1=>2*10+1=> 20+1=>21
		int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
		// 끝 페이지 번호 구하기
		// startPage   pageBlock     =>  endPage
		//    1           10         =>    10
		//    11          10         =>    20
		//    21          10         =>    30
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		// [이전]
		if (startPage > pageBlock) {
	%><a href="list.jsp?pageNum=<%=startPage - pageBlock%>">[이전]</a>
	<%
		}
		//  1 2 3 .... 10      11 12 13 .... 20
		for (int i = startPage; i <= endPage; i++) {
	%><a href="list.jsp?pageNum=<%=i%>"><%=i%></a>
	<%
		}
		// [다음]
		if (endPage < pageCount) {
	%><a href="list.jsp?pageNum=<%=startPage + pageBlock%>">[다음]</a>
	<%
		}
	%>
	<!--       1 2 3 .... 10 [다음] -->
	<!-- [이전] 11 12 13 .... 20    -->

</body>
</html>
