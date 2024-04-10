--
with Horno;
with Sensor; use Sensor;
with Calefactor; use Calefactor;
with ada.text_io; use ada.text_io;
with ada.Real_time; use ada.Real_time;
procedure principal is 

procedure getDatos is 
    temperaturaActual : Temperaturas;
    temperaturaAnterior : Temperaturas;
    t_ini : time;
    t_actual : time;
    t_diff : time_span;
begin
    Sensor.Leer(temperaturaActual);
    Sensor.Leer(temperaturaAnterior);
    Calefactor.Escribir(calefactor.Potencias(1000));
    t_ini := clock;
    while temperaturaAnterior = temperaturaActual loop
        --Bucle para el retardo
        temperaturaAnterior := temperaturaActual;
        Sensor.Leer(temperaturaActual);
        put(temperaturaActual'Image & ", ");
        t_actual := clock;
        t_diff := t_actual - t_ini;
        Put_Line(to_duration(t_diff)'Image & " ;");

        delay 0.3;
    end loop;
    while temperaturaAnterior /= temperaturaActual loop
        --Bucle para el regimen transitorio
        temperaturaAnterior := temperaturaActual;
        Sensor.Leer(temperaturaActual);
        put(temperaturaActual'Image & ", ");
        t_actual := clock;
        t_diff := t_actual - t_ini;
        Put_Line(to_duration(t_diff)'Image & " ;");
        delay 1.0;
    end loop;
end getDatos;
begin
    getDatos;

    Calefactor.Escribir(calefactor.Potencias(0.0));
end principal;