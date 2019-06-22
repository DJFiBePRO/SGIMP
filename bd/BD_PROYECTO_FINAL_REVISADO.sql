﻿CREATE DATABASE BD_PROYECTO;
use BD_PROYECTO;
/*--CREAR TABLA "ROLES" */
CREATE TABLE ROLES(
CODIGO_ROL VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_ROL)=6),
NOMBRE_ROL INTEGER,
PRIMARY KEY(CODIGO_ROL)
);

/*--CREAR TABLA "PERSONA"*/ 
CREATE TABLE PERSONA(
CEDULA VARCHAR (10) NOT NULL CHECK(CEDULA LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'), 
CODIGO_ROL VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_ROL)=6),
CONTRASEÑA VARCHAR (30) NOT NULL, 
NOMBRE VARCHAR (40) NOT NULL,
APELLIDO VARCHAR (40) NOT NULL,
EMAIL VARCHAR (30) NOT NULL,
TELEFONO INTEGER NOT NULL CHECK(LEN(TELEFONO)=10 OR LEN(TELEFONO)=7 ),
DIRECCION VARCHAR (30) NOT NULL,
FOREIGN KEY (CODIGO_ROL) REFERENCES ROLES(CODIGO_ROL) on update cascade on delete cascade,
PRIMARY KEY(CEDULA)
);


/*--CREAR TABLA "COORDINADOR_GENERAL" */
CREATE TABLE COORDINADOR_GENERAL(
CEDULA VARCHAR (10) NOT NULL CHECK(CEDULA LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'),
NUM_DOCENTES INTEGER,
NUM_ESTUDIANTES INTEGER,
CARGA_HORARIA INTEGER,  
FOREIGN KEY (CEDULA) REFERENCES PERSONA(CEDULA)on update cascade on delete cascade,
PRIMARY KEY(CEDULA)
);

/*--CREAR TABLA "COORDINADOR_FACULTAD" */
CREATE TABLE COORDINADOR_FACULTAD(
CEDULA VARCHAR (10) NOT NULL CHECK (CEDULA LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'),
CARGA_HORARIA INTEGER,  
FOREIGN KEY (CEDULA) REFERENCES PERSONA(CEDULA)on update cascade on delete cascade,
PRIMARY KEY(CEDULA)
);
/*--CREAR TABLA "COORDINADOR_CARRERA" */
CREATE TABLE COORDINADOR_CARRERA(
CEDULA VARCHAR (10) NOT NULL CHECK(CEDULA LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'),
CARGA_HORARIA INTEGER,  
FOREIGN KEY (CEDULA) REFERENCES PERSONA(CEDULA)on update cascade on delete cascade,
PRIMARY KEY(CEDULA)
);

/*--CREAR TABLA "FACULTAD"*/ 
CREATE TABLE FACULTAD(
CODIGO_FACULTAD VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_FACULTAD)=6),
NOMBRE_FACULTAD VARCHAR (30) NOT NULL,
PRIMARY KEY(CODIGO_FACULTAD)
);

/*CREAR TABLA "CARRERA"*/ 
CREATE TABLE CARRERA(
CODIGO_CARRERA VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_CARRERA)=6),
CODIGO_FACULTAD VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_FACULTAD)=6),
NOMBRE_CARRERA VARCHAR (30) NOT NULL,
FOREIGN KEY (CODIGO_FACULTAD) REFERENCES FACULTAD(CODIGO_FACULTAD)on update cascade on delete cascade,
PRIMARY KEY(CODIGO_CARRERA)
);


/*--CREAR TABLA "DOCENTE" */
CREATE TABLE DOCENTE(
CEDULA VARCHAR (10) NOT NULL CHECK(CEDULA LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'),
CODIGO_CARRERA VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_CARRERA)=6),
CARGA_HORARIA INTEGER,  
ESPECIALIDAD VARCHAR (30) NOT NULL,
FOREIGN KEY (CEDULA) REFERENCES PERSONA(CEDULA)on update cascade on delete cascade,
FOREIGN KEY (CODIGO_CARRERA) REFERENCES CARRERA(CODIGO_CARRERA)on update cascade on delete cascade,
PRIMARY KEY(CEDULA)
);


