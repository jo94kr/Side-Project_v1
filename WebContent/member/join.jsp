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
	function idcheckval() {
		document.fr.idcheck.value = "uncheck";
	}
	
	function iddupcheck() {
		// 아이디 상자가 비어있으면 "아이디입력하세요" 포커스 함수호출한곳으로 되돌아가기
		if (document.fr.id.value == "") {
			alert("아이디 입력하세요.");
			document.fr.id.focus();
			return;
		}
		// 창열기 "join_idcheck.jsp", "", "width=, height="
		else {
			var fid = document.fr.id.value
			window.open("join_idcheck.jsp?userid=" + fid, "",
					"width = 300, height = 200");
		}
	}
	
	function joincheck() {
		if (document.fr.id.value.length == 0) {
			alert("아이디 입력하세요");
			document.fr.id.focus();
			return;
		}
		// 아이디 길이가 4자 아니면 "아이디길이는 4자입니다." 아이디 상자에 포커스 깜박
		if (document.fr.id.value.length < 4){
			alert("아이디길이는 4자 이상 입니다.")
			document.fr.id.select();
			document.fr.id.focus();
			return;
		}
		if(document.fr.idcheck.value != "idcheck"){
			alert("아이디 중복체크를 해주세요.");
			return;
			
		}
		if (document.fr.pass.value.length == 0) {
			alert("비밀번호 입력하세요");
			document.fr.pass.focus();
			return;
		}
		// 비밀번호의 길이가 4~7자가 아니면 "비밀번호는 4~7자입니다." 비밀번호 상자에 포커스 깜박
		if (document.fr.pass.value.length < 4 || document.fr.pass.value.length > 7){
			alert("비밀번호는 4~7자입니다.")
			document.fr.pass.value = "";
			document.fr.pass.focus();
			return;
		}
		if(document.fr.pass.value != document.fr.pass2.value){
			alert("비밀번호가 일치하지 않습니다.")
			document.fr.pass2.value = "";
			document.fr.pass2.focus();
			return;
		}

		if (document.fr.name.value.length == 0) {
			alert("이름을 입력하세요");
			document.fr.name.focus();
			return;
		}
		
		if (document.fr.email.value.length == 0) {
			alert("E-Mail을 입력하세요");
			document.fr.pass.focus();
			return;
		}
		if(document.fr.email.value != document.fr.email2.value){
			alert("E-Mail이 일치하지 않습니다.")
			document.fr.email2.select();
			document.fr.email2.focus();
			return;
		}
		
		
		document.fr.submit();
		return;
	}
</script>
</head>
<body>
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
			<form action="joinPro.jsp" id="join" name="fr" method="post">
				<fieldset>
					<legend>Basic Info</legend>
					<label>User ID</label><input type="text" name="id" class="id" onkeydown="idcheckval()"><input type="button" value="dup. check" class="dup" onclick="iddupcheck()"> <input type="hidden" name="idcheck" value="uncheck">
					<br>
					<label>Password</label> <input type="password" name="pass">
					<br>
					<label>Retype Password</label> <input type="password" name="pass2">
					<br>
					<label>Name</label> <input type="text" name="name">
					<br>
					<label>E-Mail</label> <input type="email" name="email">
					<br>
					<label>Retype E-Mail</label> <input type="email" name="email2">
					<br>
				</fieldset>

				<fieldset>
					<legend>Optional</legend>
					<label>Address</label> <input type="text" id="address" name="address" readonly> <input type="button" onclick="execDaumPostcode()" value="주소 검색" class="dup">
					<br>
					<label>상세주소</label><input type="text" id="address" name="address2" value=" ">
					<br>
					<div id="map" style="width: 300px; height: 300px; margin-top: 10px; display: none"></div>
					<script>
					    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
					        mapOption = {
					            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
					            level: 5 // 지도의 확대 레벨
					        };
					
					    //지도를 미리 생성
					    var map = new daum.maps.Map(mapContainer, mapOption);
					    //주소-좌표 변환 객체를 생성
					    var geocoder = new daum.maps.services.Geocoder();
					    //마커를 미리 생성
					    var marker = new daum.maps.Marker({
					        position: new daum.maps.LatLng(37.537187, 127.005476),
					        map: map
					    });
					
					
					    function execDaumPostcode() {
					        new daum.Postcode({
					            oncomplete: function(data) {
					                var addr = data.address; // 최종 주소 변수
					
					                // 주소 정보를 해당 필드에 넣는다.
					                document.getElementById("address").value = addr;
					                // 주소로 상세 정보를 검색
					                geocoder.addressSearch(data.address, function(results, status) {
					                    // 정상적으로 검색이 완료됐으면
					                    if (status === daum.maps.services.Status.OK) {
					
					                        var result = results[0]; //첫번째 결과의 값을 활용
					
					                        // 해당 주소에 대한 좌표를 받아서
					                        var coords = new daum.maps.LatLng(result.y, result.x);
					                        // 지도를 보여준다.
					                        mapContainer.style.display = "block";
					                        map.relayout();
					                        // 지도 중심을 변경한다.
					                        map.setCenter(coords);
					                        // 마커를 결과값으로 받은 위치로 옮긴다.
					                        marker.setPosition(coords)
					                    }
					                });
					            }
					        }).open();
					    }
					</script>
					<br>
					<label>Phone Number</label> <input type="text" name="phone">
					<br>
					<label>Mobile Phone Number</label> <input type="text" name="mobile">
					<br>
				</fieldset>
				<div class="clear"></div>
				<div id="buttons">
					<input type="button" value="회원가입" class="submit" onclick="joincheck()"> <input type="reset" value="Cancel" class="cancel">

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