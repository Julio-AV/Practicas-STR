--
with ada.Real_time; use ada.Real_time;
package body plan is 
    procedure medir(Procedimientos: array_ref_Procedimiento_t; Tiempos : out array_Tiempos_t) is 
        t_start : Time;
        t_end : Time;
        t_diff : Time_Span;
    begin
        
        for i in Procedimientos'Range loop
            t_start := Clock;
            Procedimientos(i).all;
            t_end := Clock;
            t_diff := t_end - t_start;
            Tiempos(i) := Natural(to_duration(t_diff)*1000);
        end loop;
    end medir;

    procedure Planificar (Tareas: in out array_reg_Planificacion_t) is 
        
        aux : reg_Planificacion_t;
    begin 
        --ordenamos las listas con bubble sort
        for i in Tareas'Range loop
            for j in Tareas'First .. Tareas'Last-1 loop
                if (Tareas(j).D > Tareas(j+1).D) or ((Tareas(j).D = Tareas(j+1).D) and (Tareas(j).T > Tareas(j+1).T))  then
                    aux := Tareas(J);
                    Tareas(j) := Tareas(j+1);
                    Tareas(j+1) := aux;
               

                end if;
            end loop;
        end loop;


    end Planificar;

end plan;