/*--CREAR TABLA "ESTUDIANTE" */
CREATE TABLE ESTUDIANTE(
CEDULA VARCHAR (10) NOT NULL CHECK(CEDULA LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'),
CODIGO_CARRERA VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_CARRERA)=6),
CARGA_HORARIA INTEGER,  
FOREIGN KEY (CEDULA) REFERENCES PERSONA(CEDULA)on update cascade on delete cascade,
FOREIGN KEY (CODIGO_CARRERA) REFERENCES CARRERA(CODIGO_CARRERA)on update cascade on delete cascade,
PRIMARY KEY(CEDULA)
);

/*--CREAR TABLA "EMPRESA" */
CREATE TABLE EMPRESA(
CODIGO_EMPRESA VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_EMPRESA)=6),
NOMBRE_EMPRESA VARCHAR (30) NOT NULL,
EMAIL_EMPRESA VARCHAR (30) NOT NULL,
PAG_WEP_EMPRESA VARCHAR (30) NOT NULL,
DIRECCION_EMPRESA VARCHAR (30) NOT NULL,
DESCRIPCION_EMPRESA VARCHAR (30) NOT NULL,
PRIMARY KEY(CODIGO_EMPRESA)
);


/*--CREAR TABLA "REPRESENTANTE_EMPRESA" */
CREATE TABLE REPRESENTANTE_EMPRESA(
CEDULA VARCHAR (10) NOT NULL CHECK(CEDULA LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'), 
CODIGO_EMPRESA VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_EMPRESA)=6),
CARGO VARCHAR (30)  NOT NULL,
FOREIGN KEY (CEDULA) REFERENCES PERSONA(CEDULA)on update cascade on delete cascade,
FOREIGN KEY (CODIGO_EMPRESA) REFERENCES EMPRESA(CODIGO_EMPRESA)on update cascade on delete cascade,
PRIMARY KEY(CEDULA)
);

CREATE TABLE ESTADO (
CODIGO_ESTADO VARCHAR (6) NOT NULL CHECK (LEN(CODIGO_ESTADO)=6),
NOMBRE_ESTADO VARCHAR (30) NOT NULL,
DESCRIPCION VARCHAR (30) NOT NULL,
PRIMARY KEY (CODIGO_ESTADO)
);

/*--CREAR TABLA PROYECTO*/
CREATE TABLE PROYECTO(
CODIGO_PROYECTO VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_PROYECTO)=6),
CEDULA VARCHAR (10) NOT NULL CHECK(CEDULA LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'), 
PLANIFICACION VARCHAR (50) NOT NULL,
NOMBRE_PROYECTO VARCHAR (50) NOT NULL,
DESCRIPCION VARCHAR (100) NULL,
CODIGO_ESTADO VARCHAR (6) NOT NULL CHECK (LEN(CODIGO_ESTADO)=6),
PRESUPUESTO FLOAT CHECK(PRESUPUESTO >0),
FECHA_INICIO DATE NOT NULL,
FECHA_FINAL DATE NOT NULL,
LOCALIZACION VARCHAR (50) NULL,
BENEFICIARIOS VARCHAR (50) NULL,
OBJETIVO_GENERAL VARCHAR (50) NULL,
PRIMARY KEY (CODIGO_PROYECTO),
FOREIGN KEY (CEDULA) REFERENCES COORDINADOR_GENERAL(CEDULA)on update cascade on delete cascade,
FOREIGN KEY (CODIGO_ESTADO) REFERENCES ESTADO (CODIGO_ESTADO)on update cascade on delete cascade /*trigger en esta tabla*/
);

