from django.shortcuts import render
from intro.models import *

import pandas as pd
from sqlalchemy import create_engine
engine = create_engine("mysql+pymysql://bigdata:Bigdata123!!@192.168.56.101:3306/blog")
conn = engine.connect()


def intro(request):
    name = request.GET.get('q')
    if name is None:
        name = '홍길동'
    data = pd.read_sql(f"select names, hobby, concat('static/img/',pic) as pic from intro_intro",conn)
    dt = [{'names':data.names.values[0]}, {'hobby':data.hobby.values[0]}, {'pic':data.pic.values[0]}]
    msg = {'content':dt}
    return render(request, 'intro/intro.html',msg)


def regist(request):
    return render(request, "intro/regist.html")

def index(request):
    return render(request, "intro/index.html")

def map(request):
    return render(request, "intro/map.html")