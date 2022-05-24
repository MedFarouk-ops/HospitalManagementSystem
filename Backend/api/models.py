from distutils.command.upload import upload
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
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)
    
    
    def __str__(self):
        return self.date


class Ordonnance(models.Model):
    description = models.TextField()
    donnee = models.ImageField(upload_to = "images/ordonnance/" , max_length = 255 , null = True , blank =True)
    patient = models.ForeignKey(User, on_delete=models.CASCADE ,  related_name="patient_ord")
    docteur = models.ForeignKey(User, on_delete=models.CASCADE , related_name="docteur_ord")
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.description





class Radio(models.Model):
    description = models.TextField()
    donnee = models.ImageField(upload_to = "images/radios/" , max_length = 255 , null = True , blank =True)
    patient = models.ForeignKey(User, on_delete=models.CASCADE ,  related_name="patient_rad")
    docteur = models.ForeignKey(User, on_delete=models.CASCADE , related_name="docteur_rad")
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.description




class Analyse(models.Model):
    description = models.TextField()
    donnee = models.ImageField(upload_to = "images/analyses/" , max_length = 255 , null = True , blank =True)
    patient = models.ForeignKey(User, on_delete=models.CASCADE ,  related_name="patient_anl")
    docteur = models.ForeignKey(User, on_delete=models.CASCADE , related_name="docteur_anl")
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.description




class Consultation(models.Model):
    description = models.TextField()
    ordonnance =  models.ForeignKey(Ordonnance, on_delete=models.CASCADE ,  related_name="ordonnance_cons")
    radiodata =  models.ForeignKey(Ordonnance, on_delete=models.CASCADE ,  related_name="radio_cons")
    analysedata =  models.ForeignKey(Ordonnance, on_delete=models.CASCADE ,  related_name="analyse_cons")
    patient = models.ForeignKey(User, on_delete=models.CASCADE ,  related_name="patient_cons")
    docteur = models.ForeignKey(User, on_delete=models.CASCADE , related_name="docteur_cons")
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.description


