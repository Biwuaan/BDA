--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion de Usuario
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

prompt Proporcionar el password del usuario sys:

connect  sys as sysdba

---------------------------------------------
prompt creando usuario baoc_proy_admin

create user baoc_proy_admin identified by oscar 
	quota unlimited on users;
---------------------------------------------

Prompt creando usuario baoc_proy_invitado

create user baoc_proy_invitado identified by invitado;
---------------------------------------------
prompt Creando Roles

create role roles_admin;
create role roles_invitado;

grant create table, create session, create view, create synonym,
	create sequence, create trigger, create procedure to roles_admin;

grant create session, create synonym, create table to roles_invitado;
-----------------------------------------------
prompt Asignado roles

grant roles_admin to baoc_proy_admin;
grant roles_invitado to baoc_proy_invitado;

commit;