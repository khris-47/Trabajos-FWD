
class Cesar:

    def __init__(self):
        self.abecedario = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]



    def cifrado(self, texto):
        texto = texto.lower() #ya que el abecedario esta en minuscula, pasamos el texto a minuscula
        desplazamiento = 1
        texto_cifrado = ""
            
            
        for letra in texto: #recorro cada caracter del texto
            if letra in self.abecedario: #vemos si la letra esta en el abecedario que cree en el init

                #busco la posicion de la letra en el abecedario
                posicion = self.abecedario.index(letra) #si por ejemplo la letra es b, el index me devuelve 1

                #calculo la nueva posición aplicando el desplazamiento
                nueva_posicion = (posicion + desplazamiento) % len(self.abecedario)  
                                                         #esta parte es para evitar desbordamiento

                # Agrega la letra cifrada a la cadena
                texto_cifrado += self.abecedario[nueva_posicion]
            else:
                #si la letra no está en el abecedario, se agrega sin cambios
                #esto por si el caracter es un espacio o alguno "especial" 
                texto_cifrado += letra

        return f"\nLa frase {texto} paso a ser 👉 {texto_cifrado}"  # Devuelve el texto cifrado


        
