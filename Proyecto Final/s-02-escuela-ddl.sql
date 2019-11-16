--@Autor: Berdejo Arvizu Oscar || Olmos Cruz Edwin
--@Fecha creación: 25/10/2018
--@Descripción: Creacion De Tablas
--Usuario Admin: baoc_proy_admin
--Usuario Invitado: baoc_proy_invitado

Prompt conectando como usuario baoc_proy_admin
connect baoc_proy_admin
Prompt creando objetos 
--1
CREATE TABLE CARRERA(
	CARRERA_ID			NUMBER(5,0)		NOT NULL,
	NOMBRE				VARCHAR2(10)	NOT NULL,
	CLAVE 				VARCHAR2(10)	NOT NULL,
	DESCRIPCION			VARCHAR2(100)	NOT NULL,
	CONSTRAINT	CARRERA_PK	PRIMARY KEY (CARRERA_ID)
);

CREATE TABLE PLAN_ESTUDIOS(
	PLAN_ESTUDIOS_ID	NUMBER(5,0)		NOT NULL,
	CLAVE				NUMBER(5,0)		NOT NULL,
	NOMBRE_P			VARCHAR2(15)	NOT NULL,
	FECHA_APROBACION	DATE			NOT NULL,
	FECHA_TERMINO		DATE,
	PLAN_SUSTITUTO_ID	NUMBER(5,0),
	CONSTRAINT 	PE_PK	PRIMARY KEY (PLAN_ESTUDIOS_ID),
	CONSTRAINT 	PLAN_SUSTITUTO_FK	FOREIGN KEY (PLAN_SUSTITUTO_ID)
	REFERENCES  PLAN_ESTUDIOS(PLAN_ESTUDIOS_ID),
	CONSTRAINT 	PE_CLAVE_UK	UNIQUE(CLAVE)
);

CREATE TABLE ESTATUS(
	ESTATUS_ID			NUMBER(2,0)		NOT NULL,
	CLAVE 				VARCHAR(15)		NOT NULL,
	DESCRIPCION 		VARCHAR(100)	NOT NULL,
	CONSTRAINT ESTATUS_PK PRIMARY KEY (ESTATUS_ID)
);

CREATE TABLE PROFESOR(
	PROFESOR_ID			NUMBER(3,0)		NOT NULL,
	NOMBRE				VARCHAR2(30)	NOT NULL,
	AP_PATERNO			VARCHAR2(30)	NOT NULL,
	AP_MATERNO			VARCHAR2(30)	NOT NULL,
	RFC 				VARCHAR2(30)	NOT NULL,
	NUM_CEDULA			VARCHAR2(30)	NOT NULL,
	TIPO_PROFESOR		VARCHAR2(1)		NOT NULL,
	CONSTRAINT	PROFESOR_PK PRIMARY KEY (PROFESOR_ID)		
);

CREATE TABLE GRADO_ESTUDIOS(
	GRADO_ESTUDIOS_ID 	NUMBER(10,0)	NOT NULL,
	DESCRIPCION			VARCHAR(100)	NOT NULL,
	CONSTRAINT GE_PK PRIMARY KEY (GRADO_ESTUDIOS_ID)
);

CREATE TABLE PROFESOR_CARRERA(
	PROFESOR_ID			NUMBER(3,0)		NOT NULL,
	GRADO_MAX_ES_ID 	NUMBER(10,0)	NOT NULL,
	CONSTRAINT PC_PK PRIMARY KEY (PROFESOR_ID),
	CONSTRAINT PC_PROFESOR_FK FOREIGN KEY (PROFESOR_ID)
	REFERENCES PROFESOR (PROFESOR_ID),
	CONSTRAINT PC_GM_FK FOREIGN KEY (GRADO_MAX_ES_ID)
	REFERENCES GRADO_ESTUDIOS(GRADO_ESTUDIOS_ID)
);

CREATE TABLE TESIS(
	TESIS_ID			NUMBER(10,0)	NOT NULL,
	NOMBRE				VARCHAR2(50)	NOT NULL,
	FECHA 				DATE 			NOT NULL,
	OBJETIVO			VARCHAR2(100)	NOT NULL,
	ESTATUS_ID			NUMBER(2,0)		NOT NULL,
	DIRECTOR_ID			NUMBER(3,0),
	CONSTRAINT TESIS_PK PRIMARY KEY (TESIS_ID),
	CONSTRAINT TESIS_DIRECTOR_FK FOREIGN KEY (DIRECTOR_ID)
	REFERENCES PROFESOR_CARRERA(PROFESOR_ID),
	CONSTRAINT TESIS_ESTATUS_PK FOREIGN KEY (ESTATUS_ID)
	REFERENCES ESTATUS(ESTATUS_ID)
);

