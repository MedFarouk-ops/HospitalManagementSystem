import json
from math import radians
from pydoc import doc
from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import generics, permissions

from api.models import Consultation, RapportMedical, Reservation,Analyse,Radio,Ordonnance
from api.serializers import AnalyseSerializer, ConsultationSerializer, OrdonnanceSerializer, RadioSerializer, RapportMedicalSerializer, ReservationSerializer
from authapp.models import User



# Create your views here.

# partie gestion de reservation : (accueil)  ******************************************************************************************** #

class getReservationsAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self,request):
        reservations = Reservation.objects.all()
        serializer = ReservationSerializer(reservations , many=True)
        return Response(serializer.data)

class createReservationAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def post(self , request) : 
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

class getReservationByIdAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self , request , pk):
        res = Reservation.objects.get(id = pk)
        serializer = ReservationSerializer( res , many = False)
        return Response(serializer.data)

# get doctor reservation by doctor id : 


class getReservationByDoctorIdAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self ,request , pk):
        reservations = Reservation.objects.all().filter(docteur_id = pk)
        serializer = ReservationSerializer(reservations , many = True)
        return Response(serializer.data)

class getReservationByPatientIdAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self ,request , pk):
        reservations = Reservation.objects.all().filter(patient_id = pk)
        serializer = ReservationSerializer(reservations , many = True)
        return Response(serializer.data)



class deleteReserevationAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def delete(self ,request , pk):
        res = Reservation.objects.get(id = pk)
        res.delete()
        return Response("la reservation  a été supprimée avec success")


class updateReservationAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def put(self ,request , pk) : 
        data = request.data
        res = Reservation.objects.get(id = pk)
        serializer = ReservationSerializer(res , data=request.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)


# partie gestion de ordonnance : (docteur)   ******************************************************************************************** #

# class getOrdonnancesAPIView(generics.GenericAPIView):
#     permission_classes = (permissions.IsAuthenticated,)
    # def get( self , request):
@api_view([('GET')])
def getOrdo(request):
    ordannaces = Ordonnance.objects.all()
    serializer = OrdonnanceSerializer(ordannaces , many=True)
    return Response(serializer.data)

class createOrdonnanceAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def post( self , request) :
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

class getOrdonnanceByIdAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get( selft , request , pk):
        ord = Ordonnance.objects.get(id = pk)
        serializer = OrdonnanceSerializer( ord , many = False)
        return Response(serializer.data)

class deleteOrdonnanceAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def delete( self , request , pk):
        ord = Ordonnance.objects.get(id = pk)
        ord.delete()
        return Response("l'ordonnace  a été supprimée avec success")


class updateOrdonnanceAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def put(self , request , pk) : 
        data = request.data
        ord = Ordonnance.objects.get(id = pk)
        serializer = OrdonnanceSerializer(ord , data=request.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)

# get doctor reservation by doctor id : 


class getOrdonnanceByDoctorIdAPIView(generics.GenericAPIView):
    
    permission_classes = (permissions.IsAuthenticated,)
    def get( selft , request , pk):
        ordonnances = Ordonnance.objects.all().filter(docteur_id = pk)
        serializer = OrdonnanceSerializer(ordonnances , many = True)
        return Response(serializer.data)




class getOrdonnanceByPatientIdAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)

    def get(self ,request , pk):
        ordonnances = Ordonnance.objects.all().filter(patient_id = pk)
        serializer = OrdonnanceSerializer(ordonnances , many = True)
        return Response(serializer.data)




# partie gestion de radios : (docteur (type = radiologist))   ******************************************************************************************** #


class getRadiosAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get( self , request):
        radios = Radio.objects.all()
        serializer = ReservationSerializer(radios , many=True)
        return Response(serializer.data)


class createRadioAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def post(self ,request) : 
        thumbnail = request.FILES.get("imageradio" ,False)
        info = json.loads(request.POST.get('data' , False)) 
        patient_id = info['patient']
        radiologue_id = info['radiologue']
        doctor_id = info['docteur']
        patient = User.objects.get(id = patient_id)
        doctor = User.objects.get(id = doctor_id)
        radiologue = User.objects.get(id = radiologue_id)
        radio = Radio.objects.create(
            description = info['description'],
            nomLaboratoire = info['nomLaboratoire'],
            donnee = thumbnail,
            radiologue = radiologue,
            patient = patient,
            docteur = doctor,
        )
        serializer = RadioSerializer(radio , many=False)
        return Response(serializer.data)


class getRadioByIdAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get( self ,request , pk):
        rd = Radio.objects.get(id = pk)
        serializer = RadioSerializer( rd , many = False)
        return Response(serializer.data)
        


# @api_view([('DELETE')])
# def deleteRadio(request , pk):
#     rad = Radio.objects.get(id = pk)
#     rad.delete()
#     return Response("le radio  a été supprimée avec success")


# @api_view([('PUT')])
# def updateRadio(request , pk) : 
#     data = request.data
#     rad = Radio.objects.get(id = pk)
#     serializer = RadioSerializer(rad , data=request.data)
#     if serializer.is_valid():
#         serializer.save()
#     return Response(serializer.data)


# get radios by doctor id : 

class getRadiosByDoctorIdAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self , request , pk):
        radios = Radio.objects.all().filter(docteur_id = pk)
        serializer = RadioSerializer(radios , many = True)
        return Response(serializer.data)

# get radios by patient id :
class getRadiosByPatientIdAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self ,request , pk):
        radios = Radio.objects.all().filter(patient_id = pk)
        serializer = RadioSerializer(radios , many = True)
        return Response(serializer.data)

# get radios by radiologue / laboratoire id : 
class getRadiosByRadiologueIdAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get( self , request , pk):
        radios = Radio.objects.all().filter(radiologue_id = pk)
        serializer = RadioSerializer(radios , many = True)
        return Response(serializer.data)



# partie gestion des analyses : (docteur ( type = analyste))  ******************************************************************************************** #

class getAnalysesAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self , request):
        analyses = Analyse.objects.all()
        serializer = AnalyseSerializer(analyses , many=True)
        return Response(serializer.data)


class createAnalysesAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def post( self , request) : 
        thumbnail = request.FILES.get("analysedata" ,False)
        info = json.loads(request.POST.get('data' , False))
        patient_id = info['patient']
        doctor_id = info['docteur']
        analyste_id = info['analyste']
        type = info['type']
        patient = User.objects.get(id = patient_id)
        doctor = User.objects.get(id = doctor_id)
        analyste = User.objects.get(id = analyste_id)
        analyse = Analyse.objects.create(
            description = info['description'],
            nomLaboratoire = info['nomLaboratoire'],
            donnee = thumbnail,
            type = type,
            analyste = analyste,
            patient = patient,
            docteur = doctor,
        )
        serializer = AnalyseSerializer(analyse , many=False)
        return Response(serializer.data)

