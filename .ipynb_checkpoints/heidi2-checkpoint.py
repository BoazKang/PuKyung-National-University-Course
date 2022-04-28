from dash import Dash, html, dcc, Input, Output, State
from dash.dash_table import DataTable
from sqlalchemy import create_engine, text
import pymysql
import pandas as pd

engine = create_engine("mysql+pymysql://bigdata:Bigdata123!!@192.168.56.101:3306/SampleDB")
conn = engine.connect()

## 데이터 베이스 목록
db_list = pd.read_sql("select distinct table_schema from information_schema.tables",conn).loc[:,"table_schema"]
db_list = db_list.values

app = Dash(__name__)
app.layout = html.Div(
    [
        dcc.Dropdown(id="db-list-dropdown",
                    options = [{"label":i,"value":i} for i in db_list]),
        html.Br(),
        html.Div(id="table-dropdown"),
        html.Div(id="column-checklist"),
        html.Div(id="condition-column"),
        html.Div(id="condition-select"),
        dcc.Input(id="input-value",type="text"),
        html.Button("조회",id="submit",n_clicks=0),
        html.Hr(),
        html.Div(id="table-contents"),
    ]
)

@app.callback(
    Output("table-dropdown","children"),
    Input("db-list-dropdown","value")
)
def update_table_dropdown_list(dbname):
    table_list = pd.read_sql(f"select table_name from information_schema.tables where table_schema = '{dbname}'",conn)
    table_list = table_list.loc[:,"table_name"].values
    table_list = [{"label":i,"value":i} for i in table_list]
    return html.Div(
        [
            dcc.Dropdown(id = "table-list-dropdown",
                         options = table_list)
        ]
    )

@app.callback(
    Output("column-checklist","children"),
    Input("db-list-dropdown","value"),
    Input("table-list-dropdown","value"),
)
def update_column_list(dbname,tablename):
    column_list = pd.read_sql(f"select column_name from information_schema.columns where table_schema = '{dbname}' and table_name = '{tablename}'",conn)
    column_list = column_list.loc[:,"column_name"]
    column_list = column_list.values
    return html.Div([
        dcc.Checklist(
            id = "column-list",
            options = column_list,
            value = column_list[[0]]
        )
    ])



@app.callback(
    Output("condition-column","children"),
    Input("db-list-dropdown","value"),
    Input("table-list-dropdown","value")
)
def update_conditon_column_list(dbname,tablename):
    condition_column_list = pd.read_sql(f"select column_name from information_schema.columns where table_schema = '{dbname}' and table_name = '{tablename}'  ",conn)
    condition_column_list = condition_column_list.loc[:,"column_name"].values
    return html.Div(
        [
            dcc.RadioItems(
                id = "condition-column-radio",
                options = condition_column_list
            )
        ]
    )

@app.callback(
    Output("condition-select","children"),
    Input("condition-column-radio","value"),
)
def update_select_condition(condition_column):
    condition_list = [
        {"label":"=","value":"="},
        {"label":"!=","value":"<>"},
        {"label":"선택안함","value":"no_selection"},
    ]
    return html.Div(
        [
            dcc.RadioItems(
                id = "condition-radio",
                options = condition_list
            )
        ]
    )




@app.callback(
    Output("table-contents","children"),
    Input("submit","n_clicks"),
    State("db-list-dropdown","value"),
    State("table-list-dropdown","value"),
    State("column-list","value"),
    State("condition-column-radio","value"),
    State("condition-radio","value"),
    State("input-value","value"),
)
def update_table_contents(n,dbname,tablename,columnname,conditon_col,condition_radio,input_val):
    columnname = ','.join(columnname)
    if len(columnname) == 0:
        columnname = "*"
    if input_val == "no_selection":
        stmt = f"select {columnname} from {dbname}.{tablename}"
    else:
        stmt = f"select {columnname} from {dbname}.{tablename} where {conditon_col} {condition_radio} '{input_val}'" 
    table_contents = pd.read_sql(stmt,conn)
    return html.Div(
        [
            DataTable(
                 table_contents.to_dict('records'), 
                 [{"name": i, "id": i} for i in table_contents.columns]
            )
        ]
    )



app.run_server(host="0.0.0.0",port=7777)
