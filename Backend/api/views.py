import json
from math import radians
from pydoc import doc
from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view

from api.models import Consultation, Reservation,Analyse,Radio,Ordonnance
from api.serializers import AnalyseSerializer, ConsultationSerializer, NewConsultationSerializer, OrdonnanceSerializer, RadioSerializer, ReservationSerializer
from authapp.models import User
from adminapp.views import getUser


# Create your views here.

# partie gestion de reservation : (accueil)  ******************************************************************************************** #

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

# get doctor reservation by doctor id : 

@api_view([('GET')])
def getReservationByDoctorId(request , pk):
    reservations = Reservation.objects.all().filter(docteur_id = pk)
    serializer = ReservationSerializer(reservations , many = True)
    return Response(serializer.data)



@api_view([('DELETE')])
def deleteReserevation(request , pk):
    res = Reservation.objects.get(id = pk)
    res.delete()
    return Response("la reservation  a été supprimée avec success")


@api_view([('PUT')])
def updateReservation(request , pk) : 
    data = request.data
    res = Reservation.objects.get(id = pk)
    serializer = ReservationSerializer(res , data=request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)


# partie gestion de ordonnance : (docteur)   ******************************************************************************************** #

@api_view([('GET')])
def getOrdonnances(request):
    ordannaces = Ordonnance.objects.all()
    serializer = OrdonnanceSerializer(ordannaces , many=True)
    return Response(serializer.data)

@api_view([('POST')])
def createOrdonnance(request) :
    thumbnail = request.FILES.get("ordonnanceData" ,False)
    info = json.loads(request.POST.get('data' , False)) 
    patient_id = info['patient']
    doctor_id = info['docteur']
    patient = User.objects.get(id = patient_id)
    doctor = User.objects.get(id = doctor_id)
    ordonnance = Ordonnance.objects.create(
        description = info['description'],
        donnee = thumbnail,
        patient = patient,
        docteur = doctor,
    )
    serializer = OrdonnanceSerializer(ordonnance , many=False)
    return Response(serializer.data)

@api_view([('GET')])
def getOrdonnanceById(request , pk):
    ord = Ordonnance.objects.get(id = pk)
    serializer = OrdonnanceSerializer( ord , many = False)
    return Response(serializer.data)

@api_view([('DELETE')])
def deleteOrdonnance(request , pk):
    ord = Ordonnance.objects.get(id = pk)
    ord.delete()
    return Response("l'ordonnace  a été supprimée avec success")


@api_view([('PUT')])
def updateOrdonnace(request , pk) : 
    data = request.data
    ord = Ordonnance.objects.get(id = pk)
    serializer = OrdonnanceSerializer(ord , data=request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)


# partie gestion de radios : (docteur (type = radiologist))   ******************************************************************************************** #

@api_view([('GET')])
def getRadios(request):
    radios = Radio.objects.all()
    serializer = ReservationSerializer(radios , many=True)
    return Response(serializer.data)

@api_view([('POST')])
def createRadio(request) : 
    thumbnail = request.FILES.get("image" ,False)
    info = json.loads(request.POST.get('data' , False)) 
    patient_id = info['patient']
    doctor_id = info['docteur']
    patient = User.objects.get(id = patient_id)
    doctor = User.objects.get(id = doctor_id)
    radio = Radio.objects.create(
        description = info['description'],
        donnee = thumbnail,
        patient = patient,
        docteur = doctor,
    )
    serializer = RadioSerializer(radio , many=False)
    return Response(serializer.data)

@api_view([('GET')])
def getRadioById(request , pk):
    rd = Radio.objects.get(id = pk)
    serializer = RadioSerializer( rd , many = False)
    return Response(serializer.data)


@api_view([('DELETE')])
def deleteRadio(request , pk):
    rad = Radio.objects.get(id = pk)
    rad.delete()
    return Response("le radio  a été supprimée avec success")


@api_view([('PUT')])
def updateRadio(request , pk) : 
    data = request.data
    rad = Radio.objects.get(id = pk)
    serializer = RadioSerializer(rad , data=request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)



# partie gestion des analyses : (docteur ( type = analyste))  ******************************************************************************************** #

@api_view([('GET')])
def getAnalyses(request):
    analyses = Analyse.objects.all()
    serializer = AnalyseSerializer(analyses , many=True)
    return Response(serializer.data)

@api_view([('POST')])
def createAnalyses(request) : 
    thumbnail = request.FILES.get("analysedata" ,False)
    info = json.loads(request.POST.get('data' , False))
    patient_id = info['patient']
    doctor_id = info['docteur']
    patient = User.objects.get(id = patient_id)
    doctor = User.objects.get(id = doctor_id)
    analyse = Analyse.objects.create(
        description = info['description'],
        donnee = thumbnail,
        patient = patient,
        docteur = doctor,
    )
    serializer = AnalyseSerializer(analyse , many=False)
    return Response(serializer.data)

@api_view([('GET')])
def getAnalyseById(request , pk):
    analyse = Analyse.objects.get(id = pk)
    serializer = AnalyseSerializer(analyse , many = False)
    return Response(serializer.data)


@api_view([('DELETE')])
def deleteAnalyse(request , pk):
    anls = Analyse.objects.get(id = pk)
    anls.delete()
    return Response("l'analyse a été supprimée avec success")


@api_view([('PUT')])
def updateAnalyse(request , pk) : 
    data = request.data
    als = Analyse.objects.get(id = pk)
    serializer = AnalyseSerializer(als , data=request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)




# partie gestion des consultations : (docteur ( type = tout))  ******************************************************************************************** #

# partie gestion de reservation : (accueil)  ******************************************************************************************** #

@api_view([('GET')])
def getConsultations(request):
    consultations = Consultation.objects.all()
    serializer = ConsultationSerializer(consultations , many=True)
    return Response(serializer.data)

@api_view([('POST')])
def createConsultation(request) : 
    data = request.data 
    
    # getting the id onf the objects:
    description = data['description'] 
    patient_id = data['patient']
    doctor_id = data['docteur']
    ordonnance_id_list = data['ordonnanceData'],
    print(ordonnance_id_list[0])
    print(description)
    ordonnance_id = ordonnance_id_list[0]

    # getting object by the id : 

    patient = User.objects.get(id = patient_id)
    doctor = User.objects.get(id = doctor_id)
    ordonnance_data = Ordonnance.objects.get(id = ordonnance_id)
    consultation = Consultation.objects.create(
        ordonnance = ordonnance_data ,
        patient = patient,
        docteur = doctor,
        consDescription = description 
    )
    serializer = ConsultationSerializer(consultation , many=False)
    print(serializer.data)
    return Response(serializer.data)

@api_view([('GET')])
def getConsultaionById(request , pk):
    res = Reservation.objects.get(id = pk)
    serializer = ReservationSerializer( res , many = False)
    return Response(serializer.data)