class getAnalyseById(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get( self , request , pk):
        analyse = Analyse.objects.get(id = pk)
        serializer = AnalyseSerializer(analyse , many = False)
        return Response(serializer.data)

class deleteAnalyse(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def delete( self,request , pk):
        anls = Analyse.objects.get(id = pk)
        anls.delete()
        return Response("l'analyse a été supprimée avec success")


class updateAnalyse(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def put(self , request , pk) : 
        data = request.data
        als = Analyse.objects.get(id = pk)
        serializer = AnalyseSerializer(als , data=request.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)


# get analyses by type : 
class getAnalysesByType(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get( self , request , type):
        analyses = Analyse.objects.all().filter(type = type)
        serializer = AnalyseSerializer(analyses , many = True)
        return Response(serializer.data)

# get analyses by doctor id : 
class getAnalysesByDoctorId(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self ,request , pk):
        analyses = Analyse.objects.all().filter(docteur_id = pk)
        serializer = AnalyseSerializer(analyses , many = True)
        return Response(serializer.data)

# get analyses by patient id :
class getAnalysesByPatientId(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self ,request , pk):
        analyses = Analyse.objects.all().filter(patient_id = pk)
        serializer = AnalyseSerializer(analyses , many = True)
        return Response(serializer.data)

# get analyses by analyste / laboratoire id : 
class getAnalysesByAnalysteId(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self ,request , pk):
        analyses = Analyse.objects.all().filter(analyste_id = pk)
        serializer = AnalyseSerializer(analyses , many = True)
        return Response(serializer.data)

# partie gestion des consultations : (docteur ( type = tout))  ******************************************************************************************** #

# partie gestion de reservation : (accueil)  ******************************************************************************************** #

class getConsultations(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def getConsultations(self , request):
        consultations = Consultation.objects.all()
        serializer = ConsultationSerializer(consultations , many=True)
        return Response(serializer.data)

class createConsultation(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def post(self , request) : 
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

class getConsultaionById(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self , request , pk):
        res = Reservation.objects.get(id = pk)
        serializer = ReservationSerializer( res , many = False)
        return Response(serializer.data)



class getConsultationByDoctorId(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self , request , pk):
        consultations = Consultation.objects.all().filter(docteur_id = pk)
        serializer = ConsultationSerializer(consultations , many = True)
        return Response(serializer.data)

class getConsultationByPatientId(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self ,request , pk):
        consultations = Consultation.objects.all().filter(patient_id = pk)
        serializer = ConsultationSerializer(consultations , many = True)
        return Response(serializer.data)



class ReservationAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get( self , request):
        reservations = Reservation.objects.all()
        serializer = ReservationSerializer(reservations , many=True)
        return Response(serializer.data)


# partie gestion de rapport medicale
# 
class getRapportsAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self , request):
        rapports = RapportMedical.objects.all()
        serializer = RapportMedicalSerializer(rapports , many=True)
        return Response(serializer.data)


class createRapportAPIView(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def post( self , request) : 
        thumbnail = request.FILES.get("rapportdata" ,False)
        info = json.loads(request.POST.get('data' , False))
        patient_id = info['patient']
        doctor_id = info['docteur']
        patient = User.objects.get(id = patient_id)
        doctor = User.objects.get(id = doctor_id)
        rapport = RapportMedical.objects.create(
            descriptionRapport = info['description'],
            donnee = thumbnail,
            patient = patient,
            docteur = doctor,
        )
        serializer = RapportMedicalSerializer(rapport , many=False)
        return Response(serializer.data)

class getRapportById(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get( self , request , pk):
        rapport = RapportMedical.objects.get(id = pk)
        serializer = RapportMedicalSerializer(rapport , many = False)
        return Response(serializer.data)

class deleteRapport(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def delete( self,request , pk):
        rapport = RapportMedical.objects.get(id = pk)
        rapport.delete()
        return Response("supprimé avec success")


class updateRapport(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def put(self , request , pk) : 
        data = request.data
        rapport = RapportMedical.objects.get(id = pk)
        serializer = RapportMedicalSerializer(rapport , data=request.data ,partial=True)
        if serializer.is_valid():
            serializer.save()
            print(serializer.data)
        return Response(serializer.data) 


# get analyses by doctor id : 
class getRapportByDoctorId(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self ,request , pk):
        rapports = RapportMedical.objects.all().filter(docteur_id = pk)
        serializer = RapportMedicalSerializer(rapports , many = True)
        return Response(serializer.data)

# get analyses by patient id :
class getRapportByPatientId(generics.GenericAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self ,request , pk):
        rapports = RapportMedical.objects.all().filter(patient_id = pk)
        serializer = RapportMedicalSerializer(rapports , many = True)
        return Response(serializer.data)