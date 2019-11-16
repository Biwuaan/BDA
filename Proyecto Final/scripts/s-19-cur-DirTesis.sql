--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion De indices
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

connect baoc_proy_admin

CREATE TABLE DIRECTORES_TESIS(
	ID 	NUMBER(3,0),
	NOMBRE VARCHAR(100)
);

DECLARE
	vClaveProf	profesor.profesor_id%TYPE;
	vNombre		profesor.nombre%TYPE;
	vApellidoP  profesor.ap_paterno%TYPE;
	vApellidoM  profesor.ap_materno%TYPE;

CURSOR dirTesis
IS
	SELECT profesor_id, nombre, ap_paterno, ap_materno
	from profesor
	where TIPO_PROFESOR = 'C';

BEGIN
open dirTesis;
dbms_output.put_line('Directores para tu tesis');
LOOP
	FETCH dirTesis INTO vClaveProf,vNombre,vApellidoP,vApellidoM;
EXIT WHEN dirTesis%NOTFOUND;
INSERT INTO DIRECTORES_TESIS(ID,NOMBRE) 
	VALUES(vClaveProf, vNombre ||' ' ||vApellidoP ||' '|| vApellidoM);
END LOOP;
CLOSE dirTesis;
END;
/