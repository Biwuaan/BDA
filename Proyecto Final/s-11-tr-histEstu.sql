--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion De Tablas
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

connect baoc_proy_admin
     

CREATE TABLE bitacoraCalif(
  fecha VARCHAR2(100),
  modificacion CHAR(1),
  usuario VARCHAR2(50),
  alumno varchar(50),
  calificacion_nueva number(3,1),
  calificacion_vieja number(3,1)
);

CREATE OR REPLACE TRIGGER cambiosCurso
  AFTER UPDATE OR DELETE of calificacion on curso 
  for each row 
  DECLARE
    modifica char(1);
    momento  varchar2(100);
    alu   varchar(50);
    old_calif number(3,1);
    new_calif number(3,1);
    alu_id  NUMBER(10,0);
    cursoID number(3,0);   
BEGIN

  old_calif := :old.calificacion;
  new_calif := :new.calificacion;
  cursoID  := :new.curso_id;

  select i.estudiante_id into alu_id
  from inscripcion i, curso c, curso_inscripcion ci
  where  c.curso_id = ci.curso_id
  and i.inscripcion_id = ci.inscripcion_id
  and c.curso_id = cursoID;

  select nombre into alu
  from estudiante 
  where estudiante_id = alu_id;


  IF INSERTING THEN
    modifica:= 'I';
  ELSIF UPDATING THEN
    modifica:='U';
  ELSE 
   modifica:='D';
  END IF;
  momento:= TO_CHAR(SYSDATE, '"DAY", "DD" de "MONTH" DEL "YYYY"');
  INSERT INTO bitacoraCalif(fecha, modificacion, usuario, alumno,
              calificacion_nueva, calificacion_vieja)
  values (momento, modifica, USER, alu, new_calif, old_calif);
  DBMS_OUTPUT.PUT_LINE('Modificacion Almacenada:' || momento);
  END;
/
show errors