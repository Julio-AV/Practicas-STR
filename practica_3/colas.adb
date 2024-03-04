--
with Ada.Unchecked_Deallocation;

with ada.text_IO; use ada.text_IO;
package body Colas is
procedure Free is new Ada.Unchecked_Deallocation(Nodo, ref_Nodo);
        
function getPenultimo(cola : cola_t) return ref_Nodo is 
    nodoAnterior : ref_Nodo := null;
    nodoActual : ref_Nodo := cola.ptr_Primero;
begin 
    if nodoActual /= null then
        while(nodoActual.ptr_Siguiente /= null) loop
            nodoAnterior := nodoActual;
            nodoActual := nodoActual.ptr_Siguiente;
        end loop;
    end if;
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
    penultimo : ref_nodo := getPenultimo(de_la_Cola);
begin 
    --recuerda que cuando quites el elemento tienes que comprobar si es el primero para quitarlo de cola_t
    un_Elemento := de_la_Cola.ptr_Ultimo.all.Datos;
    Free(de_la_Cola.ptr_Ultimo);
    if de_la_Cola.ptr_Primero = de_la_Cola.ptr_Ultimo or penultimo = null then
        de_la_Cola.ptr_Primero := null;
        de_la_Cola.ptr_Ultimo := null;
    else
        de_la_Cola.ptr_Ultimo := penultimo;
        penultimo.ptr_Siguiente := null;
    end if;
    
end Quitar;
function Esta_Vacia (La_Cola: cola_t) return Boolean is 
begin 
    return La_Cola.ptr_Primero = null;
end Esta_Vacia;

function Esta_Llena (La_Cola: cola_t) return Boolean is 
begin 
    return La_Cola.ptr_Primero /= null;
end Esta_Llena;

procedure MostrarCola (La_Cola: cola_t) is
--ESto puede petar porque hago que el último elemento sea igual a null y quizás refNodo no puede tomar ese valor
    nodoActual : ref_Nodo := La_Cola.ptr_Primero;
begin 
    while nodoActual /= null  loop
        put(ToString(nodoActual.all.Datos));
        New_Line;
        nodoActual := nodoActual.ptr_Siguiente;
    end loop;
end MostrarCola;

procedure Copiar ( Origen: cola_t; Destino:in out cola_t) is 
    nodoActual : ref_Nodo := Origen.ptr_Primero;
    nodoNuevo : ref_Nodo := new Nodo;
begin
    if Origen.ptr_Primero /= null then
        nodoNuevo.all.Datos := nodoActual.all.Datos;
        Destino.ptr_Primero := nodoNuevo;
        Destino.ptr_Ultimo := nodoNuevo;
       
        while nodoActual.all.ptr_Siguiente /= null loop
            nodoActual := nodoActual.all.ptr_Siguiente;
            nodoNuevo := new Nodo;
            nodoNuevo.all.Datos := nodoActual.all.Datos;
            Destino.ptr_Ultimo.all.ptr_Siguiente := nodoNuevo;
            Destino.ptr_Ultimo := nodoNuevo;
            
        end loop;
    end if;
end Copiar;

function "="(La_Cola, Con_La_Cola: cola_t) return Boolean is
    sonIguales : Boolean := True;
    nodo1 : ref_Nodo := La_Cola.ptr_Primero;
    nodo2 : ref_Nodo := Con_La_Cola.ptr_Primero;
begin
    while sonIguales and (nodo1 /= null or nodo2 /= null) loop
        sonIguales := nodo1.all.Datos = nodo2.all.Datos;
        nodo1 := nodo1.all.ptr_Siguiente;
        nodo2 := nodo2.all.ptr_Siguiente;
    end loop;
    return sonIguales;
end "=";
end Colas;