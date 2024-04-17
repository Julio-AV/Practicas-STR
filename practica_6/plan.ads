--
package plan is
    type ref_Procedimiento_t is access procedure;
    type array_ref_Procedimiento_t is array (Positive range <>)
    of ref_Procedimiento_t;
    type array_Tiempos_t is array (Positive range <>) of Natural;
    procedure Medir (Procedimientos: array_ref_Procedimiento_t;
    Tiempos : out array_Tiempos_t);
end plan;