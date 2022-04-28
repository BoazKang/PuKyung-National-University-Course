function calc(){
    var a = document.getElementsByTagName('input')[0].value;
    var b = document.getElementsByTagName('input')[1].value;
    var result = parseInt(a) + parseInt(b);
    document.getElementsByTagName('input')[2].value = result;
}