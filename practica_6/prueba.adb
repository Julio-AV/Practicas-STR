--
with Ada.Text_Io, Plan;
use Ada.Text_Io, Plan;
with proc; use proc;
procedure Prueba is
package Integer_Es is new Integer_Io (Integer);
use Integer_Es;
Tareas: array_reg_Planificacion_t := (
-- -------------------------------------------------
-- Tarea T D C P R Planificable
-- -------------------------------------------------
 ( 1, 20, 20, 3, 1, 0, False ),
 ( 2, 20, 5, 3, 1, 0, False ),
 ( 3, 15, 7, 3, 1, 0, False ),
 ( 4, 10, 10, 4, 1, 0, False )
 -- -------------------------------------------------
 );
 Tareas2 : array_reg_Planificacion_t := (
   --Tareas apartado 2
   (1, 2400, 600, 1, 1, 0, false),
   (2, 3200, 1200, 1, 1, 0, false),
   (3, 3600, 2000, 1, 1, 0, false),
   (4, 4000, 3200, 1, 1, 0, false)
 );
 procs : array_ref_Procedimiento_t := (
   p1'Access,p2'Access,p3'Access,P4'Access
 );
 begin
    Planificar (Tareas);
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
   --Prueba para la parte 2
   Medir(procs,Tareas2);
    
 end Prueba;