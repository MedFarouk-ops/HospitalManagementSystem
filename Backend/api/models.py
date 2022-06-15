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
    donnee = models.FileField( upload_to = "data/ordonnance-data/ordonnance-files/", null= True ,blank=True, default='')
    patient = models.ForeignKey(User, on_delete=models.CASCADE ,  related_name="patient_ord")
    docteur = models.ForeignKey(User, on_delete=models.CASCADE , related_name="docteur_ord")
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.description





class Radio(models.Model):
    description = models.TextField()
    nomLaboratoire = models.TextField( null=True)
    donnee = models.FileField(upload_to = "data/radio-data/radio-images/", null= True ,blank=True, default='')
    radiologue = models.ForeignKey(User, on_delete=models.CASCADE ,  related_name="radiologue_rad" , null=True)
    patient = models.ForeignKey(User, on_delete=models.CASCADE ,  related_name="patient_rad")
    docteur = models.ForeignKey(User, on_delete=models.CASCADE , related_name="docteur_rad")
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.description

# Hématologie
# Biochimie
# Microbiologie
# Anatomopathologie


class Analyse(models.Model):

    # variables de specialitee pour le medecin : 
    Hemato = 1
    Bioch  = 2
    Microb = 3
    Anatomo = 4
    AN_Types = (
        (Hemato, 'Hemato'),
        (Bioch, 'Bioch'),
        (Microb, 'Microb'),
        (Anatomo, 'Anatomo'),
    )
    description = models.TextField()
    nomLaboratoire = models.TextField( null=True)
    donnee = models.FileField( upload_to = "data/analyse-data/analyse-files/", null= True ,blank=True, default='')
    type = models.PositiveSmallIntegerField(choices=AN_Types, blank=True, null=True) 
    analyste = models.ForeignKey(User, on_delete=models.CASCADE ,  related_name="analyste_anl" , null=True)
    patient = models.ForeignKey(User, on_delete=models.CASCADE ,  related_name="patient_anl")
    docteur = models.ForeignKey(User, on_delete=models.CASCADE , related_name="docteur_anl")
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.description


class Consultation(models.Model):
    consDescription = models.TextField()
    ordonnance =  models.ForeignKey(Ordonnance, on_delete=models.CASCADE ,  related_name="ordonnance_cons")
    patient = models.ForeignKey(User, on_delete=models.CASCADE ,  related_name="patient_cons")
    docteur = models.ForeignKey(User, on_delete=models.CASCADE , related_name="docteur_cons")
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.consDescription


class RapportMedical(models.Model):
    descriptionRapport = models.TextField(default="pas de description")
    donnee = models.FileField( upload_to = "data/rapport-data/rapport-files/", null= True ,blank=True, default='')
    patient = models.ForeignKey(User, on_delete=models.CASCADE ,  related_name="patient_Med_rapport")
    docteur = models.ForeignKey(User, on_delete=models.CASCADE , related_name="docteur_Med_rapport")
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.descriptionRapport
    