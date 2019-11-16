--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion de Usuario
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

connect baoc_proy_admin

create or replace function crea_asignatura_fx(
	v_asigID number,
	v_nombre varchar2,
	v_creditos number,
	v_clave_plan number,
	v_nombre_asignatura_previa varchar2 default null,
	v_numSemestre number,
	v_clave number
)
return number is
pragma autonomous_transaction;

--declaracion de variables
v_asigPE ASIGNATURA.PLAN_ESTUDIOS_ID%TYPE;
v_asiRe ASIGNATURA.ASIGNATURA_PREVIA%TYPE;

begin

	select plan_estudios_id into v_asigPE 
	from plan_estudios
	where CLAVE = v_clave_plan;

	if v_asiRe is not null then
		select asignatura_id into v_asiRe
		from asignatura
		where lower(nombre) = lower (v_nombre_asignatura_previa);
	else
		v_asiRe := null;
	end if;

--insertando
	insert into asignatura(asignatura_id,asignatura_previa,
			clave, nombre, num_semestre, num_creditos, 
			plan_estudios_id)
	values(v_asigID,v_asiRe,v_clave,v_nombre,v_numSemestre,
			v_creditos, v_asigPE);

commit;

exception
	when others then
		dbms_output.put_line('Error al crear la asignatura');
	--la función termina su propia transacción con rollback
	rollback;
	--Regresa el id asignado, 0 si ocurre un error


return v_asigID;
end;
/
show errors