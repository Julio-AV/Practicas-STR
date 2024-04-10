import pandas as pd
import matplotlib.pyplot as plt

def graficar_desde_archivo(archivo):
    with open(archivo, 'r') as f:
        datos = f.read().strip().split('\n')
        datos = datos[0:50]

    x = []
    y = []
    for linea in datos:
        valores = linea.split(',')
        y.append(float(valores[0]))  # Primer valor de la primera columna
        x_int = int(round(float(valores[1].rstrip(';'))))
        x.append(x_int)  # Segundo valor de la segunda columna

    plt.figure(figsize=(10, 6))
    plt.plot(x, y, marker='o', linestyle='-')  # Gráfico de línea con marcadores circulares
    plt.xlabel('t')
    plt.ylabel('C')
    plt.title('Gráfico de temperatura en función del tiempo')
    plt.grid(True)
    plt.show()

# Reemplaza 'archivo.txt' con la ruta de tu archivo de datos
ruta_1 = 'C:/Users/vande/OneDrive/Escritorio/UAH/Sistemas en tiempo real/LAB/practica5'

graficar_desde_archivo('datosHorno.txt')
print("Salí")