--
with Horno;
with Sensor; use Sensor;
with Calefactor; use Calefactor;
with ada.text_io; use ada.text_io;
with ada.Real_time; use ada.Real_time;
with PID;
procedure principal is 
    package Temperaturas_IO is new ada.text_io.Float_IO(Temperaturas);
    package control is new PID (Real => Float, Entrada => Temperaturas, Salida => Potencias);
procedure getDatos is 
    --Función para pasar los datos al txt
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

        delay 0.3/10.0;
    end loop;
    while temperaturaAnterior /= temperaturaActual loop
        --Bucle para el regimen transitorio
        temperaturaAnterior := temperaturaActual;
        Sensor.Leer(temperaturaActual);
        put(temperaturaActual'Image & ", ");
        t_actual := clock;
        t_diff := (t_actual - t_ini)*10;
        Put_Line(to_duration(t_diff)'Image & " ;");
        delay 0.3/10.0;
    end loop;
end getDatos;

t_ini : time;
t_now : time;
t_diff : time_span;

L : constant Float := 1.5;
K : constant Temperaturas := Temperaturas(86.7);
Tau : constant Integer := 100;
Kp : Float;
Ti : Float;
Td : Float;
Ts : constant Float := 0.3/10.0; --Quitar el /10.0 si no se usa la aceleracion
T_actual : Temperaturas;
Tref : Temperaturas;
u : Potencias;
c : Control.Controlador;

begin
    
    --getDatos;
    Put_Line("Introduce la temperatura de referencia: ");
    Temperaturas_IO.get(Tref);
    Kp := 1.2*Float(Tau)/(Float(K)*L);
    Ti := 2.0*L;
    Td := 0.5*L;
    Put_Line("Kp: " & Kp'Image);
    Put_Line("Ti; " & Ti'Image);
    Put_Line("Td: " & Td'Image);
    Control.Programar(c, Kp, Ti, Td);
    t_ini := clock;
    loop -- Bucle con periodicidad Ts
        
        Sensor.Leer(T_actual);
        --calcular u(t)=P(t)=PID(e)
        control.Controlar(c, Tref, T_actual, u);
        --Put_Line("La potencia escrita es de: " & u'Image);
        Calefactor.Escribir(u);
        Put(T_actual'Image & ",");
        t_now := clock;
        t_diff := (t_now - t_ini)*10; --Eliminar el *10 si el simulador no está acelerado
        Put(to_duration(t_diff)'Image);
        new_line;
        exit when Integer(to_duration(t_diff)) = (600);

        delay standard.Duration(Ts);
    end loop;

    Calefactor.Escribir(calefactor.Potencias(0.0));
    exception when Constraint_Error => Put_Line("Error de rango");
end principal;