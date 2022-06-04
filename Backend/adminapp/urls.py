from django.urls import path

from . import views

urlpatterns = [
    path('doctors/',views.getDoctorsAPIView.as_view()),
    path('patients/',views.getPatientsAPIView.as_view()),
    path('nurses/',views.getNursesAPIView.as_view()),
    path('users/delete/<str:pk>/',views.deleteUser),
    path('users/update/<str:pk>/',views.updateUser),
    path('users/<int:pk>/',views.getUserAPIView.as_view()),
]