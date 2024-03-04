--
with Fracciones, Colas;
use Fracciones;
procedure Cola_Fracciones is 
package cola_fracciones is new Colas(fraccion_t, Imprimir);
use cola_fracciones;
Cola : cola_t;
begin
    for i in 1 .. 4 loop
        for j in 1 .. 4 loop
            Poner(i/j, Cola);
        end loop;
    end loop;
    MostrarCola(Cola); --Las fracciones están simplificadas
end cola_fracciones;