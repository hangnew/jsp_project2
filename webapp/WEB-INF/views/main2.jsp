<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 줄바꿈 -->
<% pageContext.setAttribute("replaceChar", "\n"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>42World 사이월드 - ${main.mName}님의 미니홈피</title>
<link rel="stylesheet" href="resources/css/main.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/57a2eb66e4.js"></script>
<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=900622db6a1b86328452062916477a82"></script>
<script type="text/javascript">

// 타이틀 수정 펑션
function changeHide2(){
	$('#mainTitle').addClass('hide');
	$('#mainTitleEdit').removeClass('hide');
	$('#mTitleBtn1').addClass('hide');
	$('#mTitleBtn2').removeClass('hide');
	$('#mTitleBtn3').removeClass('hide');
}

// 타이틀 수정 되돌리기 펑션
function backHide2(){
	$('#mainTitle').removeClass('hide');
	$('#mainTitleEdit').addClass('hide');
	$('#mTitleBtn1').removeClass('hide');
	$('#mTitleBtn2').addClass('hide');
	$('#mTitleBtn3').addClass('hide');
}


// 프로필 수정 펑션
function changeHide() {
	$('#mImgDiv').addClass('hide');
	$('#mImgDivEdit').removeClass('hide');
	$('#mPro').addClass('hide');
	$('#mProEdit').removeClass('hide');
	$('#mEdit').addClass('hide');
	$('#mEditConfirm').removeClass('hide');
}

// 프로필 수정 되돌리기 펑션
function backHide() {
	$('#mImgDiv').removeClass('hide');
	$('#mImgDivEdit').addClass('hide');
	$('#mPro').removeClass('hide');
	$('#mProEdit').addClass('hide');
	$('#mEdit').removeClass('hide');
	$('#mEditConfirm').addClass('hide');
}

// 일촌평 리스트 갖고오는 함수
function readCmnt(){
	$.ajax({
		url : "cmnt.readAll",
		type : "POST",
		data : {
			mIdx : '${main.mIdx}'
		},
		error : function(){
			console.log('error')
		},
		success : function(result) {
			console.log('success')
			console.log(result)
		}
	})
}

// 일촌평 페이지에 출력하는 함수
function showCmnt(){
	
}

$(function(){
	readCmnt();
	
	// 쿠키 확인
	console.log(document.cookie);
	
	// 타이틀 수정 확인 버튼
	$('#mTitleBtn3').click(function(e){
		if (!confirm('미니홈피 타이틀을 수정하시겠습니까?')){
			backHide2();
			e.preventDefault();
		} else {
			$.ajax({
				url : "main.mTitleEdit",
				type : "POST",
				data :{
					mIdx : '${main.mIdx}',
					mTitle : $('#mTitleInput').val()
				},
				error : function(e){
					alert('타이틀 변경에 실패했습니다. 다시 시도해주세요.');
					console.log(e);
				},
				success : function(data){
					$('#mainTitle').html(data);
					backHide2();
				}
			});
		}
	});
	
	// 프로필 수정 확인 버튼
	$('#mEditBtn2').click(function(e){
		if (!confirm('프로필을 수정하시겠습니까?')){
			backHide();
			e.preventDefault();
		} else {
			$.ajax({
				url : "main.mProEdit",
				type : "POST",
				data :{
					mIdx : '${main.mIdx}',
					mPro : $('#mProTextarea').val()
				},
				success : function(data){
					$('#mPro').html(data);
					backHide();
				}
			});
		}
	});

	// 일촌 파도타기 셀렉트 박스 클릭시 해당 유저의 미니홈피로 이동
	$('#m1chonSel').change(function(){
		location.href = $('#m1chonSel').val();
	});
	
	// 일촌평 글자수 체크
	$('#cmntForm').submit(function(e){
		var input = $('#cmntInput')
		if (input.val() == '') {
			input.addClass('red');
			input.attr('placeholder', '일촌평은 한 글자 이상부터 등록 가능합니다.');
			input.focusin;
			e.preventDefault();
		};
	});
	
})
</script>
</head>
<body id="body">
<c:set var="memid" value="${main.memid}"/>
<c:set var="mainName" value="${main.mName}" />
<c:set var="sessionId" value="${sessionId}"/>
<c:set var="cmntList" value="${cmnt}"/>

	<!-- 우측 상단 div (bgm/도토리/검색) -->
	<div id="mainTop">
		<!-- bgm 관련 -->
		<div id="bgmDiv">bgm관련</div>

		<!-- BGM / 도토리 / 일촌 수 테이블 -->
		<div id="qtyDiv">
			<table id="qtyTable">
				<tr>
					<td><i class="fas fa-music"></i>&nbsp;BGM</td>
					<td>100</td>
				</tr>
				<tr>
					<td><i class="fas fa-coins"></i>&nbsp;도토리</td>
					<td>${sessionAcorn}</td>
				</tr>
				<tr>
					<td><i class="fas fa-user-friends"></i>&nbsp;일촌</td>
					<td>${session1chonSize}</td>
				</tr>
			</table>
		</div>

		<!-- 검색창 -->
		<div id="searchDiv">
			<input id="searchInput" name="mname" placeholder="친구를 찾아보세요"
				autocomplete="none"> <input id="searchButton" type="button"
				value="검색">
		</div>
	</div>
	<!-- 우측 상단 div 끝 -->

	<!-- 우측 버튼들 -->
	<div id="topButtons">
		<a href="main.home?memid=${sessionId}"><button id="topBtn1">내
				미니홈피로</button></a><br>
		<button id="topBtn2">회원정보 수정</button>
		<a href="main.logout"><button id="topBtn3">로그아웃</button></a>
	</div>

	<!-- 좌측 미니홈피 프레임 -->
	<div id="frame">
		<!-- 우측 메뉴바 -->
		<div id="mainMenu">
			<div class="menuOn">
				<a href="main.home?memid=${main.memid}">홈</a>
			</div>
			<div class="menuOff">
				<a href="main.home?memid=${main.memid}">다이어리</a>
			</div>
			<div class="menuOff">
				<a href="main.home?memid=${main.memid}">사진첩</a>
			</div>
			<div class="menuOff">
				<a href="main.home?memid=${main.memid}">방명록</a>
			</div>
			<div class="menuOff">
				<a href="main.home?memid=${main.memid}">쇼핑</a>
			</div>
		</div>

		<!-- today / total 카운트 -->
		<div id="visitCount">
			TODAY&nbsp;
			<font style="font-weight: 700;" color="red">${main.mToday}</font>
			&nbsp;ㅣ&nbsp;TOTAL&nbsp; 
			<font style="font-weight: 700;" color="black">${main.mTotal}</font>
		</div>

		<!-- 미니홈피 타이틀 -->
		<div id="mainTitle">${main.mTitle }</div>
		<!--  타이틀 수정할 때 -->
		<div id="mainTitleEdit" class="hide">
			<input id="mTitleInput" value="${main.mTitle}">
		</div>
		<!-- 타이틀 수정 관련 버튼 -->
		<div id="mainTitleBtnDiv">
			<c:if test="${sessionId eq memid }">
				<button id="mTitleBtn1" onclick="changeHide2()"><i class="fas fa-cog"></i></button>
			</c:if>
			<button id="mTitleBtn2" class="hide" onclick="backHide2()"><i class="fas fa-undo-alt"></i></button>
			<button id="mTitleBtn3" class="hide">저장</button>
		</div>

		<!-- 좌측 페이지 -->
		<div id="mainLeft">
		
			<!-- 프로필 이미지 -->
			<div id="mImgDiv">
				<img src="resources/img/mainImg/${main.mImg}" id="mImg">
			</div>
			<!-- 프로필 이미지 수정할 때 -->
			<div id="mImgDivEdit" class="hide">
				수정해봐용
			</div>
			
			<!-- 프로필 문구 -->
			<div id="mPro">${fn:replace(main.mPro, replaceChar, "<br/>")}</div>
			<!-- 프로필 문구 수정할 때 -->
			<div id="mProEdit" class="hide">
				<textarea id="mProTextarea">${main.mPro}</textarea>
			</div>
			
			<!-- 프로필 수정 버튼 -->
			<div id="mEdit">
					<c:if test="${memid eq sessionId}">
						<button id="mEditBtn1" onclick='changeHide()'><i class="fas fa-cog"></i> 프로필 변경하기</button>
					</c:if>
			</div>
			
			<!-- 프로필 수정 버튼 확인 -->
			<div id="mEditConfirm" class="hide">
					<button id="mEditBtn3" onclick='backHide()'><i class="fas fa-undo-alt"></i></button>
					<button id="mEditBtn2">프로필 저장</button>
			</div>
			
			
			<!-- 회원 이름 -->
			<div id="mName">${main.mName}</div>
			
			<!-- 회원 아이디 -->
			<div id="memid">@${main.memid}</div>
			
			<!-- 일촌 셀렉트 -->
			<div id="m1chon">
				<select id="m1chonSel">
					<option selected>일촌 목록</option>
					<c:choose>
						<c:when test="${empty m1chon}">
							<option disabled>아직 일촌이 없습니다</option>
						</c:when>
						<c:otherwise>
							<c:forEach items="${m1chon}" var="map">
								<option value="main.others?memid=${map.memid}">${map.mname}</option>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</select>
			</div>
			
			<!-- 일촌 신청 / 삭제 버튼 -->
			<div id="m1chon">
				<c:choose>
					<c:when test="${ memid ne sessionId}">
							<button id="m1B1">일촌 신청</button>
							<button id="m1B2">일촌 취소</button>
					</c:when>
					<c:otherwise>
							<button id="m1B3">일촌 관리</button>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<!-- 좌측 미니홈피 프레임 끝 -->

		<!-- 우측 페이지 -->
		<div id="mainRight">
			
			<!-- 미니룸 div -->
			<div id="miniroomDiv">
				<!-- 지도를 표시할 div 입니다 -->
				<div id="map" style="width: 710px; height: 300px;"></div>
				<script>
					var node = document.getElementById('map');
			
					//지도 이미지 소스
					var plan = function(x, y, z) {
						return 'resources/img/miniroom/' + '${miniroom.roomOpt}';
					};
			
					//지도 이미지 크기
					kakao.maps.Tileset.add('PLAN', new kakao.maps.Tileset(750, 300, plan,
							'', false, 0, 2));
			
					//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
					var map = new kakao.maps.Map(node, {
						projectionId : null,
						mapTypeId : kakao.maps.MapTypeId.PLAN,
						$scale : false,
						draggable : false,
						// 지도 중앙 좌표
						center : new kakao.maps.Coords(1500, 600),
						level : 2
					});
			
					var imageSrc = 'resources/img/miniroom/' + '${miniroom.minimiOpt}', // 마커이미지의 주소입니다    
					imageSize = new kakao.maps.Size(40, 90), // 마커이미지의 크기입니다
					imageOption = {
						offset : new kakao.maps.Point(27, 69)
					}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
			
					// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
					var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
							imageOption)
			
					// 미니미 좌표
					var minimiX = '${miniroom.minimiX}';
					var minimiY = '${miniroom.minimiY}';
					
					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
						// 마커 좌표
						position : new kakao.maps.Coords(minimiX, minimiY),
						// 마커 이미지 설정
						image : markerImage
					});
					
					// 마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(map);
					
					// 마커 clickable 막기
					marker.setClickable(false);
				</script>
				<a href="minimi.jsp"><button>미니룸 설정</button></a>
			</div>
			
			<!-- 일촌평 -->
			<div id="cmntDiv">
				<div id="cmntTitle">
					what friends say
				</div>
				<!-- 일촌평 작성 div -->
				<div id="cmntInputDiv">
					<form action="cmnt.insert" id="cmntForm">
						<font color="#1897B1" style="font-weight: 700;">&nbsp;&nbsp;일촌평</font>&nbsp;
						<input name="mIdx" type="hidden" value="${main.mIdx}">
						<input name="memid" type="hidden" value="${sessionId}">
						<input name="pageMemid" type="hidden" value="${main.memid}">
						<input name="cCon" id="cmntInput" placeholder="일촌과 나누고 싶은 이야기를 남겨보세요~!">
						<button id="cmntBtnOk">확인</button>
					</form>
				</div>
				<!-- 일촌평 리스트 -->
				<div id="cmntList">
					<c:choose>
						<c:when test="${empty cmnt}">
							<div id="cmntEmpty" style="text-align: center; color: #babec0;">
								아직 등록된 일촌평이 없습니다.
							</div>
						</c:when>
						<c:otherwise> 
							<div id="cmntNotE">
								<c:forEach items="${cmnt}" var="dto">
									<input id="cIdx" type="hidden" value="${dto.cIdx}">
									&middot;
									<c:choose>
										<c:when test="${mainName eq dto.mName }">
											<font style="color:#FF8B2D; font-weight: 700;">${dto.cCon}</font>&nbsp;
											<font style="color:#1897B1; font-weight: 700;">${dto.mName}</font>&nbsp;
										</c:when>
										<c:otherwise>
											${dto.cCon}&nbsp;
											<a href="main.others?memid=${dto.memid}">${dto.mName}</a>
											&nbsp;
										</c:otherwise>
									</c:choose>
									<font style="color: grey; font-size: 10pt;">${dto.cDate}</font>
									<c:if test="${memid eq sessionId}">
										<button id="cmntBtnDel"><i class="fas fa-backspace"></i></button>
									</c:if>
									<br>
								</c:forEach>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			
			
		</div>	
		<!-- 우측 미니홈피 프레임 끝 -->
	</div>
</body>
</html>