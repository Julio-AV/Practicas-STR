--
with calefactor; use calefactor;
with Sensor; use Sensor;
with ada.real_time; use ada.real_time;
with ada.text_IO; use ada.text_IO;
with Horno; 
procedure medir1 is 
P : Potencias := Potencias(1000);
temperatura_ambiente : Temperaturas;
T_Inicial : Time;
T_Final : Time;
L : Time_Span;
temperatura_respuesta : Temperaturas;
T_cp_1 : Temperaturas;
T_cp_2 : Temperaturas;
Cp : Temperaturas;
begin
    Sensor.Leer(temperatura_ambiente); --Leemos la temperatura en el horno antes de calentarlo para hallar la temperatura ambiente
    Put_Line("La temperatura ambiente es de " & temperatura_ambiente'Image & " grados");
    T_Inicial := Clock;
    Calefactor.Escribir(P);
    Sensor.Leer(temperatura_respuesta);
    while(temperatura_respuesta = temperatura_ambiente) loop
        --Esperamos a que las temperaturas sean distintas
        Sensor.Leer(temperatura_respuesta);
    end loop;
    T_Final := Clock;
    L := T_Final - T_Inicial;
    Put_Line("El retardo en la respuesta L es de " & to_duration(L)'Image & " segundos");
    T_cp_1 := Temperaturas(1);
    T_cp_2 := Temperaturas(2);
    while(T_cp_1 /= T_cp_2) loop
    --Esperamos a que se estabilice el horno
        Sensor.Leer(T_cp_1);
        delay(Standard.Duration(1));
        Sensor.Leer(T_cp_2);
        Put_Line("1: " & T_cp_1'Image);
        Put_Line("2: " & T_cp_2'Image);
    end loop;
    -- 0 = P − Cp(T − Te)
    Cp := Temperaturas(Float(P)/Float(T_cp_2 - temperatura_ambiente));
    
    Put_Line("El coeficiente de pérdidas es de " & Cp'Image);   --2.50012E+01 (La ejecución tarda demasiado hasta estabilizarse, este es el output que me ha dado)
    
    
    
    Calefactor.Escribir(0.0);
end medir1;