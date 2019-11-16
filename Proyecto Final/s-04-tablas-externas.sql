--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion De Tablas
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado
prompt Conectando usuario sys
connect sys as sysdba

prompt creando directorio tmp_dir
create or replace directory tmp_dir as '/tmp/bases';

grant read, write on directory tmp_dir to baoc_proy_admin

prompt conectando como usuario Admin
connect baoc_proy_admin
show user
prompt creando tabla externa

create table departamentales_ext(
	nombre		varchar(30),
	fecha       date
)
organization external (
	type oracle loader
	default directory tmp_dir
	access parameters(
		records delmited by newline
		badfile tmp_dir:'empleado_ext_bad.log'
		logfile tmp_dir:'empleado_ext.log'
		fields terminated by '#'
		lrtrim
		missing field values are null(
			nombre, fecha date mask "dd/mm/yyyy"
		)
	) location ('departamentales_ext.csv')
) reject limit unlimited;

prompt creando el directorio tmp en caso de no existir
!mkdir -p /tmp/bases
prompt cambiando permisos
!chmod 777 /tmp/bases

prompt copiando archivo csv a tmp
!cp departamentales_ext.csv /tmp/bases

col nombre format a30
col fecha format a15
select * from departamentales_ext