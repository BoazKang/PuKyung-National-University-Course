
// lat = xmlDoc.getElementsByTagName("lat")
// lng = xmlDoc.getElementsByTagName("lng")

let xhttp = new XMLHttpRequest();

xhttp.onreadystatechange = function () {
   
   if(this.readyState == 4 && this.status == 200){
    nodeValfunc( this ); // this == xhttp 
   }
}

// xhttp.headers["Access-Control-Allow-Origin"] = '*';

xhttp.headers["Access-Control-Allow-Origin"] = '*';

xhttp.open("GET", "http://apis.data.go.kr/B552584/EvCharger/getChargerInfo?serviceKey=64gKOJqVRDnGcTGnxudjY1CQQeu0IKAcjtYZb83FEOMueJmGVcthWM1KlsxDUGUyG9pFDTeU%2FclsiRUm7xWPbw%3D%3D", true);


xhttp.setRequestHeader("Access-Control-Allow-Origin", '*')
xhttp.send();
xml = xhttp.responseText;
console.log(location.origin);
console.log(xml);
let statNm, addr, chgerType, statId, method, lat, lng;
let text,num, numtxt, xmlDoc;

txt = numtxt = ''; // 빈 문자열로 초기화

xmlDoc = xml.responseXML; 
console.log(xmlDoc);

statNm = xmlDoc.getElementsByTagName("statNm");
// addr = xmlDoc.getElementsByTagName("addr");
// chgerType= xmlDoc.getElementsByTagName("chgerType");
// statId = xmlDoc.getElementsByTagName("statId");
// method = xmlDoc.getElementsByTagName("method");
// lat = xmlDoc.getElementsByTagName("lat");
// lng = xmlDoc.getElementsByTagName("lng");

console.log(statNm);
lat = [33.450701, 33.450711];
lng = [126.570667,126.570670];
console.log(lat);

// for(i=0; i < num.length; i++){
//    txt += statNm[i].childNodes[0].nodeValue + "<br>";
//       numtxt += addr[i].childNodes[0].nodeValue + "<br>";
//       num += chgerType[i].childNodes[0].nodeValue + "<br>";
//       num += statId[i].childNodes[0].nodeValue + "<br>";
//       text += method[i].childNodes[0].nodeValue + "<br>";
//       num += lat[i].childNodes[0].nodeValue + "<br>";
//       num += lng[i].childNodes[0].nodeValue + "<br>";
// }      



var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
var imageSize = new kakao.maps.Size(24, 35); 
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 




var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
  mapOption = {
        // center: new kakao.maps.LatLng(lat[0], lng[0]), // 지도의 중심좌표
      center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
      level: 3 // 지도의 확대 레벨;
  };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var marker = new kakao.maps.Marker({
  position: markerPositions
});
marker.setMap(map);


