from django.urls import path
from .models import *
from .views import *



urlpatterns = [
     
     # -- Rutas para Pacientes
     path('paciente/',PacienteListCreateView.as_view(), name='pacientes-list-create'),
     path('paciente/<int:pk>/',PacientesDetailsView.as_view(), name='pacientes-update-delete'),

     # -- Rutas para Especialidades
     path('especialidades/',EspecialidadesListCreateView.as_view(), name='especialidades-list-create'),
     path('especialidades/<int:pk>/',PacientesDetailsView.as_view(), name='especialidades-update-delete'),

     # -- Rutas para Doctores
     path('doctores/',DoctoresListCreateView.as_view(), name='doctores-list-create'),
     path('doctores/<int:pk>/',PacientesDetailsView.as_view(), name='doctores-update-delete'),

     # -- Rutas para Citas
     path('citas/',CitasListCreateView.as_view(), name= 'citas-list-create'),
     path('citas/<int:pk>/',CitasDetailsView.as_view(), name='citas-update-delete'),

     # -- Rutas para EspecialidadesDoctores
     path('especialidadesDoctores/',EspeDoctListCreateView.as_view(), name='especialidadesDoctores-list-create'),
     path('especialidadesDoctores/',EspeDoctDetailsView.as_view(),name='especialidadesDoctores-update-delete')

]