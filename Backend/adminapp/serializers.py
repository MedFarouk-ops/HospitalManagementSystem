from rest_framework.serializers import ModelSerializer
from authapp.models import User
from authapp.serializers import RegisterSerializer

class UserSerializer(ModelSerializer):
    class Meta : 
        model = User
        fields =  ['email', 'username','first_name' , 'last_name' , 'address','role', 'genre' ,'age','departement']