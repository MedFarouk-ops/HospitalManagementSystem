from django.urls import path

from . import views

urlpatterns = [
    # route api de la reservations : 
    
    path('reservations/',views.getReservations),
    path('reservations/create/',views.createReservation),
]