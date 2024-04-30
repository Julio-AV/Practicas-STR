--
with ada.Real_time; use ada.Real_time;
with ada.Text_Io; use ada.Text_Io;
with proc; use proc;
procedure simular is 

type ref_Procedimiento_t is access procedure;
--type array_ref_Procedimiento_t is array (Positive range <>) of ref_Procedimiento_t;
task type Tarea_t  (
    Nombre : Natural;
    T : Natural;
    D : Natural;
    C : Natural;
    P : Natural;
    Codigo_Ciclico: ref_Procedimiento_t) is pragma Priority (P);
end Tarea_t;

Tarea1: Tarea_t (1, 2400, 600, 400, 4, P1'Access);
Tarea2: Tarea_t (2, 3200, 1200, 600, 3, P2'Access);
Tarea3: Tarea_t (3, 3600, 2000, 800, 2, P3'Access);
Tarea4: Tarea_t (4, 4000, 3200, 800, 1, P4'Access);

task body Tarea_t is 
multiplicador : Natural := 1;
t_transcurrido : Integer;
t_ini : Time;
t_start : Time;
begin 
    t_start := clock;
    t_ini := clock;
    while Integer(to_duration(clock - t_start)) < 50000 loop
        Codigo_Ciclico.all;
        t_transcurrido := Integer(To_Duration(Clock - T_Ini)*1000);
        if t_transcurrido > D then --No se ha ejecutado en el deadline
            put_Line("La tarea: " & Nombre'Image & "NO se ha ejecutado en el plazo");
        else 
            put_Line("La tarea: " & Nombre'Image & " se ha ejecutado en el plazo");
        end if;
        T_Ini := T_Ini + Milliseconds(T);
        delay until t_ini;
        multiplicador := multiplicador+1;
    end loop;
end Tarea_t;

begin 
    null;
end simular;