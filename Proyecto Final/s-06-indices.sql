--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion De indices
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

prompt creando indices
prompt conectando usuario baoc_proy_admin
connect baoc_proy_admin
 
--INDICES TIPO UNIQUE--


create unique index carrera_ix
    on carrera(clave);

--INDICE NON UNIQUE--

 create index profesor_ix
  on profesor(tipo_profesor,nombre);

create index puesto_ix
   on puesto(nombre,sueldo);


--INDICE COMPUESTO
 create unique index profesor_uk
    on profesor(RFC, nombre);

create index estudiante_uk
    on estudiante(num_cuenta, nombre);


--INDICE BASADO EN FUNCION LOWER--
create index estudiante_nombre_ix
    on estudiante(lower(nombre));

create index profesor_nombre_ix
    on profesor(lower(nombre));

