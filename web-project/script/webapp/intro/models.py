from django.db import models

class Intro(models.Model):
    names = models.CharField(max_length=200)
    hobby = models.CharField(max_length=200)
    pic = models.CharField(max_length=100, null=True)

    def __str__(self):
        return self.names
