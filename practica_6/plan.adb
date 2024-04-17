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
end plan;