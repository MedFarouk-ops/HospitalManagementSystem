from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import generics, permissions

from .serializers import UserSerializer
from .models import User
# Create your views here.

# Get user list by role : 

class getPatientsAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self,request):
        users = User.objects.all().filter(role=2)
        serializer = UserSerializer(users , many = True)
        return Response(serializer.data)


class getDoctorsAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get( self,request):
        users = User.objects.all().filter(role=3)
        serializer = UserSerializer(users , many = True)
        return Response(serializer.data)

class getNursesAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self,request):
        users = User.objects.all().filter(role=3)
        serializer = UserSerializer(users , many = True)
        return Response(serializer.data)

# get user by id :
class getUserAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self , request , pk):
        user = User.objects.get(id = pk)
        serializer1 = UserSerializer( user , many = False)
        return Response(serializer1.data)


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
