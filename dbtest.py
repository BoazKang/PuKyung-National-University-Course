## 필요 모듈 임포트
import pandas as pd
from dash import Dash, dcc, html, Input, Output, State
import plotly.express as px
import pymysql
from sqlalchemy import create_engine, text

## 데이터베이스 연결
#접속정보
user = "bigdata"
password = "Bigdata123!!"
host = "192.168.56.101"
port = "3306"
db = "SampleDB"

#접속 스크립트
conn_script = f"mysql+pymysql://{user}:{password}@{host}:{port}/{db}"

#connection instance
engine = create_engine(conn_script)
conn = engine.connect()

qry = "select year, sum(pop) as pop from world group by year"
df = pd.read_sql(qry,conn)
fig = px.line(df, x = "year", y = "pop")

country = pd.read_sql("select distinct country from world", conn)
country = country.loc[:,"country"].tolist()
country = list(set(country))

## dash application 구성 (front end)
app = Dash(__name__)
app.layout = html.Div(
    [
        html.H4("연도별 인구수 변화"),
        dcc.RadioItems(id = "radio-items",
                       options = ['꺾은선그래프','막대그래프','파이그래프'],  # request 부분
                      value = '꺾은선그래프',
                      inline = True),
        dcc.Dropdown(id="dropdown-items",
                    options = [{"label":i, "value":i} for i in country]),
        html.Hr(),
        dcc.Graph(id="plt-graph")
    ]

)



## backend
@app.callback(
    Output("plt-graph","figure"),
    Input("radio-items","value"),
    Input("dropdown-items","value")
)

def update_graph(graph_type,country):
    if country == None:
        stmt = "select year, sum(pop) as pop from world group by year"
    else:
        stmt = f"select year, sum(pop) as pop from world where country = '{country}' group by year"
    df = pd.read_sql(stmt, conn)
    if graph_type == "꺾은선그래프":
        fig = px.line(df, x="year", y="pop")
    elif graph_type == "막대그래프":
        fig = px.bar(df, x="year", y="pop")
    else:
        fig = px.pie(df, values="pop", names="year")
    return fig


## 서버 구동
app.run_server(host=host,port=5555)