--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion De Tablas
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

connect baoc_proy_admin

CREATE OR REPLACE TRIGGER statusTesis
INSTEAD OF DELETE ON V_ESTATUS_TESIS
FOR EACH ROW
BEGIN
	update TESIS set estatus_id = 3
	WHERE TESIS_ID=:OLD.TESIS_ID;
	END statusTesis;
/
show errors