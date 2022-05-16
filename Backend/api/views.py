from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view

from api.models import Reservation
from api.serializers import ReservationSerializer
from authapp.models import User
from adminapp.views import getUser


# Create your views here.

# partie gestion de reservation : (accueil) 

@api_view([('GET')])
def getReservations(request):
    reservations = Reservation.objects.all()
    serializer = ReservationSerializer(reservations , many=True)
    return Response(serializer.data)

@api_view([('POST')])
def createReservation(request) : 
    data = request.data 
    patient_id = data['patient']
    doctor_id = data['docteur']
    patient = User.objects.get(id = patient_id)
    doctor = User.objects.get(id = doctor_id)
    reservation = Reservation.objects.create(
        date = data['date'],
        startTime =  data['startTime'],
        endTime =  data['endTime'],
        description = data['description'],
        patient = patient,
        docteur = doctor,
        disponible = data['disponible'],
    )
    serializer = ReservationSerializer(reservation , many=False)
    return Response(serializer.data)

@api_view([('GET')])
def getReservationById(request , pk):
    res = Reservation.objects.get(id = pk)
    serializer = ReservationSerializer( res , many = False)
    return Response(serializer.data)

