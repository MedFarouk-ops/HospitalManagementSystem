import re
from django.shortcuts import render
from requests import Response
from rest_framework.decorators import api_view

from api.models import Reservation
from api.serializers import ReservationSerializer


# Create your views here.

@api_view([('POST')])
def createReservation(request) : 
    data = request.data
    reservation = Reservation.objects.create(
        date = data['date'],
        time = data['time'],
        patient = data['patient'],
        docteur = data['docteur'],
        disponible = data['disponible'],
    )
    serializer = ReservationSerializer(reservation , many=False)
    return Response(serializer.data)

@api_view([('GET')])
def getReservations(request):
    reservations = Reservation.objects.all()
    serializer = ReservationSerializer(reservations , many = True)
    return Response(serializer.data)
