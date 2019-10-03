<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService"%>
<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Collection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.util.JSONBuilder"%>
<%@page import="net.sf.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	// 주간 박스오피스 순위 호출
	// 파라메터 설정
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	Calendar c1 = Calendar.getInstance();
	c1.add(c1.DATE, -3);
	String strToday = sdf.format(c1.getTime());

	String targetDt = request.getParameter("targetDt") == null ? strToday : request.getParameter("targetDt"); //조회일자
	String itemPerPage = request.getParameter("itemPerPage") == null ? "5"
			: request.getParameter("itemPerPage"); //결과row수
	String multiMovieYn = request.getParameter("multiMovieYn") == null ? ""
			: request.getParameter("multiMovieYn"); //“Y” : 다양성 영화 “N” : 상업영화 (default : 전체)
	String repNationCd = request.getParameter("repNationCd") == null ? "" : request.getParameter("repNationCd"); //“K: : 한국영화 “F” : 외국영화 (default : 전체)
	String wideAreaCd = request.getParameter("wideAreaCd") == null ? "" : request.getParameter("wideAreaCd"); //“0105000000” 로서 조회된 지역코드

	// 발급키
	String key = "36b777686229d21b2cb567830efabc1e";
	// KOBIS 오픈 API Rest Client를 통해 호출
	KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);

	// 일일 박스오피스 서비스 호출 (boolean isJson, String targetDt, String itemPerPage,String multiMovieYn, String repNationCd, String wideAreaCd)
	String weeklyResponse = service.getWeeklyBoxOffice(true, targetDt, itemPerPage, "0", multiMovieYn,
			repNationCd, wideAreaCd);

	// Json 라이브러리를 통해 Handling
	ObjectMapper mapper = new ObjectMapper();
	HashMap<String, Object> weeklyResult = mapper.readValue(weeklyResponse, HashMap.class);

	request.setAttribute("weeklyResult", weeklyResult);

	// KOBIS 오픈 API Rest Client를 통해 코드 서비스 호출 (boolean isJson, String comCode )
	String codeResponse = service.getComCodeList(true, "0105000000");
	HashMap<String, Object> codeResult = mapper.readValue(codeResponse, HashMap.class);
	request.setAttribute("codeResult", codeResult);
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->


</head>
<body>
	<div id="wrap">
		<!-- 헤더파일들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더파일들어가는 곳 -->
		<!-- 메인이미지 들어가는곳 -->
		<div class="clear"></div>
		<div id="main_img">
			<img src="../images/main_img.jpg" width="971" height="282">
		</div>
		<!-- 메인이미지 들어가는곳 -->
		<!-- 메인 콘텐츠 들어가는 곳 -->
		<article id="front">
		<div id="news_notice">
			<jsp:include page="../boxoffice/dailyBoxOffice.jsp" />
		</div>
		<div id="news_notice">
			<jsp:include page="../boxoffice/weeklyBoxOffice.jsp" />
		</div>
		<div class="clear"></div>
		<div id="sec_news">
			<jsp:include page="../boxoffice/searchBoxOffice.jsp" />
		</div>
		<div id="news_notice">
			<h3 class="brown">News &amp; Notice</h3>
			<table>
				<%
					// BoardDAO bdao 객체생성
					BoardDAO bdao = new BoardDAO();

					// 게시판 전체 글개수 가져오기 select count(*)
					int count = bdao.getBoardCount();

					// 한 화면에 보여줄 글개수 설정
					int pageSize = 5;
					// String pageNum = request.getParameter("pageNum");
					// pageNum = "1" 설정
					String pageNum = "1";

					// 시작하는 행번호 구하기 => 식구하기 => 알고리즘
					int currentPage = Integer.parseInt(pageNum);
					int startRow = (currentPage - 1) * pageSize + 1;
					int endRow = currentPage * pageSize;

					// 날짜형태 변경 => 문자열 변경
					sdf = new SimpleDateFormat("yyyy.MM.dd");
					// List boardList = getBoardList()호출
					List boardList = bdao.getBoardList(startRow, pageSize);
					// 게시판에 글이있으면
					if (count != 0) {
						for (int i = 0; i < boardList.size(); i++) {
							// for   자바빈 <= 배열한칸 정보
							BoardBean bb = (BoardBean) boardList.get(i);
				%>
				<tr onclick="location.href = '../center/content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>'">
					<td class="contxt"><a href="../center/content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getSubject()%></a></td>
					<td><%=sdf.format(bb.getDate())%></td>
				</tr>
				<%
					}
					}
				%>

			</table>
		</div>
		</article>
		<!-- 메인 콘텐츠 들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터 들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는 곳 -->
	</div>
</body>
</html>