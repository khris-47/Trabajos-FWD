from rest_framework import serializers
from .models import *


# -- Serializer del Modelo de Paciente --------------------------------------------------------------------------------
class PacienteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pacientes
        fields = '__all__'
    
    # se valida que el nombre tenga mas de tres digitos
    def validate_nombre(self,value):
        if len(value) <= 3:
            raise serializers.ValidationError("El nombre del paciente tiene que tener mas de 3 caracteres.")
        return value
    
    # se valida que el primer Apellido tenga mas de tres digitos
    def validate_primerApellido(self,value):
        if len(value) <= 5:
            raise serializers.ValidationError("El primer apellido del paciente tiene que tener mas de 5 caracteres.")
        return value
    
    # se valida que el segundoApellido tenga mas de tres digitos
    def validate_segundoApellido(self,value):
        if len(value) <= 5:
            raise serializers.ValidationError("El segundo apellido del paciente tiene que tener mas de 5 caracteres.")
        return value

    # la edad no puede ser 0 o menor
    def validate_edad(self,value):
        if value <= 0:
            raise serializers.ValidationError("La edad no puede ser menor o igual a 0.")
        return value
    
# -- Serializer del Modelo de Especialidades --------------------------------------------------------------------------
class EspecialidadesSerializer(serializers.ModelSerializer):
    class Meta:
        model =  Especialidades
        fields = '__all__'

    # la especialidad debe de tener minimo 4 caracteres
    def validate_nombre(self,value):
        if len(value) <= 3:
            raise serializers.ValidationError("El nombre de la especialidad tiene que tener mas de 3 caracteres.")
        return value



# -- Serializer del Modelo de Doctores ----------------------------------------------------------------------------------
class DoctoresSerializer(serializers.ModelSerializer):
    class Meta:
        model = Doctores
        fields =  '__all__'

    # se valida que el nombre tenga mas de tres digitos
    def validate_nombre(self,value):
        if len(value) <= 3:
            raise serializers.ValidationError("El nombre del doctor tiene que tener mas de 3 caracteres.")
        return value
    
    # se valida que el primer Apellido tenga mas de tres digitos
    def validate_primerApellido(self,value):
        if len(value) <= 5:
            raise serializers.ValidationError("El primer apellido del doctor tiene que tener mas de 5 caracteres.")
        return value
    
    # se valida que el segundoApellido tenga mas de tres digitos
    def validate_segundoApellido(self,value):
        if len(value) <= 5:
            raise serializers.ValidationError("El segundo apellido del doctor tiene que tener mas de 5 caracteres.")
        return value

    # los anios de experiencia no debe ser un numero negativo
    def validate_aniosExperiencia(self,value):
        if value < 0:
            raise serializers.ValidationError("No se permiten numeros negativos")
        return value

# -- Serializer del Modelo de citas --------------------------------------------------------------------------------------------
class CitasSerializer(serializers.ModelSerializer):
    class Meta:
        model = Citas
        fields = '__all__'



# -- Serializer del Modelo de EspecialidadesDoctores -----------------------------------------------------------------------------
class EspeDoctSerializer(serializers.ModelSerializer):
    class Meta:
        model = EspecialidadesDoctores
        fields = '__all__'