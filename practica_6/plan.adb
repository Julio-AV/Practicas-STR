--
with ada.Real_time; use ada.Real_time;
with ada.Text_Io; use ada.Text_Io;
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
        LastWi : Natural;
        Wi : Natural;
    begin
        --  printTareas(Tareas);
        bubbleSortTareas(Tareas);  
        --  Put_Line("------------------");
        --  printTareas(Tareas);
        for i in Tareas'Range loop
            Put_Line("EStamos en la tarea: " & i'Image);
            Tareas(i).Planificable := True;
            LastWi := 0;
            Wi := 0;
            for j in Tareas'First .. i loop --Cogemos todas las tareas anteriores 
                Put(i'Image);
                Put(" " & j'Image);
                Wi := Wi + Tareas(j).C;
                
            end loop;
            while Wi <= Tareas(i).D and LastWi /= Wi loop
                LastWi := Wi;
                Wi := 0;
                for j in Tareas'First .. i loop
                    wi := wi + Natural(Float'Ceiling(float(LastWi)/float(Tareas(j).T)))*Tareas(j).C;
                end loop;
                Put_Line("EL Wi de la tarea: " & Tareas(i).Nombre'Image & "es de: " & wi'Image);

            end loop;
            if Wi > Tareas(i).D then
                Tareas(i).Planificable := False;
            end if;
        end loop;
    --sortByName(Tareas);
    end Planificar;

    procedure Medir(Procedimientos: array_ref_Procedimiento_t; Tareas: in out array_reg_Planificacion_t) is 
        --Tiempos : array_Tiempos_t;
    begin
        null;
    end Medir;

    procedure bubbleSortTareas(Tareas: in out array_reg_Planificacion_t) is 
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
        for i in Tareas'Range loop --Asignamos las prioridades
            Tareas(i).P := Tareas'Last+1 - i;
        end loop;
    end bubbleSortTareas;
    procedure printTareas(Tareas: in out array_reg_Planificacion_t) is 
    begin 
        for i in Tareas'Range loop
            Put_Line(Tareas(i).Nombre'Image);
        end loop;
    end printTareas;

    procedure sortByName(Tareas: in out array_reg_Planificacion_t) is 
    Tareas_aux:  array_reg_Planificacion_t := Tareas;
    begin
        for i in Tareas_aux'Range loop
            Tareas(Tareas_aux(i).Nombre) := Tareas_aux(i);
        end loop;
    end sortByName;
end plan;