CREATE TABLE ESTUDIANTE(
	ESTUDIANTE_ID		NUMBER(10,0)	NOT NULL,
	NUM_CUENTA 			NUMBER(10,0)	NOT NULL,
	NOMBRE 				VARCHAR2(30)	NOT NULL,
	AP_PATERNO			VARCHAR2(30)	NOT NULL,
	AP_MATERNO			VARCHAR2(30)	NOT NULL,
	CARRERA_ID			NUMBER(5,0)		NOT NULL,
	PLAN_ESTUDIOS_ID	NUMBER(5,0)		NOT NULL,
	TESIS_ID			NUMBER(10,0),
	CONSTRAINT 	ESTUDIANTE_PK PRIMARY KEY (ESTUDIANTE_ID),
	CONSTRAINT 	ESTUDIANTE_CARRERA_FK FOREIGN KEY (CARRERA_ID)
	REFERENCES	CARRERA(CARRERA_ID),
	CONSTRAINT 	ESTUDIANTE_PE_FK FOREIGN KEY (PLAN_ESTUDIOS_ID)
	REFERENCES PLAN_ESTUDIOS(PLAN_ESTUDIOS_ID),
	CONSTRAINT 	ESTUDIANTE_NUM_CUENTA_UK UNIQUE(NUM_CUENTA),
	CONSTRAINT ESTUDIANTE_TESIS_FK FOREIGN KEY (TESIS_ID)
	REFERENCES TESIS (TESIS_ID)
);


CREATE TABLE ASIGNATURA(
	ASIGNATURA_ID		NUMBER(10,0)	NOT NULL,
	ASIGNATURA_PREVIA	NUMBER(10,0),
	CLAVE   			NUMBER(5,0)		NOT NULL,
	NOMBRE				VARCHAR2(15)	NOT NULL,
	NUM_SEMESTRE		NUMBER(2,0)		NOT NULL,
	NUM_CREDITOS		NUMERIC(9,0)	NOT NULL,
	PLAN_ESTUDIOS_ID	NUMBER(5,0)		NOT NULL,
	CONSTRAINT ASIGNATURA_PK PRIMARY KEY (ASIGNATURA_ID),
	CONSTRAINT AS_PREVIA_FK  FOREIGN KEY (ASIGNATURA_PREVIA)
	REFERENCES ASIGNATURA(ASIGNATURA_ID),
	CONSTRAINT AS_CLAVE_UK UNIQUE(CLAVE),
	CONSTRAINT AS_PE_FK FOREIGN KEY (PLAN_ESTUDIOS_ID)
	REFERENCES PLAN_ESTUDIOS (PLAN_ESTUDIOS_ID)	
);
--5
CREATE TABLE CARRERA_ASIGNATURA(
	ASIGNATURA_CARRERA_ID NUMBER(5,0)	NOT NULL,
	CARRERA_ID			NUMBER(5,0)		NOT NULL,
	ASIGNATURA_ID		NUMBER(10,0)	NOT NULL,
	CONSTRAINT	CA_PK 	PRIMARY KEY (ASIGNATURA_CARRERA_ID),
	CONSTRAINT	CA_CARRERA_PK FOREIGN KEY (CARRERA_ID)
	REFERENCES	CARRERA(CARRERA_ID),
	CONSTRAINT 	CA_AS_PK FOREIGN KEY (ASIGNATURA_ID)
	REFERENCES  ASIGNATURA(ASIGNATURA_ID)
);

CREATE TABLE INSCRIPCION(
	INSCRIPCION_ID		NUMBER(5,0)		NOT NULL,
	NUM_INSCRIPCION		NUMBER(10,0)	NOT NULL,
	ESTUDIANTE_ID		NUMBER(10,0)	NOT NULL,
	CONSTRAINT INSCRIPCION_PK PRIMARY KEY (INSCRIPCION_ID),
	CONSTRAINT INSCRIPCION_ESTUDIANTE_FK FOREIGN KEY (ESTUDIANTE_ID)
	REFERENCES ESTUDIANTE(ESTUDIANTE_ID),
	CONSTRAINT INS_NI_UK UNIQUE(NUM_INSCRIPCION)	
);

CREATE TABLE SEMESTRE(
	SEMESTRE_ID 		NUMBER(3,0)		NOT NULL,
	AÑO 				DATE 			NOT NULL,
	PERIODO				VARCHAR2(10)	NOT NULL,
	CONSTRAINT SEMESTRE_PK PRIMARY KEY (SEMESTRE_ID)
);

CREATE TABLE CURSO(
	CURSO_ID			NUMBER(3,0)		NOT NULL,
	GRUPO				VARCHAR2(10)	NOT NULL,
	PROFESOR_ID			NUMBER(5,0)		NOT NULL,
	SEMESTRE_ID			NUMBER(3,0)		NOT NULL,
	ASIGNATURA_ID		NUMBER(10,0)	NOT NULL,
	CALIFICACION		NUMBER(3,1),
	CONSTRAINT CURSO_PK PRIMARY KEY (CURSO_ID),
	CONSTRAINT CURSO_ASIGNATURA_FK FOREIGN KEY (ASIGNATURA_ID)
	REFERENCES ASIGNATURA(ASIGNATURA_ID),
	CONSTRAINT CURSO_SEMESTRE_FK FOREIGN KEY (SEMESTRE_ID)
	REFERENCES SEMESTRE(SEMESTRE_ID),
	CONSTRAINT CURSO_PROFESOR_FK FOREIGN KEY (PROFESOR_ID)
	REFERENCES PROFESOR (PROFESOR_ID)
);

