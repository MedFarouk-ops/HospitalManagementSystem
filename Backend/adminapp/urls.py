from django.urls import path

from . import views

urlpatterns = [
    path('doctors/',views.getDoctors),
    path('patients/',views.getPatients),
    path('nurses/',views.getNurses),
    path('users/delete/<str:pk>/',views.deleteUser),
    path('users/update/<str:pk>/',views.updateUser),

]