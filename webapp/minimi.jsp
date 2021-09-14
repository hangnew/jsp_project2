<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=900622db6a1b86328452062916477a82"></script>
</head>
<body>
	<!-- 지도를 표시할 div 입니다 -->
	<div id="map" style="width: 750px; height: 300px;"></div>
	<script>
		var node = document.getElementById('map');

		//지도 이미지 소스
		var plan = function(x, y, z) {
			return 'resources/img/miniroom/room1.png';
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

		var imageSrc = 'resources/img/miniroom/minimi1.png', // 마커이미지의 주소입니다    
		imageSize = new kakao.maps.Size(40, 90), // 마커이미지의 크기입니다
		imageOption = {
			offset : new kakao.maps.Point(27, 69)
		}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
				imageOption)

		// 미니미 좌표
		var minimiX = 1500;
		var minimiY = 400;
		
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			// 마커 좌표
			position : new kakao.maps.Coords(minimiX, minimiY),
			// 마커 이미지 설정
			image : markerImage
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);

		// 마커가 드래그 가능하도록 설정합니다 
		marker.setDraggable(true);
		
		// 마커에 dragend 이벤트를 등록합니다
		kakao.maps.event.addListener(marker, 'dragend', function() {
			// x좌표 : 마커.위치.좌표로 반환.x좌표만.스트링형변환.'.'으로 split[0번째 요소]
			var axisX = marker.getPosition().toCoords().getX().toString().split('.')[0];
			var axisY = marker.getPosition().toCoords().getY().toString().split('.')[0];
			$('#x').val(axisX);
			$('#y').val(axisY);
		});
	</script>
	<input id="x"><input id="y">
	<a href="main.home?memid=${sessionId}"><button>돌아가기</button></a>
</body>
</html>