<%@page import="board.BoardBean"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
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

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b7d1a62ee33afbb19ea5220fa1347229&libraries=services"></script>
<script type="text/javascript">
	function updatePass() {
		if (document.fr.pass.value == "") {
			alert("비밀번호를 입력하세요!");
			return;
		} else if (document.fr.pass.value != document.fr.oriPass.value) {
			alert("비밀번호가 일치하지 않습니다.")
			return;
		} else {
			var fid = document.fr.id.value
			location.href = "updatePass.jsp?userid=" + fid;
		}
	}
</script>
</head>
<body>
	<%
		String id = (String) session.getAttribute("id");

		// MemberDAO 객체생성
		MemberDAO mdao = new MemberDAO();

		// int check = idcheck(id) 메서드호출

		MemberBean mb = mdao.getMember(id);
	%>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_member"></div>
		<!-- 본문메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="#">Join us</a></li>
				<li><a href="#">Privacy policy</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article>
			<h1>Join Us</h1>
			<form action="updatePro.jsp" id="join" name="fr" method="post">
				<fieldset>
					<legend>Basic Info</legend>
					<label>User ID</label> <input type="text" name="id" class="id" value="<%=id%>" readonly>
					<br>
					<label>Password</label> <input type="password" name="pass"> <input type="button" name="upPass" class="dup" value="비밀번호 변경" onclick="updatePass()"> <input type="hidden" name="oriPass" value="<%=mb.getPass()%>">
					<br>
					<label>Name</label> <input type="text" name="name" value="<%=mb.getName()%>">
					<br>
					<label>E-Mail</label> <input type="email" name="email" value="<%=mb.getEmail()%>">
					<br>
					<label>Address</label><input type="text" id="address" name="address" value="<%=mb.getAddress()%>"><input type="button" class="dup" onclick="execDaumPostcode()" value="주소 검색">
					<br>
					<div id="map" style="width: 300px; height: 300px; margin-top: 10px; display: none"></div>
					<script>
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div
						mapOption = {
							center : new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
							level : 5
						// 지도의 확대 레벨
						};

						//지도를 미리 생성
						var map = new daum.maps.Map(mapContainer, mapOption);
						//주소-좌표 변환 객체를 생성
						var geocoder = new daum.maps.services.Geocoder();
						//마커를 미리 생성
						var marker = new daum.maps.Marker({
							position : new daum.maps.LatLng(37.537187,
									127.005476),
							map : map
						});

						function execDaumPostcode() {
							new daum.Postcode(
									{
										oncomplete : function(data) {
											var addr = data.address; // 최종 주소 변수
											// 주소 정보를 해당 필드에 넣는다.
											document.getElementById("address").value = addr;
											// 주소로 상세 정보를 검색
											geocoder
													.addressSearch(
															data.address,
															function(results,
																	status) {
																// 정상적으로 검색이 완료됐으면
																if (status === daum.maps.services.Status.OK) {

																	var result = results[0]; //첫번째 결과의 값을 활용

																	// 해당 주소에 대한 좌표를 받아서
																	var coords = new daum.maps.LatLng(
																			result.y,
																			result.x);
																	// 지도를 보여준다.
																	mapContainer.style.display = "block";
																	map
																			.relayout();
																	// 지도 중심을 변경한다.
																	map
																			.setCenter(coords);
																	// 마커를 결과값으로 받은 위치로 옮긴다.
																	marker
																			.setPosition(coords)
																}
															});
										}
									}).open();
						}
					</script>
					<label>Phone</label><input type="text" name="phone" value="<%=mb.getPhone()%>">
					<br>
					<input type="button" value="회원탈퇴" class="dup" onclick="location.href='deleteMember.jsp?userid=<%=id%>'">
				</fieldset>

				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="수정" class="submit"> <input type="reset" value="취소" class="cancel" onclick="location.href='../main/main.jsp?userid=<%=id%>'">
				</div>
			</form>
		</article>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->

		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>