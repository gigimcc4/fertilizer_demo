(* silo fill ladder, exercise 3, as structured text for reading without the Editor.
   the source of truth is pous/programs/main.ld; soft_plc.py runs the same rungs.

   inputs python writes are %MX (modbus coils 8192+). in the LogixPro and
   OpenPLC labs they were %IX, which modbus can't write. *)

PROGRAM main
  VAR
    start      : BOOL AT %MX0.0;  (* start pushbutton, pulsed by plant_sim *)
    stop       : BOOL AT %MX0.1;  (* stop pushbutton, normally closed: TRUE = not pressed *)
    prox       : BOOL AT %MX0.2;  (* bag in position under the spout *)
    level      : BOOL AT %MX0.3;  (* bag full *)
    mode_a     : BOOL AT %MX0.4;  (* fill, then move on *)
    mode_b     : BOOL AT %MX0.5;  (* fill, then wait for start *)
    mode_c     : BOOL AT %MX0.6;  (* no fill, wait for start *)
    motor      : BOOL AT %QX0.0;  (* conveyor *)
    solenoid   : BOOL AT %QX0.1;  (* silo gate *)
    run_light  : BOOL AT %QX0.2;
    fill_light : BOOL AT %QX0.3;
    full_light : BOOL AT %QX0.4;
    release    : BOOL;            (* internal *)
  END_VAR

  (* rung 1: run seal-in *)
  run_light  := (start OR run_light) AND stop;
  (* rung 2: full latch, drops when the bag leaves *)
  full_light := (level OR full_light) AND prox;
  (* rung 3: conveyor runs to bring a bag, or to take a full one away *)
  motor      := run_light AND (NOT prox
                OR (full_light AND (mode_a OR ((mode_b OR mode_c) AND release))));
  (* rung 4: gate open while a bag waits and it isn't full *)
  solenoid   := (mode_a OR mode_b) AND run_light AND prox AND NOT full_light;
  (* rung 5 *)
  fill_light := solenoid;
  (* rung 6: release seal-in for modes B and C *)
  release    := (start OR release) AND full_light AND prox;
END_PROGRAM
