from django.contrib import admin
from intro.models import Intro

class IntroAdmin(admin.ModelAdmin):
    list_display = ('names', 'hobby')

admin.site.register(Intro, IntroAdmin)