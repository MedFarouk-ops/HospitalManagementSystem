from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import UserSerializer
from .models import User
# Create your views here.

# Get user list by role : 

@api_view([('GET')])
def getPatients(request):
    users = User.objects.all().filter(role=2)
    serializer = UserSerializer(users , many = True)
    return Response(serializer.data)

@api_view([('GET')])
def getDoctors(request):
    users = User.objects.all().filter(role=3)
    serializer = UserSerializer(users , many = True)
    return Response(serializer.data)

@api_view([('GET')])
def getNurses(request):
    users = User.objects.all().filter(role=3)
    serializer = UserSerializer(users , many = True)
    return Response(serializer.data)



# get user by id :

@api_view([('GET')])
def getUser(request , pk):
    user = User.objects.get(id = pk)
    serializer1 = UserSerializer( user , many = False)
    return Response(serializer1.data)


# @api_view([('POST')])
# def createPatient(request) : 
#     data = request.data
#     patient = Patient.objects.create(
#         nom = data['nom'],
#         email = data['email'],
#         prenom = data['prenom'],
#         adresse = data['adresse'],
#         poids = data['poids'],
#     )
#     serializer = PatientSerializer(patient , many=False)
#     database.child('patients').push(serializer.data)
#     return Response(serializer.data)


@api_view([('PUT')])
def updateUser(request , pk) : 
    data = request.data
    user = User.objects.get(id = pk)
    serializer = UserSerializer(user , data=request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)

# delete user by id :

@api_view([('DELETE')])
def deleteUser(request , pk):
    user = User.objects.get(id = pk)
    user.delete()
    return Response("Patient was deleted")
