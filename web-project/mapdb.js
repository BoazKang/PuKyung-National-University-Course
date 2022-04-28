$(document).ready(function () {
	$.ajax({
		url: 'C:\web-project\charge.xml', //통신을 원하는 URL주소를 입력합니다
		type: 'GET', //통신 방식을 지정합니다
		dataType: 'xml',//서버로부터 받을 데이터 타입을 입력합니다.
		success: function (response) { // 통신 성공시 호출해야할 함수
		  xmlParsing(response);
		},
		error: function (xhr, status, msg) { // 통신 실패시 호출해야하는 함수
		  console.log('상태값 : ' + status + ' Http에러메시지 : ' + msg);
		},
	});

	function xmlParsing(data) {
		var infoList = ``;
		$(data).find('row').each(function(index, item){
			//console.log(item)
			infoList += `
				<tr>
					<td>${$(this).find('ADDR').text()}</td>
					<td>${$(this).find('CHARGETP').text()}</td>
					<td>${$(this).find('CPID').text()}</td>
					<td>${$(this).find('CPNM').text()}</td>
					<td>${$(this).find('CPSTAT').text()}</td>
                    <td>${$(this).find('CPTP').text()}</td>
                    <td>${$(this).find('CSID').text()}</td>
                    <td>${$(this).find('CSNM').text()}</td>
                    <td>${$(this).find('LAT').text()}</td>
                    <td>${$(this).find('LONGI').text()}</td>
                    <td>${$(this).find('STATUPDATETIME').text()}</td>
				</tr>
			`;
			$('#info').empty().append(infoList);
			$('tr:first').css('background', 'darkgray').css('color', 'white')
		});
	}
});