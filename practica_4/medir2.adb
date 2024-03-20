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

--  t_prueba : miHorno.Temperaturas;
--  t_hornoStatic : Horno.Temperaturas;
begin
    --  miHorno.Escribir(miHorno.Potencias(1000));
    --  delay(Standard.Duration(10));
    --  miHorno.Leer(t_prueba);
    --  Horno.Leer(t_hornoStatic);
    --  Put_Line("La temperatura de miHorno es " & t_prueba'Image);
    --  Put_Line("la temperatura del otro horno es " & t_hornoStatic'Image);
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
        Put_Line("Diferencial de T anterior es " & t_diferencial_anterior'Image);
        Put_Line("Diferencial de T es " & t_diferencial_actual'Image);
        Put_Line("1: " & t_anterior'Image);
        Put_Line("2: " & t_actual'Image);
    end loop;
    Put_Line("Diferencial de T final es " & t_diferencial_anterior'Image);
    Put_Line(Float(P)'Image);
    Put_Line(Float(Cp)'Image);
    Put_Line(Float(t_anterior)'Image);
    Put_Line(Float(T_Ambiente)'Image);
    Put_Line(Float(t_diferencial_anterior)'Image);
    Ct := (Float(P)-Float(Cp)*(Float(t_anterior) - Float(T_Ambiente)))/Float(t_diferencial_anterior);
    Put_Line("Ct tiene un valor de " & Ct'Image);

    calefactor.Escribir(0.0);

end medir2;