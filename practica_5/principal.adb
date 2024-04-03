--
with Horno;
with Sensor; use Sensor;
with Calefactor; use Calefactor;
with ada.text_io; use ada.text_io;
procedure principal is 

procedure getDatos is 
    temperaturaActual : Temperaturas;
    temperaturaAnterior : Temperaturas;
begin
    Calefactor.Escribir(1000);
    delay 2.6;
    while temperaturaAnterior /= temperaturaActual loop
        temperaturaAnterior := temperaturaActual;
        Sensor.Leer(temperaturaActual);
        put(temperaturaActual'Image & ", ");
    end loop;
end getDatos;
begin

end principal;