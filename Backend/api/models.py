from django.db import models

from authapp.models import User

# Create your models here.

class Reservation(models.Model):
    date = models.DateField()
    startTime =  models.TimeField()
    endTime =  models.TimeField()
    description = models.TextField()
    patient = models.ForeignKey(User, on_delete=models.CASCADE ,  related_name="patient")
    docteur = models.ForeignKey(User, on_delete=models.CASCADE , related_name="docteur")
    disponible =  models.BooleanField( default= True )
    
    def __str__(self):
        return self.date
    

