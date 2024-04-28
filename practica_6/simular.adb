--
with ada.Real_time; use ada.Real_time;
with ada.Text_Io; use ada.Text_Io;
with proc; use proc;
procedure simular is 

type ref_Procedimiento_t is access procedure;
type array_ref_Procedimiento_t is array (Positive range <>) of ref_Procedimiento_t;
type array_ejecutivo_t is array (Positive range <>) of array_ref_Procedimiento_t;
task type Tarea_t (Nombre : Natural;
    T : Natural;
    D : Natural;
    C : Natural;
    P : Natural;
    Codigo_Ciclico: ref_Procedimiento) is pragma Priority (P);
end Tarea_t;
Tarea1: Tarea_t (1, 2400, 600, 400, 4, P1'Access);
Tarea2: Tarea_t (2, 3200, 1200, 600, 3, P2'Access);
Tarea3: Tarea_t (3, 3600, 2000, 800, 2, P3'Access);
Tarea4: Tarea_t (4, 4000, 3200, 800, 1, P4'Access);
t_start : time;
t_ini_proceso : time;
periodo_basico : Natural := 2400;
array_ciclo_ejecutivo : array_ejecutivo_t := ((Tarea1, Tarea2, Tarea3, null),
                                                    (Tarea1));
begin   
    while Integer(to_duration(clock - t_start)) < 50000 loop
        for i in array_ciclo_ejecutivo'Range loop

        end loop;
    end loop;
end simular;