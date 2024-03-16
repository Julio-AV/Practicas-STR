--
with calefactor; use calefactor;
with Sensor; use Sensor;
with ada.real_time; use ada.real_time;
with ada.text_IO; use ada.text_IO;
procedure medir1 is 
--  sens : Sensor;
--  calefact : Calefactor;
temperatura_ambiente : Temperaturas;
T_Inicial : Time;
T_Final : Time;
L : Time_Span;
temperatura_respuesta : Temperaturas;
begin
    Sensor.Leer(temperatura_ambiente); --Leemos la temperatura en el horno antes de calentarlo para hallar la temperatura ambiente
    put("La temperatura ambiente es de " & temperatura_ambiente'Image & " grados");
    T_Inicial := Clock;
    Calefactor.Escribir(Potencias(100));
    Sensor.Leer(temperatura_respuesta);
    while(temperatura_respuesta = temperatura_ambiente) loop
        Sensor.Leer(temperatura_respuesta);
    end loop;
    T_Final := Clock;
    L := T_Final - T_Inicial;
    put("El retardo en la respuesta L es de " & L'Image);
     
 
    
    
    
    
    Calefactor.Escribir(0.0);
end medir1;