--
with calefactor; use calefactor;
with Sensor; use Sensor;
with ada.real_time; use ada.real_time;
with ada.text_IO; use ada.text_IO;
with Horno; 
procedure medir2 is 
package miHorno renames Horno;
t_anterior : Temperaturas;
t_actual : Temperaturas;
t_diferencial_actual : Temperaturas;
t_diferencial_anterior : Temperaturas;
P : Potencias := Potencias(1000);
T : constant Natural := 1;
Ct : Float;
Cp: constant := 25.0;
T_Ambiente : Temperaturas;

begin
    Sensor.Leer(T_Ambiente);
    calefactor.Escribir(P);
    Sensor.Leer(t_anterior);
    delay(Standard.Duration(3));
    Sensor.Leer(t_actual);
    t_diferencial_anterior := Temperaturas(0);
    t_diferencial_actual := Temperaturas(0);
    Put_Line(t_actual'Image);
    while(t_diferencial_anterior <= t_diferencial_actual) loop   --Bucle hasta llegar al pico del régimen transitorio
        t_diferencial_anterior := t_diferencial_actual;
        t_anterior := t_actual;
        delay(Standard.Duration(1));
        Sensor.Leer(t_actual);
        t_diferencial_actual := Temperaturas(Float(t_actual) -  Float(t_anterior));
    end loop;
    Put_Line("Diferencial de T final es " & t_diferencial_anterior'Image);
    Ct := (Float(P)-Float(Cp)*(Float(t_anterior) - Float(T_Ambiente)))/Float(t_diferencial_anterior);
    Put_Line("Ct tiene un valor de " & Ct'Image);

    calefactor.Escribir(0.0);

end medir2;