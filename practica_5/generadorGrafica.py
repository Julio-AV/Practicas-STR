import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
matplotlib.use('TkAgg')

def graficar_desde_archivo(archivo):
    with open(archivo, 'r') as f:
        datos = f.read().strip().split('\n')

    x = []
    y = []
    for linea in datos:
        valores = linea.split(',')
        y.append(float(valores[0]))  # Primer valor de la primera columna
        x_int = int(round(float(valores[1].rstrip(';'))))
        x.append(x_int)  # Segundo valor de la segunda columna

    plt.figure(figsize=(10, 6))
    plt.plot(x, y, marker='o', linestyle='-')  # Gráfico de línea con marcadores circulares
    plt.xlabel('X')
    plt.ylabel('Y')
    plt.title('Gráfico de Y en función de X')
    plt.grid(True)
    plt.show()

# Reemplaza 'archivo.txt' con la ruta de tu archivo de datos
graficar_desde_archivo('datosHorno.txt')