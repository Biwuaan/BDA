--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion de Usuario
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

Prompt Probando funcion que inserta materias

--select crea_asignatura_fx(10,'probabilidad',10,1101, null,1,1) as id from dual;

select * from asignatura;

select crea_planEstudios_fx(5,105,'Ingenieria Aeroespacial') as id from dual;
select crea_planEstudios_fx(6,105,'Ingenieria Electrica') as id from dual;

select * from PLAN_ESTUDIOS;