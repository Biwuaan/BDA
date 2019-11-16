--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion de Usuario
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

Prompt secuendias de busqueda
connect baoc_proy_admin

--Muestra estudiantes, tesis y su director de tesis
select t.nombre, et.clave, e.nombre, e.num_cuenta, p.nombre, p.RFC
	from tesis t
	join estudiante e
		on t.tesis_id = e.tesis_id
	join estatus et
		on et.estatus_id = t.estatus_id
	join PROFESOR_CARRERA pc
		on pc.profesor_id = t.director_id
	join profesor p
		on p.profesor_id = pc.profesor_id;

--Muestra asignaturas necesarias
select a.nombre as "Asignatura" , a.clave, a.num_semestre,
       ap.nombre as "Asignatura Previa", ap.clave, ap.num_semestre
	from asignatura a, asignatura ap
	where a.asignatura_previa = ap.asignatura_id;

--Muestra la historia de los planes de estudio
select p.clave, p.NOMBRE_P as "Viejo Plan", p.fecha_aprobacion, p.fecha_termino,
       ps.clave, ps.NOMBRE_P as "Nuevo Plan", ps.fecha_aprobacion
    from plan_estudios p, plan_estudios ps
    where p.plan_sustituto_id = ps.plan_estudios_id;

--muestra estudiante con el estatus de su tesis
select e.nombre, e.ap_paterno, e.ap_materno, e.num_cuenta,
	   t.nombre, et.clave
	from estudiante e
	left join tesis t
		on t.tesis_id = e.tesis_id
	join ESTATUS et
		on et.ESTATUS_ID = t.estatus_id;

--Estudiantes titulados
select e.nombre, e.ap_paterno, e.ap_materno, e.num_cuenta,
	   t.nombre, et.clave
	from estudiante e
	join tesis t
		on t.tesis_id = e.tesis_id
	join estatus et
		on et.ESTATUS_ID = t.estatus_id
	where et.clave = 'APROVADA';

--Mayores calificaciones de las materias
select e.nombre, e.ap_paterno, e.ap_materno, a.nombre,
	   c.CALIFICACION
	from estudiante e, inscripcion i, curso_inscripcion ci,
		 asignatura a, CURSO c
	where e.estudiante_id = i.estudiante_id
	and i.inscripcion_id = ci.inscripcion_id
	and c.curso_id = ci.curso_id
	and a.asignatura_id = c.asignatura_id
	and c.CALIFICACION = (
		select max(c2.CALIFICACION)
		from CURSO c2, curso_inscripcion ci2, inscripcion i2
		where c2.curso_id = ci2.curso_id
		and i2.inscripcion_id = ci2.inscripcion_id
		and c2.asignatura_id = c.asignatura_id
		and i2.estudiante_id = i.estudiante_id
	);