/*--CREAR TABLA SUBPROYECTO*/
CREATE TABLE SUBPROYECTO(
CODIGO_SUBPROYECTO VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_SUBPROYECTO)=6),
CODIGO_PROYECTO VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_PROYECTO)=6),
FECHA_INICIO DATE NOT NULL,
FECHA_FINAL DATE NOT NULL,
AVANCE_GENERAL INTEGER NOT NULL,
FOREIGN KEY (CODIGO_PROYECTO) REFERENCES PROYECTO (CODIGO_PROYECTO)on update cascade on delete cascade, 
PRIMARY KEY (CODIGO_SUBPROYECTO)
);
CREATE TABLE ESTADO_COMPONENTE (
CODIGO_ESTADO VARCHAR (6) NOT NULL CHECK (LEN(CODIGO_ESTADO)=6),
NOMBRE_ESTADO VARCHAR (30) NOT NULL,
DESCRIPCION VARCHAR (30) NOT NULL,
PRIMARY KEY (CODIGO_ESTADO),
FOREIGN KEY (CODIGO_ESTADO) REFERENCES ESTADO (CODIGO_ESTADO)on update cascade on delete cascade
);
/*--CREAR TABLA "COMPONENTE"*/ 
CREATE TABLE COMPONENTE(
CODIGO_COMPONENTE VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_COMPONENTE)=6),
CODIGO_SUBPROYECTO VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_SUBPROYECTO)=6),
NOMBRE_COMPONENTE VARCHAR (30) NOT NULL,
FECHA_INICIO DATE NOT NULL,
FECHA_FINAL DATE NOT NULL,
DESCRIPCION VARCHAR (30) NOT NULL,
FOREIGN KEY (CODIGO_SUBPROYECTO) REFERENCES SUBPROYECTO (CODIGO_SUBPROYECTO)on update cascade on delete cascade,
PRIMARY KEY(CODIGO_COMPONENTE)
);


/*0--CREAR TABLA "ACTIVIDAD"*/ 
CREATE TABLE ACTIVIDAD(
CODIGO_ACTIVIDAD VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_ACTIVIDAD)=6),
CODIGO_COMPONENTE VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_COMPONENTE)=6),
CEDULA_DOC VARCHAR (10) NOT NULL CHECK(CEDULA_DOC LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'),
CEDULA_EST VARCHAR (10) NOT NULL CHECK(CEDULA_EST LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'),
NOMBRE_ACTIVIDAD VARCHAR (30) NOT NULL,
NUM_DOCENTES INTEGER,
NUM_ESTUDIANTES INTEGER,
OBSERVACIONES VARCHAR (30) NOT NULL,
FOREIGN KEY (CODIGO_COMPONENTE) REFERENCES COMPONENTE(CODIGO_COMPONENTE)on update cascade on delete cascade,
FOREIGN KEY (CEDULA_DOC) REFERENCES DOCENTE(CEDULA)on update cascade on delete cascade,
FOREIGN KEY (CEDULA_EST) REFERENCES ESTUDIANTE(CEDULA)on update cascade on delete cascade,
PRIMARY KEY(CODIGO_ACTIVIDAD)
);

CREATE TABLE 



CREATE TABLE OBJETIVOS_ESPECIFICOS(
CODIGO_OBJETIVO VARCHAR (30) NOT NULL CHECK(LEN(CODIGO_OBJETIVO)=6),
CODIGO_PROYECTO VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_PROYECTO)=6),
NOMBRE_OBJETIVO VARCHAR (50) NOT NULL,
FOREIGN KEY (CODIGO_PROYECTO) REFERENCES PROYECTO(CODIGO_PROYECTO)on update cascade on delete cascade, 
PRIMARY KEY (CODIGO_OBJETIVO)
);


/*--CREAR TABLA "REPRESENTANTE_EMPRESA" */
CREATE TABLE REPRESENTANTE_EMPRESA(
CEDULA VARCHAR (10) NOT NULL CHECK(CEDULA LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'),
CODIGO_PROYECTO VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_PROYECTO)=6),
CODIGO_EMPRESA VARCHAR (6) NOT NULL CHECK(LEN(CODIGO_EMPRESA)=6),
CARGO VARCHAR (30) NOT NULL,
FOREIGN KEY (CODIGO_PROYECTO) REFERENCES PROYECTO(CODIGO_PROYECTO)on update cascade on delete cascade,
FOREIGN KEY (CODIGO_EMPRESA) REFERENCES EMPRESA(CODIGO_EMPRESA)on update cascade on delete cascade,
PRIMARY KEY(CEDULA)
);


