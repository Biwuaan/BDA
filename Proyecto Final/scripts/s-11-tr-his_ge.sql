--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion De Tablas
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

connect baoc_proy_admin
     
CREATE OR REPLACE TRIGGER  hist_grado_trigger
	after insert or update of GRADO_MAX_ES_ID on PROFESOR_CARRERA
	for each row
	DECLARE
	v_status_id NUMBER(10,0);
	v_hist_id NUMBER(5,0);
	v_prof_id NUMBER(3,0);

begin
	select HIS_GE_SEQ.nextval into v_hist_id from dual;

	v_status_id := :new.GRADO_MAX_ES_ID;
	v_prof_id := :new.profesor_id;

	insert into GRADO_ESTUDIOS_HISTORICO 
		(GRADO_ESTUDIOS_HISTORICO_ID,FECHA,PROFESOR_ID,
		 GRADO_ESTUDIOS_ID)
	values (v_hist_id,to_date(sysdate,'DD/MM/YYYY'),v_prof_id,v_status_id);

end;
/
show errors