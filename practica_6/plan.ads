--
with ada.Text_Io;
package plan is
    type ref_Procedimiento_t is access procedure;
    type array_ref_Procedimiento_t is array (Positive range <>)
    of ref_Procedimiento_t;
    type array_Tiempos_t is array (Positive range <>) of Natural;
    type reg_Planificacion_t is record
        Nombre : Positive; -- Número de la tarea
        T : Natural; -- Período
        D : Natural; -- Plazo
        C : Natural; -- Tiempo de cómputo
        P : Positive; -- Prioridad
        R : Natural; -- Tiempo de respuesta
        Planificable: Boolean;
    end record;
    type array_reg_Planificacion_t is array (Positive range <>) of reg_Planificacion_t;
    procedure Planificar (Tareas: in out array_reg_Planificacion_t);
    procedure Medir (Procedimientos: array_ref_Procedimiento_t; Tiempos : out array_Tiempos_t);
    procedure Medir(Procedimientos: array_ref_Procedimiento_t; Tareas: in out array_reg_Planificacion_t);
    
private 
    
    procedure bubbleSortTareas(Tareas: in out array_reg_Planificacion_t);
    procedure printTareas(Tareas: in array_reg_Planificacion_t);
    procedure sortByName(Tareas: in out array_reg_Planificacion_t);
    procedure printComputos(Tiempos : array_Tiempos_t;  Tareas: array_reg_Planificacion_t);
end plan;