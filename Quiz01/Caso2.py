
def mostrar_nombres():
    nombres = ["Chris", "Collins", "Karina", "Luis"]
    print("\n📋 Lista de nombres:")
    for i, nombre in enumerate(nombres, 1):
        print(f"{i}. {nombre}")
    print()

def main():
    while True:
        print("========== MENÚ INTERACTIVO ==========")
        print("1. Mostrar mensaje")
        print("2. Mostrar lista de nombres")
        print("3. Salir del programa")
        print("======================================")

        opcion = input("¿Qué deseas realizar?: ").strip()

        if opcion == "1":
           print("\n👋 Hola, bienvenido. ¡Espero que estés teniendo un buen día!\n")
        elif opcion == "2":
            mostrar_nombres()
        elif opcion == "3":
            print("\n👋 Saliendo del programa...")
            break
        else:
            print("\n❌ Opción inválida. Intenta de nuevo.\n")

main()