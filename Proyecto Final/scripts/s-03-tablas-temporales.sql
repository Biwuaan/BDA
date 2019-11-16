--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion De Tablas temporales
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

Prompt conectando como usuario baoc_proy_invitado
connect baoc_proy_invitado
Prompt creando objetos uno temporal 

create global temporary table datos_sesion(
	usuario 	varchar(30),
	contrasena	varchar(30)
)on commit delete rows;
insert into datos_sesion values('baoc_proy_invitado', 'invitado');

select usuario, contrasena from datos_sesion; 

