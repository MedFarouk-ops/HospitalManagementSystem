from api.models import  Consultation, Reservation , Ordonnance ,Analyse ,Radio , RapportMedical
from rest_framework.serializers import ModelSerializer


class ReservationSerializer(ModelSerializer):
    class Meta : 
        model = Reservation
        fields = '__all__'


class OrdonnanceSerializer(ModelSerializer):
    class Meta : 
        model = Ordonnance
        fields = '__all__'


class RadioSerializer(ModelSerializer):
    class Meta : 
        model = Radio
        fields = '__all__'



class AnalyseSerializer(ModelSerializer):
    class Meta : 
        model = Analyse
        fields = '__all__'
      

class ConsultationSerializer(ModelSerializer):
    class Meta : 
        model = Consultation
        fields = '__all__'
        
      

class RapportMedicalSerializer(ModelSerializer):
    class Meta : 
        model = RapportMedical
        fields = '__all__'
        