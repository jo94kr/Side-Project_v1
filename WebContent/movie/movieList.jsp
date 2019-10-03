<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Arrays"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
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
	// 영화 정보 호출

	// 파라미터 설정
	String curPage = request.getParameter("curPage") == null ? "1" : request.getParameter("curPage"); //현재페이지
	String itemPerPage = request.getParameter("itemPerPage") == null
			? "10"
			: request.getParameter("itemPerPage"); //결과row수
	String movieNm = request.getParameter("movieNm") == null ? "" : request.getParameter("movieNm"); //영화명
	String directorNm = request.getParameter("directorNm") == null ? "" : request.getParameter("directorNm"); //감독명
	String openStartDt = request.getParameter("openStartDt") == null ? "" : request.getParameter("openStartDt"); //개봉연도 시작조건 ( YYYY )
	String openEndDt = request.getParameter("openEndDt") == null ? "" : request.getParameter("openEndDt"); //개봉연도 끝조건 ( YYYY )	
	String prdtStartYear = request.getParameter("prdtStartYear") == null
			? ""
			: request.getParameter("prdtStartYear"); //제작연도 시작조건 ( YYYY )
	String prdtEndYear = request.getParameter("prdtEndYear") == null ? "" : request.getParameter("prdtEndYear"); //제작연도 끝조건    ( YYYY )
	String repNationCd = request.getParameter("repNationCd") == null ? "" : request.getParameter("repNationCd"); //대표국적코드 (공통코드서비스에서 '2204'로 조회된 국가코드)
	String[] movieTypeCdArr = request.getParameterValues("movieTypeCdArr") == null
			? null
			: request.getParameterValues("movieTypeCdArr"); //영화형태코드 배열 (공통코드서비스에서 '2201'로 조회된 영화형태코드)

	// 발급키
	String key = "36b777686229d21b2cb567830efabc1e";
	// KOBIS 오픈 API Rest Client를 통해 호출
	KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);

	// 영화코드조회 서비스 호출 (boolean isJson, String curPage, String itemPerPage,String directorNm, String movieCd, String movieNm, String openStartDt,String openEndDt, String ordering, String prdtEndYear, String prdtStartYear, String repNationCd, String[] movieTypeCdArr)
	String movieCdResponse = service.getMovieList(true, curPage, itemPerPage, movieNm, directorNm, openStartDt,
			openEndDt, prdtStartYear, prdtEndYear, repNationCd, movieTypeCdArr);
	// Json 라이브러리를 통해 Handling
	ObjectMapper mapper = new ObjectMapper();
	HashMap<String, Object> result = mapper.readValue(movieCdResponse, HashMap.class);

	request.setAttribute("result", result);

	// KOBIS 오픈 API Rest Client를 통해 코드 서비스 호출 (boolean isJson, String comCode )
	String nationCdResponse = service.getComCodeList(true, "2204");
	HashMap<String, Object> nationCd = mapper.readValue(nationCdResponse, HashMap.class);
	request.setAttribute("nationCd", nationCd);

	String movieTypeCdResponse = service.getComCodeList(true, "2201");
	HashMap<String, Object> movieTypeCd = mapper.readValue(movieTypeCdResponse, HashMap.class);
	request.setAttribute("movieTypeCd", movieTypeCd);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
	
<%String movieTypeCds = "[";
			if (movieTypeCdArr != null) {
				for (int i = 0; i < movieTypeCdArr.length; i++) {
					movieTypeCds += "'" + movieTypeCdArr[i] + "'";
					if (i + 1 < movieTypeCdArr.length) {
						movieTypeCds += ",";
					}
				}
				movieTypeCds += "]";%>
	$(function() {
		var movieTypeCd =
<%=movieTypeCds%>
	;
		$(movieTypeCd).each(
				function() {
					$("input[name='movieTypeCdArr'][value='" + this + "']")
							.prop("checked", true);
				});
	});
<%}%>
	
</script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 메인이미지 -->
		<div id="sub_img_center"></div>
		<!-- 메인이미지 -->

		<!-- 왼쪽메뉴 -->
		<jsp:include page="../inc/sub_menu.jsp" />
		<!-- 왼쪽메뉴 -->
		<!-- 게시판 -->
		<article>
		<h1>Movie List</h1>
		<table id="notice">
			<tr>
				<th class="tno">영화명</th>
				<th class="tdate">제작연도</th>
				<th class="tdate">개봉연도</th>
				<th class="tdate">제작국가</th>
				<th class="tread">감독</th>
			</tr>
			<c:if test="${not empty result.movieListResult.movieList}">
				<c:forEach items="${result.movieListResult.movieList}" var="movie">
					<tr>
						<td><c:out value="${movie.movieNm }" /></td>
						<td><c:out value="${movie.prdtYear }" /></td>
						<td><c:out value="${movie.openDt }" /></td>
						<td><c:out value="${movie.repNationNm}" /></td>
						<td><c:forEach items="${movie.directors}" var="director">
								<c:out value="${director.peopleNm}" />,</c:forEach></td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<form action="">
			<br>
			영화명:<input type="text" name="movieNm" value="<%=movieNm%>"> 감독명:<input type="text" name="directorNm" value="<%=directorNm%>">
			<br />
			국적:<select name="repNationCd">
				<option value="">-전체-</option>
				<c:forEach items="${nationCd.codes}" var="code">
					<option value="<c:out value="${code.fullCd}"/>" <c:if test="${param.repNationCd eq code.fullCd}"> selected="seleted"</c:if>><c:out value="${code.korNm}" /></option>
				</c:forEach>
			</select>
			<br />
			<br />

			<input type="submit" name="" value="조회" class="input_box">
		</form>
		</article>
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>