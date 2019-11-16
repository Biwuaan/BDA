--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion de Usuario
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

connect baoc_proy_admin

create or replace function crea_planEstudios_fx(
	v_plan_estudios_ID number,
	v_clave_plan number,
	v_nombre_plan varchar2,
	v_clave_plan_viejo varchar2 default null
)
return number is
pragma autonomous_transaction;

v_nom_planV plan_estudios.nombre_p%TYPE;
v_pe_viejo plan_estudios.plan_estudios_id%TYPE;

begin
	select nombre_p into v_nom_planV
	from plan_estudios
	where clave = v_clave_plan_viejo;

	select plan_estudios_id into v_pe_viejo
	from plan_estudios
	where clave = v_clave_plan_viejo;


	if v_nom_planV is not null then
		update plan_estudios 
		set fecha_termino = to_date(sysdate,'DD/MM/YYYY'),
		plan_sustituto_id = v_plan_estudios_ID
		where plan_estudios_id = v_pe_viejo;
	else
		v_nom_planV := null;
	end if;

	insert into plan_estudios(PLAN_ESTUDIOS_ID, CLAVE, NOMBRE_P,
				FECHA_APROBACION)
 		values(v_plan_estudios_ID, v_clave_plan, v_nombre_plan,
 				to_date(sysdate,'DD/MM/YYYY'));

commit;

exception
	when others then
		dbms_output.put_line('Error al crear la asignatura');
	--la función termina su propia transacción con rollback
	rollback;
	--Regresa el id asignado, 0 si ocurre un error


return v_plan_estudios_ID;
end;
/
show errors 
