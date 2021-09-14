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
// 메인 타이틀 갖고오는 ajax 함수 (타이틀 수정 후 저장하면 호출)
function readTitle(){
	$.ajax({
		url : "main.readTitle",
		type : "GET",
		data : {
			mIdx : '${main.mIdx}'
		},
		error : function(){
			console.log('타이틀 불러오지 못함')
		},
		success : function(title){
			console.log('타이틀 불러오기 성공')
			showTitle(title.mTitle)
		}
	})
}

// 타이틀 출력 함수
function showTitle(title){
	$('#mainTitle').text(title)
}

// 타이틀 수정 버튼 클릭시 css class(hide) 추가+제거하는 함수
function editTitle(){
	$('#mainTitle').addClass('hide')
	$('#mTitleBtn1').addClass('hide')
	$('#mainTitleEdit').removeClass('hide')
	$('#mTitleBtn2').removeClass('hide')
	$('#mTitleBtn3').removeClass('hide')
}

// 타이틀 수정 - 취소 클릭시 css class(hide) 원래대로 돌리는 함수
function editTitleBack(){
	$('#mainTitle').removeClass('hide')
	$('#mTitleBtn1').removeClass('hide')
	$('#mainTitleEdit').addClass('hide')
	$('#mTitleBtn2').addClass('hide')
	$('#mTitleBtn3').addClass('hide')
}

// 타이틀 수정 - db 업데이트 ajax 함수
function editTitleOk(){
	$.ajax({
		url : "main.updateTitle",
		type : "POST",
		data : {
			mIdx : '${main.mIdx}',
			mTitle : $('#mTitleInput').val()
		},
		error : function(){
			console.log('타이틀 수정 실패')
		},
		success : function(){
			console.log('타이틀 수정 성공')
			readTitle()
			editTitleBack()
		}
	})
}

// 메인 프로필 사진+문구 갖고오는 ajax 함수 (프로필 수정 후 저장하면 호출)
function readProfile(){
	$.ajax({
		url : "main.readProfile",
		type : "GET",
		data : {
			mIdx : '${main.mIdx}'
		},
		error : function(){
			console.log('프로필 불러오기 실패')
		}, 
		success : function(profile){
			console.log('프로필 불러오기 성공')
			showProfile(profile);
		}
	})
}

// 프로필 사진 + 문구 출력 함수
function showProfile(profile){
	var imgTag = "<img src='resources/img/mainImg/" + profile.mImg + "' id='mImg'>"
	var rePro = profile.mPro.replaceAll('\n', '<br>')
	$('#mImgDiv').html(imgTag)
	$('#mPro').html(rePro)
}

//프로필 수정 버튼 클릭시 css class(hide) 추가+제거하는 함수
function editProfile(){
	$('#mImgDiv').addClass('hide')
	$('#mPro').addClass('hide')
	$('#mEdit').addClass('hide')
	$('#mImgDivEdit').removeClass('hide')
	$('#mProEdit').removeClass('hide')
	$('#mEditConfirm').removeClass('hide')
}

//프로필 수정 - 취소 클릭시 css class(hide) 원래대로 돌리는 함수
function editProfileBack(){
	$('#mImgDiv').removeClass('hide')
	$('#mPro').removeClass('hide')
	$('#mEdit').removeClass('hide')
	$('#mImgDivEdit').addClass('hide')
	$('#mProEdit').addClass('hide')
	$('#mEditConfirm').addClass('hide')
}

//프로필 수정 - db 업데이트 ajax 함수
function editProfileOk(){
	$.ajax({
		url : "main.updateProfile",
		type : "POST",
		data : {
			mIdx : '${main.mIdx}',
			mImg : "pro01.jpg",
			mPro : $('#mProTextarea').val()
		},
		error : function(){
			console.log('프로필 수정 실패')
		},
		success : function(){
			console.log('프로필 수정 성공')
			readProfile()
			editProfileBack()
		}
	})
}

// 일촌평 리스트 갖고오는 ajax 함수
function readCmnt(){
	$.ajax({
		url : "cmnt.readAll",
		type : "GET",
		data : {
			mIdx : '${main.mIdx}'
		},
		error : function(){
			console.log('일촌평을 불러오지 못함')
		},
		success : function(list) {
			showCmnt(list)
		}
	})
}

