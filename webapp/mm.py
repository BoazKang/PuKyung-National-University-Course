dimport requests
from bs4 import BeautifulSoup

url = 'http://apis.data.go.kr/B552584/EvCharger/getChargerInfo'
params ={'serviceKey' : '64gKOJqVRDnGcTGnxudjY1CQQeu0IKAcjtYZb83FEOMueJmGVcthWM1KlsxDUGUyG9pFDTeU/clsiRUm7xWPbw==', 'type':'json', 'numOfRows' : '10', 'pageNo' : '1' }

response = requests.get(url, params=params)
print(response.text)
data = response.Bea