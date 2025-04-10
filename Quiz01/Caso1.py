
#Creacion del diccionario predeterminado
datos = {
    "producto": "Zapatillas Air Max",
    "talla": 42,
    "color": "Rojo",
    "stock": 20
}

#Funcion para mostrar ordenados del diccionario
def mostrar_datos():
    print("\nDatos actuales del producto:")
    for clave, valor in datos.items():
        print(f"- {clave}: {valor}")
    print()

#Funcion principal
def main():

    #Crear un menu para mayor facilidad de uso
    while True:
        print("========== MENÚ ==========")
        print("1. Modificar atributo")
        print("2. Eliminar atributo")
        print("3. Ver atributos")
        print("4. Agregar atributo")
        print("5. Salir")
        print("==========================")

        #Elegir opcion del usuario
        opcion = input("¿Qué deseas realizar?: ").strip()
        #El usuario escoge modificar
        if opcion == "1":
            atributo = input("¿Qué atributo deseas modificar?: ").strip()

            #Verificamos que el atributo exista
            if atributo in datos:
                nuevo_valor = input("Ingrese el nuevo valor: ").strip()
                
                # si escoge stock o talla, verificar si es int
                if atributo in ["talla", "stock"]:
                    if nuevo_valor.isdigit():
                        nuevo_valor = int(nuevo_valor)
                    else:
                        print("⚠️ Valor inválido. Debe ser un número.")
                        continue

                #le damos el nuevo valor al atributo
                datos[atributo] = nuevo_valor
                print("✅ Atributo modificado con éxito.")
                mostrar_datos()

            else:
                print("⚠️ Atributo no encontrado.")

        #El usuario escoge eliminar
        elif opcion == "2":
            atributo = input("¿Qué atributo deseas eliminar?: ").strip()

            #verificamos que el atributo exista
            if atributo in datos:
                datos.pop(atributo) #eliminacion del atributo
                print("✅ Atributo eliminado con éxito.")
                mostrar_datos()
            else:
                print("⚠️ Atributo no encontrado.")

        #El usuario desea ver los atributos
        elif opcion == "3":
            mostrar_datos()

        #Extra pedido por el profesor para completar el CRUD
        elif opcion == "4":

            nuevo_atributo = input("Nombre del nuevo atributo: ").strip()
            #verifica que no exista ese atributo
            if nuevo_atributo in datos: 
                print("⚠️ Ese atributo ya existe. Usa la opción de modificar.")
                continue

            nuevo_valor = input("Ingrese el valor para ese atributo: ").strip()
            datos[nuevo_atributo] = nuevo_valor
            print("✅ Nuevo atributo agregado.")
            mostrar_datos()

        #Finalizar programa
        elif opcion == "5":
            print("👋 Saliendo del programa...")
            break
        
        #Si el usuario escoge una opcion no valida
        else:
            print("❌ Opción no válida. Intenta de nuevo.")


main()