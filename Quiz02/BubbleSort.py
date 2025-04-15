
class MetodoBurbuja:
    def __init__(self, lista):
        self.lista = lista

    def ordenar(self):
        # Obtener la longitud de la lista
        largoLista = len(self.lista)
        
        for i in range(largoLista):

            #bucle para comparar elementos adyacentes
            for j in range(0, largoLista-i-1):

                #comparar el elemento actual con el siguiente
                if self.lista[j] > self.lista[j+1]:

                    #si el elemento actual es mayor, intercambiarlos
                    self.lista[j], self.lista[j+1] = self.lista[j+1], self.lista[j]        
                    
        return self.lista
