--
with ada.text_io; use ada.text_io;
package body PID is 

    procedure Programar (el_Controlador: in out Controlador; Kp, Ki, Kd: Real) is
    begin
        el_Controlador.Kp := Kp;
        el_Controlador.Ki := Ki;
        el_Controlador.Kd := kd;
    end Programar;

    procedure Controlar(con_el_Controlador: in out Controlador; R, C: Entrada; U: out Salida) is
    e : Real;
    Ts : constant Real := 0.3; 
    check : Real;
    begin
        --R referencia
        --C temperatura actual
        --U potencia
        

        e := Real(R-C);
		con_el_Controlador.S_Anterior := Real(con_el_Controlador.S_Anterior + e*Ts);
		check := con_el_Controlador.Kp * (e + con_el_Controlador.S_Anterior/con_el_Controlador.Ki + con_el_Controlador.Kd*((e - con_el_Controlador.Error_Anterior)/Ts));
        con_el_Controlador.Error_Anterior := real(e);
        if check <= real(0) then
            --Si me salgo del rango, escribo 0.1 (no 0.0 porque se apaga el horno)
            u := Salida(0.1);
        else
            u := Salida(check);
        end if;
        
    end Controlar;

end PID;