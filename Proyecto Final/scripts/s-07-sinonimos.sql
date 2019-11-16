--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion De indices
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

Prompt Otorgando permisos a baoc_proy_invitado para leer tablas
Prompt de baoc_proy_admin

prompt conectando a usuario baoc_proy_admin
connect baoc_proy_admin 

grant select on baoc_proy_admin.asignatura to baoc_proy_invitado;
grant select on baoc_proy_admin.curso to baoc_proy_invitado;
grant select on baoc_proy_admin.clase to baoc_proy_invitado;
grant select on baoc_proy_admin.semestre to baoc_proy_invitado;
grant select on baoc_proy_admin.profesor to baoc_proy_invitado;

Prompt Creando sinonimos
Prompt conectandose con el usuario baoc_proy_invitado
connect baoc_proy_invitado

create or replace synonym asignatura for baoc_proy_admin.asignatura;
create or replace synonym curso for baoc_proy_admin.curso;
create or replace synonym clase for baoc_proy_admin.clase;
create or replace synonym semestre for baoc_proy_admin.semestre;
create or replace synonym profesor for baoc_proy_admin.profesor;