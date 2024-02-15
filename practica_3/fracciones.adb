--
with ada.text_IO; use ada.text_IO;
package body Fracciones is 
    package ES_Integer is new ada.text_IO.Integer_IO(Integer);
    package ES_Positive is new ada.text_IO.Integer_IO(Positive);
    procedure Leer(F: out fraccion_t) is
    begin
        ES_Integer.get(F.Num);
        ES_Positive.get(F.Den);
    end Leer;

    procedure Escribir(F : in fraccion_t) is 
    begin

        put(F.Num'Image & "/" & F.Den'Image);

    end Escribir;

    procedure reducir(X : in out fraccion_t) is 
    maxComDiv : Integer;
    begin
    maxComDiv := mcd(X.Num, X.Den);    
    X.Num := X.Num/maxComDiv;
    X.Den := X.Den/maxComDiv;

    end reducir;
    function "/"(X,Y: Integer) return fraccion_t is 
    --Constructor
    F: fraccion_t;
    begin
        if (X < 0 and Y < 0) or (X > 0 and Y > 0)  then
            F := (num => abs(X), den => Positive(abs(Y)));
        else
            F := (num => -abs(X), den => Positive(abs(Y)));
        end if;
        return F;
    end "/";

    function "/" (X, Y: fraccion_t) return fraccion_t is
    num : Integer;
    den : Integer;
    begin
        num := X.Num * Y.Den;
        den := X.Den * Y.Num;
        return num/den;
    end "/";

    function "+" (X, Y: fraccion_t) return fraccion_t is
    res_num : Integer;
    res_den : Integer;
    F : fraccion_t;
    begin
        res_num := X.Num * Y.Den + Y.Num * X.Den;
        res_den := X.Den * Y.Den;
        F := (Num => res_num, Den => res_den);
        return F;
    end "+";

    function "-" (X: fraccion_t) return fraccion_t is
    F : fraccion_t := X;
    begin
        F.Num := -F.Num;
        return F;
    end "-";
    function "-" (X, Y: fraccion_t) return fraccion_t is
    begin
        return X+(-Y);
    end "-";
    function "*" (X, Y: fraccion_t) return fraccion_t is
    F : fraccion_t;
    begin
        F := (Num => X.Num*Y.Num, Den => X.Den * Y.Den);
        return F;
    end "*";

    function "=" (X, Y: fraccion_t) return Boolean is
    A : fraccion_t;
    B : fraccion_t;
    begin
        A := X;
        B := Y;
        reducir(A);
        reducir(B);
        return (A.Num = B.Num) and (A.Den = B.Num);
    end "=";
    function Numerador (F: fraccion_t) return Integer is
    begin
        return F.Num;
    end Numerador;
    function Denominador(F:fraccion_t) return Positive is
    begin
        return F.Den;
    end Denominador;

    function mcm(X,Y : in fraccion_t) return Integer is 
    -- Función para calcular el Mínimo Común Múltiplo (MCM) de dos enteros
    m, n, temp : Integer;   
    begin
        m := X.Den;
        n := Y.Den;
        while n /= 0 loop
            temp := n;
            n := m mod n;
            m := temp;
        end loop;
        return (X.Den*Y.Den)/m;
    end mcm;

    function mcd(x, y : Integer) return Integer is
        Temp : Integer;
        A : Integer := x;
        B : Integer := y;
    begin
        while B /= 0 loop
            Temp := B;
            B := A mod B;
            A := Temp;
        end loop;
        return A;
    end mcd;

    function mcd(X,Y : in fraccion_t) return Integer is
        A, B : Integer;
        Temp : Integer;
    begin
        A := X.Den;
        B := Y.Den;
        while B /= 0 loop
            Temp := B;
            B := A mod B;
            A := Temp;
        end loop;
        return A;
    end mcd;


end Fracciones;
