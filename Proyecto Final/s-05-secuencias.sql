--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion De secuencias
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

prompt creando secuencias
prompt conectando usuario baoc_proy_admin
connect baoc_proy_admin

CREATE SEQUENCE ESTUDIANTE_SEQ
    START WITH 6
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 50;

CREATE SEQUENCE PROFESOR_SEQ
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 50;

CREATE SEQUENCE CURSO_SEQ
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 50;

CREATE SEQUENCE INSCRIPCION_SEQ
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 50;

CREATE SEQUENCE HIS_GE_SEQ
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    CACHE 50;
