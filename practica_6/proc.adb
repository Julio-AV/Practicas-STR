--
with ada.Real_time; use ada.Real_time;
package body proc is 

procedure P1 is 
    t_start : Time;
    P1_time : constant Natural := Natural(0.4*1000);
begin
    t_start := Clock;
    while natural(to_duration(clock - t_start)*1000) < P1_time loop
        null; --No hago nada
    end loop;
end P1;

procedure P2 is 
    t_start : Time;
    P2_time : constant Natural := Natural(0.6*1000);
begin
    t_start := Clock;
    while natural(to_duration(clock - t_start)*1000) < P2_time loop
        null; --No hago nada
    end loop;
end P2;

procedure P3 is 
    t_start : Time;
    P3_time : constant Natural := Natural(0.8*1000);
begin
    t_start := Clock;
    while natural(to_duration(clock - t_start)*1000) < P3_time loop
        null; --No hago nada
    end loop;
end P3;

procedure P4 is 
    t_start : Time;
    
    P4_time : constant Natural := Natural(0.8*1000);
begin
    t_start := Clock;
    while natural(to_duration(clock - t_start)*1000) < P4_time loop
        null; --No hago nada
    end loop;
end P4;
end proc;
