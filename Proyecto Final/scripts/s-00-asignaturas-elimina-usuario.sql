--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion De Tablas
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado


set serveroutput on
declare
v_count number(1,0);
begin
select count(*) into v_count
from dba_users
where username ='baoc_proy_admin';
if v_count > 0 then
	execute immediate 'drop user baoc_proy_admin cascade';
end if;
end;
/

set serveroutput on
declare
v_count number(1,0);
begin
select count(*) into v_count
from dba_users
where username ='baoc_proy_invitado';
if v_count > 0 then
	execute immediate 'drop user baoc_proy_invitado cascade';
end if;
end;
/