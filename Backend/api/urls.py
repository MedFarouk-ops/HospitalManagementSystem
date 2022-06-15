from django.urls import path

from . import views


urlpatterns = [
    
    # route api de la reservations : 
    # ******************************************************************************************************************** #
    path('reservations/',views.getReservationsAPIView.as_view()),
    # path('reservations/a/',views.ReservationAPIView.as_view()),
    path('reservations/create/',views.createReservationAPIView.as_view()),
    path('reservations/delete/<str:pk>/',views.deleteReserevationAPIView.as_view()),
    path('reservations/update/<str:pk>/',views.updateReservationAPIView.as_view()),
    path('reservations/<int:pk>/',views.getReservationByIdAPIView.as_view()),
    path('reservations/doctor/<int:pk>/',views.getReservationByDoctorIdAPIView.as_view()),
    path('reservations/patient/<int:pk>/',views.getReservationByPatientIdAPIView.as_view()),

    # route api de la ordonnance : 
    # ******************************************************************************************************************** #
    # path('ordonnances/',views.getOrdonnancesAPIView.as_view()),
    path('ordonnances/',views.getOrdo),
    path('ordonnances/create/',views.createOrdonnanceAPIView.as_view()),
    path('ordonnances/delete/<str:pk>/',views.deleteOrdonnanceAPIView.as_view()),
    # path('ordonnances/update/<str:pk>/',views.updateOrdonnace),
    path('ordonnances/<int:pk>/',views.getOrdonnanceByIdAPIView.as_view()),
    path('ordonnances/doctor/<int:pk>/',views.getOrdonnanceByDoctorIdAPIView.as_view()),
    path('ordonnances/patient/<int:pk>/',views.getOrdonnanceByPatientIdAPIView.as_view()),

    # route api de la radios : 
    # ******************************************************************************************************************** #

    path('radios/',views.getRadiosAPIView.as_view()),
    path('radios/create/',views.createRadioAPIView.as_view()),
    # path('radios/delete/<str:pk>/',views.deleteRadio),    
    # path('radios/update/<str:pk>/',views.updateRadio),
    path('radios/<int:pk>/',views.getRadioByIdAPIView.as_view()),
    path('radios/doctor/<int:pk>/',views.getRadiosByDoctorIdAPIView.as_view()),
    path('radios/patient/<int:pk>/',views.getRadiosByPatientIdAPIView.as_view()),
    path('radios/radiologue/<int:pk>/',views.getRadiosByRadiologueIdAPIView.as_view()),


    # route api de la analyses : 
    # ******************************************************************************************************************** #
    path('analyses/',views.getAnalysesAPIView.as_view()),
    path('analyses/create/',views.createAnalysesAPIView.as_view()),
    path('analyses/delete/<str:pk>/',views.deleteAnalyse.as_view()),
    # path('analyses/update/<str:pk>/',views.updateAnalyse),
    path('analyses/<int:pk>/',views.getAnalyseById.as_view()),
    path('analyses/type/<int:type>/',views.getAnalysesByType.as_view()),
    path('analyses/doctor/<int:pk>/',views.getAnalysesByDoctorId.as_view()),
    path('analyses/patient/<int:pk>/',views.getAnalysesByPatientId.as_view()),
    path('analyses/analyste/<int:pk>/',views.getAnalysesByAnalysteId.as_view()),


    # route api de consultaions : 
    # ******************************************************************************************************************** #
    path('consultations/',views.getConsultations.as_view()),
    path('consultations/create/',views.createConsultation.as_view()),
    # path('consultations/delete/<str:pk>/',views.deleteAnalyse),
    # path('consultations/update/<str:pk>/',views.updateAnalyse),
    path('consultations/<int:pk>/',views.getConsultaionById.as_view()),
    path('consultations/doctor/<int:pk>/',views.getConsultationByDoctorId.as_view()),
    path('consultations/patient/<int:pk>/',views.getConsultationByPatientId.as_view()),

    # route api de gestion de rapport medicale : 
    # ******************************************************************************************************************** #
    path('rapport-medicale/',views.getRapportsAPIView.as_view()),
    path('rapport-medicale/create/',views.createRapportAPIView.as_view()),
    path('rapport-medicale/delete/<str:pk>/',views.deleteRapport.as_view()),
    path('rapport-medicale/update/<str:pk>/',views.updateRapport.as_view()),
    path('rapport-medicale/<int:pk>/',views.getRapportById.as_view()),
    path('rapport-medicale/doctor/<int:pk>/',views.getRapportByDoctorId.as_view()),
    path('rapport-medicale/patient/<int:pk>/',views.getRapportByPatientId.as_view()),


]