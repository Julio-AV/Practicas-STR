%%Importar los datos con import data
plot(datosPID100.t, datosPID100.temperatura, '-' ,datosPID200.t, datosPID200.temperatura, '--'); % 'b-' especifica una línea azul sólida, puedes cambiar 'b' por otros colores si lo deseas
legend('Para target 100', 'Para target 200');
xlabel('t (s)'); % Etiqueta del eje x
ylabel('Temperatura (C)'); % Etiqueta del eje y
title('Gráfico evolución de temperatura del horno'); % Título del gráfico
grid on; % Mostrar cuadrícula en el gráfico