
lat = xmlDoc.getElementsByTagName("lat")
lng = xmlDoc.getElementsByTagName("lng")

console.log(lat)
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
  mapOption = {
        center: new kakao.maps.LatLng(lat[0], lng[0]), // 지도의 중심좌표
      //center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
      level: 3 // 지도의 확대 레벨
  };


var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

