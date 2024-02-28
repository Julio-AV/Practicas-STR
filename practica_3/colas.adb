--
with Ada.Unchecked_Deallocation;
with ada.text_IO; use ada.text_IO;
package body Colas is
function getPenultimo(cola : cola_t) return ref_Nodo is 
    nodoAnterior : ref_Nodo;
    nodoActual : ref_Nodo := cola.ptr_Primero;
begin 
    
    while(nodoActual.ptr_Siguiente /= null) loop
        nodoAnterior := nodoActual;
        nodoActual := nodoActual.ptr_Siguiente;

    end loop;
    return nodoAnterior;
end getPenultimo;
procedure Poner (el_Elemento: elemento_t; en_la_Cola: in out cola_t) is 
    newNode : ref_Nodo := new Nodo;
begin 
    newNode.all.Datos := el_Elemento;
    newNode.all.ptr_Siguiente := en_la_Cola.ptr_Primero;
    if(en_la_Cola.ptr_Primero = null) then
        en_la_Cola.ptr_Ultimo := newNode; 
    end if;
        
    en_la_Cola.ptr_Primero := newNode;
    
end Poner;

procedure Quitar(un_Elemento: out elemento_t; de_la_Cola: in out cola_t) is 
begin 
    null;
end Quitar;

end Colas;