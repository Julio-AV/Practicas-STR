import pandas as pd
import matplotlib.pyplot as plt

def graficar_desde_archivo(archivo):
    with open(archivo, 'r') as f:
        datos = f.read().strip().split('\n')

    x = []
    y = []
    for linea in datos:
        valores = linea.split(',')
        y.append(float(valores[0]))  # Primer valor de la primera columna
        x_int = float(valores[1].rstrip(';'))
        x.append(x_int)  # Segundo valor de la segunda columna

    plt.figure(figsize=(10, 6))
    plt.plot(x, y, marker='o', linestyle='-')  # Gráfico de línea con marcadores circulares
    plt.xlabel('Tiempo [s]')
    plt.ylabel('Temperatura [C]')
    plt.title('Gráfico de evolución de la temperatura del horno con 1000W')
    plt.grid(True)
    plt.show()



graficar_desde_archivo('datosHorno.txt')
