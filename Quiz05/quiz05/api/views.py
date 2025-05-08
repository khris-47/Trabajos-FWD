
from rest_framework.generics import ListCreateAPIView,RetrieveUpdateDestroyAPIView
from .models import *
from .serializers import *

# -- Vistas para Pacientes --------------------------------------------------------------
class PacienteListCreateView(ListCreateAPIView):
    queryset = Pacientes.objects.all()
    serializer_class = PacienteSerializer

class PacientesDetailsView(RetrieveUpdateDestroyAPIView):
    queryset = Pacientes.objects.all()
    serializer_class = PacienteSerializer

# -- Vistas para Especialidades ---------------------------------------------------------
class EspecialidadesListCreateView(ListCreateAPIView):
    queryset = Especialidades.objects.all()
    serializer_class = EspecialidadesSerializer

class EspecialidadesDetailsView(RetrieveUpdateDestroyAPIView):
    queryset = Especialidades.objects.all()
    serializer_class = EspecialidadesSerializer

# -- Vistas para Doctores ---------------------------------------------------------------
class DoctoresListCreateView(ListCreateAPIView):
    queryset = Doctores.objects.all()
    serializer_class = DoctoresSerializer

class DoctoresDetailsView(RetrieveUpdateDestroyAPIView):
    queryset = Doctores.objects.all()
    serializer_class = DoctoresSerializer

# -- Vistas para Citas -------------------------------------------------------------------
class CitasListCreateView(ListCreateAPIView):
    queryset = Citas.objects.all()
    serializer_class = CitasSerializer

class CitasDetailsView(RetrieveUpdateDestroyAPIView):
    queryset = Citas.objects.all()
    serializer_class = CitasSerializer

# -- Vistas para EspecialidadesDoctores -------------------------------------------------
class EspeDoctListCreateView(ListCreateAPIView):
    queryset = EspecialidadesDoctores.objects.all()
    serializer_class = EspeDoctSerializer

class EspeDoctDetailsView(RetrieveUpdateDestroyAPIView):
    queryset = EspecialidadesDoctores.objects.all()
    serializer_class = EspeDoctSerializer