from django.db import models

# -- Modelado de Pacientes
class Pacientes(models.Model):
    nombre = models.CharField(max_length=30)
    primerApellido = models.CharField(max_length=30)
    segundoApellido = models.CharField(max_length=30)
    cedula = models.IntegerField(unique=True)
    edad =  models.IntegerField()
    correo = models.EmailField(unique=True)
    telefono = models.CharField(max_length=20)

    def __str__(self):
        return self.nombre

# -- Modelado de Especialidades
class Especialidades(models.Model):
    nombre = models.CharField(max_length=50, unique=True)

    def __str__(self):
        return self.nombre

# -- Modelado de Doctores
class Doctores(models.Model):
    nombre = models.CharField(max_length=30)
    primerApellido = models.CharField(max_length=30)
    segundoApellido = models.CharField(max_length=30)
    aniosExperiencia = models.IntegerField()
    correo = models.EmailField(unique=True)
    telefono = models.CharField(max_length=20)
    especialidades = models.ManyToManyField(Especialidades, through='EspecialidadesDoctores', related_name='doctores')

    def __str__(self):
        return self.nombre

# -- Modelado de EspecialidadesDoctores
class EspecialidadesDoctores(models.Model):
    especialidad = models.ForeignKey(Especialidades, on_delete=models.CASCADE)
    doctores =  models.ForeignKey(Doctores, on_delete=models.CASCADE)
    relevancia = models.IntegerField(default=1)

# -- Modelado de Citas
class Citas (models.Model):
    paciente = models.ForeignKey(Pacientes,on_delete=models.CASCADE)
    doctores =  models.ForeignKey(Doctores, on_delete=models.CASCADE)
    fecha = models.DateField(auto_now_add=True) # campo fecha por defecto en la actual
    hora = models.TimeField(auto_now_add=True)  # campo hora
    motivo = models.CharField(max_length=200)

    def __str__(self):
        return self.id
    

