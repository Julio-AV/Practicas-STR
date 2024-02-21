-- Julio Álvarez Villaescusa
with 
Ada.Text_Io, 
ADA.STRINGS.UNBOUNDED,
Ada.Strings.Unbounded.Text_IO, 
ADA.TEXT_IO.UNBOUNDED_IO;
use Ada.Text_Io;
procedure registros is
type dias_t is range 1..31;
type meses_t is (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre);
type nota_t is delta 0.1 range 0.0 .. 10.0;
type year_t is new Integer range 2000 .. 2024;
package ES_dia_t is new Ada.Text_Io.Integer_Io(dias_t);
package ES_mes_t is new Ada.Text_IO.Enumeration_Io(meses_t);
package ES_year_t is new Ada.Text_IO.Integer_Io(year_t);
package ES_int is new Ada.Text_Io.Integer_Io(Integer);
package Es_nota_t is new Ada.Text_IO.Fixed_Io(nota_t);


type fecha_t is record
    Dia : dias_t ;
    Mes : meses_t ;
    Year : year_t ;
end record ;


type registro_t is record

    Titulo: ADA.STRINGS.UNBOUNDED.Unbounded_String;
    Fecha: fecha_t;
    Nota: nota_t;

end record;

type array_t is array (Integer range <>) of registro_t;
-- Creamos un tipo puntero al tipo anterior
type pArray_t is access array_t ;



procedure printFecha(fecha: in fecha_t) is
begin
    Put_Line("Año: " & year_t'Image(fecha.Year));
    Put_Line("Mes: " & meses_t'Image(fecha.Mes));
    Put_Line("Día: " & dias_t'Image(fecha.Dia));
end printFecha;

procedure printPelicula(registro: in registro_t) is 

begin

    put("Titulo: ");
    Ada.Text_IO.Unbounded_IO.Put_Line(registro.Titulo);
    
    Put_Line("Fecha: ");

    printFecha(registro.Fecha);
    put("Nota: ");
    Es_nota_t.Put(registro.Nota);
    New_Line;
    
end printPelicula;

procedure getFecha(fecha : out fecha_t) is 
begin
    put("Introduzca el día: ");
    ES_dia_t.get(fecha.Dia);
    New_Line;
    put("Introduzca el mes: ");
    ES_mes_t.get(fecha.Mes);
    New_Line;
    put("Introduzca el año: ");
    ES_year_t.get(fecha.Year);
    New_Line;
end getFecha;

procedure getPeliculas(arr : out pArray_t) is
reg : registro_t;
begin
    for i in arr'Range loop
        put("Pelicula " & i'Image & ": ");
        New_line;
        put("Introduzca el título: ");
        Skip_Line;
        reg.Titulo := Ada.Text_IO.Unbounded_IO.Get_Line;

        New_Line;
        put("Introduzca la nota: ");
        Es_nota_t.get(reg.Nota);
        New_Line;
        getFecha(reg.Fecha);
        arr(i) := reg;

    end loop;

end getPeliculas;



function checkFechaMenor(fecha1: in fecha_t; fecha2 : in fecha_t) return Boolean is 
--Comprueba si fecha2 es menor que fecha1

es_menor : Boolean := False;
begin 

    if fecha1.Year > fecha2.Year then 
        es_menor := True;
    elsif fecha1.Year = fecha2.Year then
        if fecha1.Mes > fecha2.Mes then
            es_menor := True;
        elsif fecha1.Mes = fecha2.Mes then
            if fecha1.Dia > fecha2.Dia then
                es_menor := true;
            end if; 
        end if;

    end if;
    return es_menor;

end checkFechaMenor;

function getFechaMinima(arr : in pArray_t) return registro_t is 
--Devuelve el elemento con fecha menor de un array
    minimo : registro_t;
    begin
    minimo := arr(1);
    for i in arr'Range loop
        if checkFechaMenor(minimo.Fecha, arr(i).Fecha) then
            minimo := arr(i);
        end if;
    end loop;
    return minimo;
end getFechaMinima;

function getFechaMaxima(arr : in pArray_t) return registro_t is
max : registro_t;
begin 
    max := arr(1);
    for i in arr'Range loop
        if not checkFechaMenor(max.Fecha, arr(i).Fecha) then 
            max := arr(i);
        end if;
    end loop;
    return max;
end getFechaMaxima;

function calcularMedia(arr :in pArray_t) return nota_t is 
media : Float := 0.0;

begin

    for i in arr'Range loop
        --printPelicula(arr(i));
        media := media + Float(arr(i).Nota);
    end loop;
    return nota_t(media/Float(arr'Length));
end calcularMedia;

function getMenorNota(arr : in pArray_t) return registro_t is 
registro : registro_t;
minimo : nota_t := 10.0;
begin 
    for i in arr'Range loop
        if arr(i).Nota <= minimo then
            minimo := arr(i).Nota;
            registro := arr(i);
        end if;
    end loop;
    return registro;
end getMenorNota;

function getMayorNota(arr : in pArray_t) return registro_t is 
registro : registro_t;
minimo : nota_t := 0.0;
begin 
    for i in arr'Range loop
        if arr(i).Nota >= minimo then
            minimo := arr(i).Nota;
            registro := arr(i);
        end if;
    end loop;
    return registro;
end getMayorNota;


array_reg : pArray_t;
tam : Integer;
error_tam : exception;
media : nota_t;
menor_nota : registro_t;
mayor_nota : registro_t;
menor_fecha : registro_t;
mayor_fecha: registro_t;




begin
    put("Introduzca la cantidad de películas a registrar: ");
    ES_int.get(tam);
    if tam <= 0 then 
        Put("EL NÚMERO DE PELÍCULAS DEBE SER MAYOR QUE 0!!!");
        raise error_tam;
    end if;
    array_reg := new array_t(1 .. tam);



    getPeliculas(array_reg);
    --Bucle para imprimir las películas
    for i in array_reg'Range loop
        Put_Line("Registro " & i'Image & ":");
        printPelicula(array_reg(i));
    end loop;
    New_Line;
    New_Line;
    Put_Line("DATOS OBTENIDOS:");
    media := calcularMedia(array_reg);

    New_Line;

    mayor_nota := getMayorNota(array_reg);
    menor_nota := getMenorNota(array_reg);
    Put_Line("Nota mínima: " & menor_nota.Nota'Image & " Película: " & Ada.Strings.Unbounded.To_String(menor_nota.Titulo) & " alquilada el " & menor_nota.Fecha.Dia'Image & " de " &  menor_nota.Fecha.Mes'Image & " de " & menor_nota.Fecha.Year'Image & "." );
    --printPelicula(mayor_nota);
    Put_Line("Nota máxima: " & mayor_nota.Nota'Image & " Película: " & Ada.Strings.Unbounded.To_String(mayor_nota.Titulo) & " alquilada el " & mayor_nota.Fecha.Dia'Image & " de " &  mayor_nota.Fecha.Mes'Image & " de " & mayor_nota.Fecha.Year'Image & "." );
    --printPelicula(menor_nota);
    menor_fecha := getFechaMinima(array_reg);
    mayor_fecha := getFechaMaxima(array_reg);
    Put_Line("La nota media del período entre el " &  menor_fecha.Fecha.Dia'Image & " de " &  menor_fecha.Fecha.Mes'Image & " de " & menor_fecha.Fecha.Year'Image & " al " & mayor_fecha.Fecha.Dia'Image & " de " &  mayor_fecha.Fecha.Mes'Image & " de " & mayor_fecha.Fecha.Year'Image & " ha sido de " & media'Image);

end registros;

