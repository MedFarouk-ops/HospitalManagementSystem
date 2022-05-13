from rest_framework import serializers

from api.models import Reservation

class ReservationSerializer(serializers.ModelSerializer):

    class Meta:
        model = Reservation
        fields = ['date','startTime','endTime','patient','docteur','disponible',]