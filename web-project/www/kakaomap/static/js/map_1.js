let xhttp = new XMLHttpRequest();

xhttp.onreadystatechange = function () {
   
   if(this.readyState == 11 && this.status == 200){
    nodeValfunc( this ); // this == xhttp 
   }
}
xml = xhttp.open("GET", "http://apis.data.go.kr/B552584/EvCharger/getChargerInfo?serviceKey=64gKOJqVRDnGcTGnxudjY1CQQeu0IKAcjtYZb83FEOMueJmGVcthWM1KlsxDUGUyG9pFDTeU%2FclsiRUm7xWPbw%3D%3D", true);
xhttp.send();

function nodeValfunc( xml ) { // ( xml ) 객체 넘겨받기
   let statNm, addr, chgerType, statId, method, lat, lng
   let text,num, numtxt, xmlDoc;
   
   txt = numtxt = ''; // 빈 문자열로 초기화
   
   xmlDoc = xml.responseXML; 
   

   statNm = xmlDoc.getElementsByTagName("statNm");
   addr = xmlDoc.getElementsByTagName("addr");
   chgerType= xmlDoc.getElementsByTagName("chgerType");
   statId = xmlDoc.getElementsByTagName("statId");
   method = xmlDoc.getElementsByTagName("method");
   lat = xmlDoc.getElementsByTagName("lat");
   lng = xmlDoc.getElementsByTagName("lng");

   console.log(num.length);
   
   for(i=0; i < num.length; i++){
      txt += statNm[i].childNodes[0].nodeValue + "<br>";
        numtxt += addr[i].childNodes[0].nodeValue + "<br>";
        num += chgerType[i].childNodes[0].nodeValue + "<br>";
        num += statId[i].childNodes[0].nodeValue + "<br>";
        text += method[i].childNodes[0].nodeValue + "<br>";
        num += lat[i].childNodes[0].nodeValue + "<br>";
        num += lng[i].childNodes[0].nodeValue + "<br>";
        

   }
   
   document.getElementById("demo").innerHTML = txt + numtxt;
   // 실행하면 번호와 이름이 p태그에 출력된다.