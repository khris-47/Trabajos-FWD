from MetodoCesar import Cesar
from BubbleSort import MetodoBurbuja

def Main():

    cesar = Cesar()

    while True:
        print("\n=====Bienvenido=====")
        print("1.🥸  Cifrado Cesar")
        print("2.🫧  Cifrado Burbuja")
        print("3.❎ Salir")

        opcion = input("Que deseas realizar? ").strip()

        if opcion == "1":
            frase = input("🧐 Que frase o palabra deseas cifrar? ").strip()
            print(f"{cesar.cifrado(frase)}") #llamo al metodo de cifrado, este devuelve un mensaje

        elif opcion == "2":
            lista = input("\nDame una lista de numeros (separada por ',' ): ").split(",")
            lista_entero = list(map(int, lista)) #convierto lo ingresado a int

            burbuja = MetodoBurbuja(lista_entero) #inicializo la clase metodoBurjuba (este requeria de la lista)
            print(f"{burbuja.ordenar()}") #llamo al metodo, este devolvera un mensaje

        elif opcion == "3":
            print("✌️ Hasta luego, fue un placer tenerte aqui ✌️\n👋 Saliendo del programa...")
            break

        else:
            print("🚫Upss!, Opcion no valida🚫")

#---------------------------------------------------------------------------------------------------------------
Main()