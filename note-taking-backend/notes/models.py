from django.db import models
from django.core.validators import MinLengthValidator

class User(models.Model):
    id = models.CharField(max_length=13, primary_key=True)
    password = models.CharField(max_length=30, validators=[MinLengthValidator(5)])

class Category(models.Model):
    category_name = models.CharField(max_length=255)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

class Note(models.Model):
    heading = models.CharField(max_length=100)
    text = models.TextField()
    tags = models.CharField(max_length=100)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)

class ToDo(models.Model):
    # id = models.CharField(max_length=13, primary_key=True)
    work = models.CharField(max_length=250)
    status = models.SmallIntegerField()
    user = models.ForeignKey(User, on_delete=models.CASCADE)