// 일촌평 읽어와서(list) div에 출력하는 html 함수
function showCmnt(list){
	var result = ""
	if (list.length == 0) {
		result += "<div id='cmntEmpty'>아직 등록된 일촌평이 없습니다.</div>"
	} else {
		result += "<div id='cmntNotE'>"
		$.each(list, function(index, item){
			result += "&middot;&nbsp;"
			if (item.mName == '${main.mName}') {
				result += "<font style='color:#FF8B2D; font-weight:700;'>" + item.cCon + "</font>&nbsp;"
				result += "<font style='color:#1897B1; font-weight:700;'>" + item.mName + "</font>&nbsp;"
			} else {
				result += item.cCon + "&nbsp;"
				result += "<a href='main.others?memid=" + item.memid + "'>" + item.mName + "</a>&nbsp;"
			}
			result += "<font style='color:grey;font-size:10pt;'>" + item.cDate + "</font>"
			if ('${sessionId}' == '${main.memid}') {
				result += "<button class='cmntBtnDel' onclick='deleteCmnt(this)' value='" + item.cIdx + "'>"
				result += "<i class='fas fa-backspace'></i></button>"
			}
			result += "<br>"
		})
		result += "</div>"
	}
	$('#cmntList').html(result)
}

// 일촌평 추가 ajax 함수
function insertCmnt(){
	$.ajax({
		url : "cmnt.insert",
		type : "POST",
		data : {
			mIdx : '${main.mIdx}',
			memid : '${sessionId}',
			cCon : $('#cmntInput').val()
		},
		error : function() {
			console.log('일촌평 추가하지 못함')
		},
		success : function(){
			$('#cmntInput').val("");
			readCmnt();
		}
	})
}

// 일촌평 글자수 체크 css 함수
function checkCmnt(input){
	if (input.val() == ''){
		input.addClass('red')
		input.attr('placeholder', '일촌평은 한 글자 이상부터 등록 가능합니다.')
		input.focus();
	} else {
		input.removeClass('red')
		input.attr('placeholder', '일촌과 나누고 싶은 이야기를 남겨보세요~!')
	}
}

// 일촌평 삭제 ajax 함수
function deleteCmnt(btn){
	if (!confirm('일촌평을 삭제하시겠습니까?')){
		return
	} else {
		$.ajax({
			url : "cmnt.delete",
			type : "POST",
			data : {
				cIdx : btn.value
			},
			error : function(){
				console.log('일촌평 삭제 실패')
			},
			success : function(){
				console.log('일촌평 삭제 성공')
				readCmnt();
			}
		})
	}
}

// 화면 요소가 로딩된 후
$(function(){
	// 쿠키 확인 (방문자수)
	console.log(document.cookie);
	
	// 일촌평 불러오기 + 뿌리기
	readCmnt();
	
	// 일촌 파도타기 셀렉트 박스 클릭시 해당 유저의 미니홈피로 이동
	$('#m1chonSel').change(function(){
		location.href = $('#m1chonSel').val();
	});
	
	// 타이틀 수정 confirm 확인 후 타이틀 수정 + 출력 함수 호출
	$('#mTitleBtn3').click(function(e){
		if (!confirm('미니홈피 타이틀을 수정하시겠습니까?')) {
			e.preventDefault()
		} else {
			editTitleOk()
		}
	})
	
	// 프로필 수정 confirm 확인 후 프로필 수정 + 출력 함수 호출
	$('#mEditBtn2').click(function(e){
		if (!confirm('미니홈피 프로필을 수정하시겠습니까?')) {
			e.preventDefault()
		} else {
			editProfileOk()
		}
	})
	
	// 일촌평 글자수 체크 후 등록
	$('#cmntBtnOk').click(function(e){
		var input = $('#cmntInput')
		if (input.val() == '') {
			checkCmnt(input)
			e.preventDefault()
		} else {
			checkCmnt(input)
			insertCmnt()
		}
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
			<input id="mTitleInput" value="${main.mTitle }">
		</div>
		<!-- 타이틀 수정 관련 버튼 -->
		<div id="mainTitleBtnDiv">
			<c:if test="${sessionId eq memid }">
				<button id="mTitleBtn1" onclick="editTitle()"><i class="fas fa-cog"></i></button>
			</c:if>
			<button id="mTitleBtn2" class="hide" onclick="editTitleBack()"><i class="fas fa-undo-alt"></i></button>
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
						<button id="mEditBtn1" onclick="editProfile()"><i class="fas fa-cog"></i> 프로필 변경하기</button>
					</c:if>
			</div>
			
			<!-- 프로필 수정 버튼 확인 -->
			<div id="mEditConfirm" class="hide">
					<button id="mEditBtn3" onclick="editProfileBack()"><i class="fas fa-undo-alt"></i></button>
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
						<font color="#1897B1" style="font-weight: 700;">&nbsp;&nbsp;일촌평</font>&nbsp;
						<input id="cmntInput" placeholder="일촌과 나누고 싶은 이야기를 남겨보세요~!">
						<button id="cmntBtnOk">확인</button>
				</div>
				<!-- 일촌평 리스트 -->
				<div id="cmntList"></div>
			</div>
			
			
			
		</div>	
		<!-- 우측 미니홈피 프레임 끝 -->
	</div>
</body>
</html>