CREATE TABLE CLASE(
	CLASE_ID			NUMBER(5,0)		NOT NULL,
	NUM_CLASE			NUMBER(3,0)		NOT NULL,
	HORA_INICIO			DATE 			NOT NULL,
	HORA_FIN			DATE 			NOT NULL,
	NUM_SALON			NUMBER(2,0)		NOT NULL,
	DIA 				DATE 			NOT NULL,
	CURSO_ID			NUMBER(3,0)		NOT NULL,
	CONSTRAINT CLASE_PK PRIMARY KEY (CURSO_ID),
	CONSTRAINT CLASE_CURSO_FK FOREIGN KEY (CURSO_ID)
	REFERENCES CURSO(CURSO_ID)
);

CREATE TABLE PROFESOR_ASIGNATURA(
	PROFESOR_ID			NUMBER(3,0)		NOT NULL,
	NUM_CONTRATO		NUMBER(10,0)	NOT NULL,
	FECHA_INICIO			DATE    	NOT NULL,
	FECHA_FIN				DATE 		NOT NULL,
	CONSTRAINT PA_PK PRIMARY KEY (PROFESOR_ID),
	CONSTRAINT PA_PROFESOR FOREIGN KEY (PROFESOR_ID)
	REFERENCES PROFESOR(PROFESOR_ID),
	CONSTRAINT PA_NUM_CONTRATO_UK UNIQUE(NUM_CONTRATO)
);

CREATE TABLE PUESTO(
	PUESTO_ID			NUMBER(3,0)		NOT NULL,
	NOMBRE				VARCHAR2(50)	NOT NULL,
	DESCRIPCION			VARCHAR2(100)	NOT NULL,
	SUELDO				NUMBER(20,2)	NOT NULL,
	CONSTRAINT 	PUESTO_PK PRIMARY KEY (PUESTO_ID)
);

CREATE TABLE PROFESOR_ADMINISTRADOR(
	PROFESOR_ID			NUMBER(3,0)		NOT NULL,
	PUESTO_ID			NUMBER(3,0)		NOT NULL,
	CONSTRAINT P_ADMIN_PK PRIMARY KEY (PROFESOR_ID),
	CONSTRAINT P_ADMIN_P FOREIGN KEY (PROFESOR_ID)
	REFERENCES PROFESOR(PROFESOR_ID),
	CONSTRAINT PA_PUESTO_FK FOREIGN KEY (PUESTO_ID)
	REFERENCES PUESTO(PUESTO_ID)
);

CREATE TABLE GRADO_ESTUDIOS_HISTORICO(
	GRADO_ESTUDIOS_HISTORICO_ID NUMBER(5,0) NOT NULL,
	FECHA 				DATE 				NOT NULL,
	PROFESOR_ID 		NUMBER(3,0)			NOT NULL,
	GRADO_ESTUDIOS_ID   NUMBER(10,0)		NOT NULL,
	CONSTRAINT GEH_PK PRIMARY KEY (GRADO_ESTUDIOS_HISTORICO_ID),
	CONSTRAINT GEH_PROFESOR_FK FOREIGN KEY (PROFESOR_ID)
	REFERENCES PROFESOR_CARRERA(PROFESOR_ID),
	CONSTRAINT GEH_GE_FK FOREIGN KEY (GRADO_ESTUDIOS_ID)
	REFERENCES GRADO_ESTUDIOS(GRADO_ESTUDIOS_ID)
);
--17
CREATE TABLE CURSO_INSCRIPCION(
	CURSO_INSCRIPCION_ID NUMBER(10,0)	NOT NULL,
	INSCRIPCION_ID		NUMBER(5,0)		NOT NULL,
	CURSO_ID			NUMBER(3,0)		NOT NULL,
	CONSTRAINT CI_PK PRIMARY KEY (CURSO_INSCRIPCION_ID),
	CONSTRAINT CI_INSCRIPCION_FK FOREIGN KEY (INSCRIPCION_ID)
	REFERENCES INSCRIPCION(INSCRIPCION_ID),
	CONSTRAINT CI_CURSO_FK	FOREIGN KEY (CURSO_ID)
	REFERENCES CURSO(CURSO_ID)
);
CREATE TABLE TESIS_PROFESOR_ASIGNATURA(
	TESIS_PROFESOR_ASIGNATURA_ID  NUMBER(5,0) NOT NULL,
	TESIS_ID 			NUMBER(10,0)	NOT NULL,
	PROFESOR_SINODAL_ID	NUMBER(3,0)		NOT NULL,
	CONSTRAINT TPA_PK PRIMARY KEY (TESIS_PROFESOR_ASIGNATURA_ID),
	CONSTRAINT TPA_TESIS_FK FOREIGN KEY (TESIS_ID)
	REFERENCES TESIS (TESIS_ID),
	CONSTRAINT TPA_SINODAL_FK FOREIGN KEY (PROFESOR_SINODAL_ID)
	REFERENCES PROFESOR_ASIGNATURA(PROFESOR_ID)
);
GRADO_ESTUDIOS