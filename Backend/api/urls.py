from django.urls import path

from . import views

urlpatterns = [
  
    # route api de la reservations : 
    path('reservations/',views.getReservations),
    path('reservations/create/',views.createReservation),
    path('reservations/delete/<str:pk>/',views.deleteReserevation),
    path('reservations/update/<str:pk>/',views.updateReservation),
    path('reservations/<int:pk>/',views.getUser),


    # route api de la ordonnance : 
    path('ordonnances/',views.getOrdonnances),
    path('ordonnances/create/',views.createOrdonnance),
    path('ordonnances/delete/<str:pk>/',views.deleteOrdonnance),
    path('ordonnances/update/<str:pk>/',views.updateOrdonnace),
    path('ordonnances/<int:pk>/',views.getUser),




    # route api de la radios : 
    path('radios/',views.getRadios),
    path('radios/create/',views.createRadio),
    path('radios/delete/<str:pk>/',views.deleteRadio),
    path('radios/update/<str:pk>/',views.updateRadio),
    path('radios/<int:pk>/',views.getUser),



    # route api de la analyses : 
    path('analyses/',views.getAnalyses),
    path('analyses/create/',views.createAnalyses),
    path('analyses/delete/<str:pk>/',views.deleteAnalyse),
    path('analyses/update/<str:pk>/',views.updateAnalyse),
    path('analyses/<int:pk>/',views.getUser),


]