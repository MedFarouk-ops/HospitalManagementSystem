from ctypes import addressof
from djongo import models

# Create your models here.
from django.contrib.auth.models import (
    AbstractBaseUser, BaseUserManager, PermissionsMixin)

from rest_framework_simplejwt.tokens import RefreshToken


class UserManager(BaseUserManager):

    def create_user(self, username, email, password=None , **extra_fields):
        if username is None:
            raise TypeError('Users should have a username')
        if email is None:
            raise TypeError('Users should have a Email')

        user = self.model(username=username, email=self.normalize_email(email) , **extra_fields)

        user.set_password(password)
        user.save()
        return user

    def create_superuser(self, username, email, password=None):
        if password is None:
            raise TypeError('Password should not be none')

        user = self.create_user(username, email, password)
        user.is_superuser = True
        user.is_staff = True
        user.save()
        return user


AUTH_PROVIDERS = {'facebook': 'facebook', 'google': 'google',
                  'twitter': 'twitter', 'email': 'email'}


class User(AbstractBaseUser, PermissionsMixin):
    # variable de role / selection de role:  
    ADMIN = 1
    PATIENT = 2
    DOCTEUR = 3
    INFERMIER = 4
    ACCUEIL = 5
    RADIOLOGUE = 6
    ANALYSTE = 7
    PHARMACIEN = 8

    ROLE_CHOICES = (
        (ADMIN, 'Admin'),
        (PATIENT, 'Patient'),
        (DOCTEUR, 'Docteur'),
        (INFERMIER, 'Infermier'),
        (ACCUEIL, 'Accueil'),
        (RADIOLOGUE, 'RADIOLOGUE'),
        (ANALYSTE, 'ANALYSTE'),
        (PHARMACIEN, 'PHARMACIEN'),
    )
    # variables de specialitee pour le medecin : 
    cardiologue = 30
    dentiste  = 31
    generaliste = 32
    ophtalmologue = 33

    SPECIALITIES = (
        (cardiologue, 'cardiologue'),
        (dentiste, 'dentiste'),
        (generaliste, 'generaliste'),
        (ophtalmologue, 'ophtalmologue'),
    )

    # variables de selection de genre : 
    
    MALE = 11 
    FEMALE = 22

    GENDER_CHOICES = (
        (MALE, 'homme'),
        (FEMALE, 'femme'),
    )


    username = models.CharField(max_length=255, unique=True, db_index=True)
    email = models.EmailField(max_length=255, unique=True, db_index=True)
    first_name = models.CharField(max_length=50, blank=True)
    last_name = models.CharField(max_length=50, blank=True)
    mobilenumber = models.CharField(max_length=50, blank=True)
    address = models.CharField(max_length=50, blank=True)
    genre = models.PositiveSmallIntegerField(choices=GENDER_CHOICES, blank=True, null=True)
    age = models.CharField(max_length=50, blank=True)
    departement = models.CharField(max_length=50, blank=True)
    specialite = models.PositiveSmallIntegerField(choices=SPECIALITIES, blank=True, null=True) 
    role = models.PositiveSmallIntegerField(choices=ROLE_CHOICES, blank=True, null=True)
    is_verified = models.BooleanField(default=True)
    use_fingerprint = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    auth_provider = models.CharField(
        max_length=255, blank=False,
        null=False, default=AUTH_PROVIDERS.get('email'))

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    objects = UserManager()

    def __str__(self):
        return self.email

    def tokens(self):
        refresh = RefreshToken.for_user(self)
        return {
            'refresh': str(refresh),
            'access': str(refresh.access_token)
        }