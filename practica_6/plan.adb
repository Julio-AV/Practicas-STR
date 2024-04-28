--
with ada.Real_time; use ada.Real_time;
with ada.Text_Io; use ada.Text_Io;
package body plan is 
    package Integer_Es is new Integer_Io (Integer);
    use Integer_Es;
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

    procedure printComputos(tiempos : array_Tiempos_t;  Tareas : array_reg_Planificacion_t) is 
    begin
       Put_line ("+---------------------------------------------------+");
        Put_Line ("| Procedimiento  T.Computo |");
        Put_line ("|---------------------------------------------------|");
        for I in Tareas'Range loop
            Put ("| ");
            Put (Tareas(I).Nombre, Width=>5); Put (" ");
            Put (tiempos(i), Width=>4); Put (" ");
            new_line;
        end loop;
    end printComputos;
    procedure Planificar (Tareas: in out array_reg_Planificacion_t) is 
        LastWi : Natural;
        Wi : Natural;
    begin
        --  printTareas(Tareas);
        bubbleSortTareas(Tareas);  
        --  Put_Line("------------------");
        --  printTareas(Tareas);
        for i in Tareas'Range loop
            Tareas(i).Planificable := True;
            LastWi := 0;
            Wi := 0;
            for j in Tareas'First .. i loop --Cogemos todas las tareas anteriores 
                Wi := Wi + Tareas(j).C;
                
            end loop;
            while Wi <= Tareas(i).D and LastWi /= Wi loop
                LastWi := Wi;
                Wi := 0;
                for j in Tareas'First .. i loop
                    wi := wi + Natural(Float'Ceiling(float(LastWi)/float(Tareas(j).T)))*Tareas(j).C;
                end loop;
                --Put_Line("EL Wi de la tarea: " & Tareas(i).Nombre'Image & "es de: " & wi'Image);

            end loop;
            if Wi > Tareas(i).D then
                Tareas(i).Planificable := False;
            else 
                Tareas(i).R := Wi;
            end if;
        end loop;
    --sortByName(Tareas);
    end Planificar;

    procedure Medir(Procedimientos: array_ref_Procedimiento_t; Tareas: in out array_reg_Planificacion_t) is 
        Tiempos : array_Tiempos_t(Tareas'First .. Tareas'Last);
    begin
        Medir(Procedimientos, Tiempos);
        for i in Tareas'Range loop
            Tareas(i).C := Tiempos(i);
        end loop;
        Planificar(Tareas);
        printComputos(Tiempos, Tareas);
        printTareas(Tareas);
     end Medir;
    --Ordena y asigna prioridad a las tareas con criterio DMS
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
            Tareas(i).P := Tareas'Last + 1 - i;
        end loop;
        
    end bubbleSortTareas;
    procedure printTareas(Tareas: in array_reg_Planificacion_t) is 
    begin 
        Put_line ("+---------------------------------------------------+");
        Put_Line ("| Tarea T D C P R Planificable |");
        Put_line ("|---------------------------------------------------|");
    for I in Tareas'Range loop
        Put ("| ");
        Put (Tareas(I).Nombre, Width=>5); Put (" ");
        Put (Tareas(I).T, Width=>4); Put (" ");
        Put (Tareas(I).D, Width=>4); Put (" ");
        Put (Tareas(I).C, Width=>4); Put (" ");
        Put (Tareas(I).P, Width=>4); Put (" ");
        Put (Tareas(I).R, Width=>4); Put (" ");
        if Tareas(I).Planificable then
            Put_Line (" SI |");
        else
            Put_Line (" NO |");
        end if;
    end loop;
    Put_line (
    "+---------------------------------------------------+");
    end printTareas;

    procedure sortByName(Tareas: in out array_reg_Planificacion_t) is 
    Tareas_aux:  array_reg_Planificacion_t := Tareas;
    begin
        for i in Tareas_aux'Range loop
            Tareas(Tareas_aux(i).Nombre) := Tareas_aux(i);
        end loop;
    end sortByName;
end plan;

