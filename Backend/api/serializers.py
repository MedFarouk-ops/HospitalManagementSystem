from api.models import Reservation , Ordonnance ,Analyse ,Radio
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
      

