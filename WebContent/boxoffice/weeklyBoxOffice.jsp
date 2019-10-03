<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

<%
	// 주간 박스오피스 순위 호출

	// 파라미터 설정
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	Calendar c1 = Calendar.getInstance();
	c1.add(c1.DATE, -7);
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
</head>
<body>
	<br />
	<div class="clear">
		<h3 class="brown">주간 박스오피스</h3>
		<table>
			<tr>
				<td>순위</td>
				<td>영화명</td>
				<td>개봉일</td>
				<td>관객수</td>
				<td>누적관객수</td>
				<td>상영횟수</td>
			</tr>
			<c:if test="${not empty weeklyResult.boxOfficeResult.weeklyBoxOfficeList}">
				<c:forEach items="${weeklyResult.boxOfficeResult.weeklyBoxOfficeList}" var="boxoffice">
					<tr>
						<td class="contxt"><c:out value="${boxoffice.rank }" /></td>
						<td><c:out value="${boxoffice.movieNm }" /></td>
						<td><c:out value="${boxoffice.openDt }" /></td>
						<td><c:out value="${boxoffice.audiCnt }" /></td>
						<td><c:out value="${boxoffice.audiAcc }" /></td>
						<td><c:out value="${boxoffice.showCnt }" /></td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</div>
</body>
</html>