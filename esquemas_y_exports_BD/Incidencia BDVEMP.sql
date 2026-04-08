--INCIDENCIA SCHEMA BDVEMP A BDVEMPP

--Creación y eliminación de un nuevo esquema:

DROP USER BDVEMPP CASCADE;

CREATE USER BDVEMPP
  IDENTIFIED BY bqsmt7aral8
  DEFAULT TABLESPACE DATA
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
GRANT CONNECT TO BDVEMPP;
GRANT DATAPUMP_EXP_FULL_DATABASE TO BDVEMPP;
GRANT RESOURCE TO BDVEMPP;
ALTER USER BDVEMPP DEFAULT ROLE NONE;
GRANT ADVISOR TO BDVEMPP;
GRANT CREATE ANY INDEX TO BDVEMPP;
GRANT CREATE LIBRARY TO BDVEMPP;
GRANT CREATE MATERIALIZED VIEW TO BDVEMPP;
GRANT CREATE PROCEDURE TO BDVEMPP;
GRANT CREATE PUBLIC DATABASE LINK TO BDVEMPP;
GRANT CREATE PUBLIC SYNONYM TO BDVEMPP;
GRANT CREATE SEQUENCE TO BDVEMPP;
GRANT CREATE SESSION TO BDVEMPP;
GRANT CREATE SYNONYM TO BDVEMPP;
GRANT CREATE TABLE TO BDVEMPP;
GRANT CREATE TRIGGER TO BDVEMPP;
GRANT CREATE TYPE TO BDVEMPP;
GRANT CREATE VIEW TO BDVEMPP;
GRANT DEBUG ANY PROCEDURE TO BDVEMPP;
GRANT DEBUG CONNECT SESSION TO BDVEMPP;
GRANT DROP PUBLIC DATABASE LINK TO BDVEMPP;
GRANT EXECUTE ANY PROCEDURE TO BDVEMPP;
GRANT SELECT ANY SEQUENCE TO BDVEMPP;
GRANT SELECT ANY TABLE TO BDVEMPP;
GRANT UNLIMITED TABLESPACE TO BDVEMPP;
ALTER USER BDVEMPP QUOTA UNLIMITED  ON DATA;
ALTER USER BDVEMPP QUOTA UNLIMITED  ON INDX_BDVEMPD;


--Aparte tambien se crearon los siguientes Tablespace para que hubiera ningun tipo de problema en el import 

CREATE TABLESPACE INDX_BDVEMPD
DATAFILE 
  '+DG_DATA' SIZE 5G AUTOEXTEND ON
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


DROP TABLESPACE DATA_BDVEMPD INCLUDING CONTENTS AND DATAFILES;

CREATE TABLESPACE DATA_BDVEMPD
DATAFILE 
  '+DG_DATA' SIZE 20G AUTOEXTEND ON,
  '+DG_DATA' SIZE 20G AUTOEXTEND ON,
  '+DG_DATA' SIZE 20G AUTOEXTEND ON,
  '+DG_DATA' SIZE 20G AUTOEXTEND ON
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


--Se coloco el string de conexion de BDVEMP en el servidor que contenia el esquema de BDVEMPP
cat $ORACLE_HOME/network/admin/tnsnames.ora



--Crear database link para conectarse 
CREATE PUBLIC DATABASE LINK PRUEBA_2 CONNECT TO SYSTEM IDENTIFIED BY bqsmt7aral8 USING 'BDVEMPD';
/*

CREATE PUBLIC DATABASE LINK PRUEBA_1: Esta parte del comando indica que se está creando un enlace de base de datos llamado PRUEBA_1. Un enlace de base de datos permite que una base de datos Oracle acceda a objetos en otra base de datos Oracle.
USING 'BDVEMPD': Esta parte especifica el nombre del servicio de la base de datos remota a la que se está conectando. BDVEMPD es el identificador de la base de datos (o TNS alias) que se encuentra en el archivo tnsnames.ora, que contiene la información necesaria para establecer la conexión.
*/

--Posterior se procedio a hacer el import con el network link

nohup impdp system/bqsmt7aral8 schemas=BDVEMP directory=IMPORT logfile=EXPDP_BDVEMP_20241111.log network_link=PRUEBA_1 remap_schema=BDVEMP:BDVEMPP REMAP_TABLESPACE=DATA_BDVEMPD:DATA exclude=STATISTICS &

/*
Desglose del Comando

nohup:
Significado: "No hang up". Este comando permite que el proceso continúe ejecutándose incluso después de que el usuario haya cerrado la sesión. Es útil para ejecutar trabajos de larga duración en segundo plano.
Uso: Se coloca al inicio del comando para que el proceso no se detenga al cerrar la terminal.

impdp:
Significado: "Import Data Pump". Es una utilidad de Oracle para importar datos y metadatos desde un archivo de volcado (dump file) a una base de datos.
Uso: Se utiliza para realizar importaciones de esquemas, tablas, etc.

system/bqsmt7aral8:
Significado: Credenciales para conectarse a la base de datos.
system: Nombre de usuario de la base de datos (un usuario con privilegios de administrador).
bqsmt7aral8: Contraseña del usuario system.
Uso: Proporciona la autenticación necesaria para ejecutar el comando.

schemas=BDVEMP:
Especifica que se va a importar el esquema llamado BDVEMP.
Uso: Indica qué esquema se está importando desde el archivo de volcado.

directory=IMPORT
Indica el objeto de directorio de Oracle que contiene los archivos de volcado.
Uso: IMPORT debe ser un directorio previamente definido en la base de datos que apunta a una ubicación del sistema de archivos donde se encuentran los archivos de volcado.

logfile=EXPDP_BDVEMP_20241111.log:
Especifica el nombre del archivo de registro donde se guardará la salida del proceso de importación.
Uso: Permite revisar el progreso y los errores que puedan ocurrir durante la importación. La fecha en el nombre sugiere que se está registrando la operación del 11 de noviembre de 2024.

network_link=PRUEBA_1:
Indica un enlace de red a otra base de datos de Oracle desde donde se importarán los datos.
Uso: Permite realizar la importación directamente desde otra base de datos a través de un enlace de base de datos previamente configurado.

remap_schema=BDVEMP:BDVEMPP:
Permite remapear el esquema importado.
BDVEMP: Esquema de origen en el archivo de volcado.
BDVEMPP: Esquema de destino en la base de datos actual.
Uso: Esto es útil cuando se desea importar datos a un esquema diferente al original.

REMAP_TABLESPACE=DATA_BDVEMPD:DATA:
Permite remapear los tablespaces durante la importación.
DATA_BDVEMPD: Tablespace de origen en el archivo de volcado.
DATA: Tablespace de destino en la base de datos actual.
Uso: Esto es útil si se desea cambiar la ubicación de los datos durante la importación.

exclude=STATISTICS:
Indica que se deben excluir las estadísticas de la importación.
Uso: Esto puede ser útil para evitar la sobrecarga de recalcular estadísticas después de la importación, especialmente si las estadísticas ya están optimizadas en la base de datos de destino.

&:
Este símbolo se utiliza en Linux para ejecutar el comando en segundo plano.
Uso: Permite que el usuario siga utilizando la terminal mientras el proceso de importación se ejecuta.
*/

--homologacion_permisologia
set heading off
set pagesize 0 
set feedback off
set lines 500
set long 2000000
set longchunksize 20000
set verify off
set echo off
set trimspool on
set termout off
set timi off
set time off

spool exec_homologacion_permisologia.sql
select 'spool homologacion_permisologia.lst' from dual;
select 'set timi on ' from dual;
select 'set time on ' from dual;
select ' ' from dual;

 select *
 from (
 select 'grant '||PRIVILEGE||' on '||OWNER||'.'||TABLE_NAME||' to '||GRANTEE||';' 
 from dba_tab_privs@BDVEMPD
 where GRANTEE not IN  ('SYS','SYSTEM','DBA','PUBLIC','PERFSTAT','SELECT_CATALOG_ROLE','OLAPI_TRACE_USER','OLAPSYS','OWF_MGR','XDBADMIN','DMSYS','WMSYS'
 ,'HS_ADMIN_ROLE'
 ,'IMP_FULL_DATABASE'
 ,'AQ_ADMINISTRATOR_ROLE'
 ,'AQ_USER_ROLE'
 ,'EXECUTE_CATALOG_ROLE'
 ,'EXP_FULL_DATABASE'
 ,'EXECUTE_CATALOG_ROLE'
 ,'CTXSYS'
 ,'SI_INFORMTN_SCHEMA'
 ,'TSMSYS'
 ,'XDB'
 ,'OUTLN'
 ,'MDSYS'
 ,'EXFSYS')
 minus
 select 'grant '||PRIVILEGE||' on '||OWNER||'.'||TABLE_NAME||' to '||GRANTEE||';' 
 from dba_tab_privs
 where GRANTEE not IN  ('SYS','SYSTEM','DBA','PUBLIC','PERFSTAT','SELECT_CATALOG_ROLE','OLAPI_TRACE_USER'
 ,'OLAPSYS','OWF_MGR','XDBADMIN','DMSYS','WMSYS'
 ,'HS_ADMIN_ROLE'
 ,'IMP_FULL_DATABASE'
 ,'AQ_ADMINISTRATOR_ROLE'
 ,'AQ_USER_ROLE'
 ,'EXECUTE_CATALOG_ROLE'
 ,'EXP_FULL_DATABASE'
 ,'EXECUTE_CATALOG_ROLE'
 ,'CTXSYS'
 ,'SI_INFORMTN_SCHEMA'
 ,'TSMSYS'
 ,'XDB'
 ,'OUTLN'
 ,'MDSYS'
 ,'EXFSYS')
 );        

 select ' ' from dual;
 select 'spool off ' from dual;

 spool off

 /*
 Este script genera un archivo SQL que contiene comandos GRANT para otorgar privilegios a los usuarios que no están en la lista de exclusión, lo que permite gestionar de manera eficiente los permisos en la base de datos.
 */


--Esto es lo que se genera 
grant EXECUTE on SYS.DBMS_CRYPTO to BDVEMPP;
grant EXECUTE on SYS.DBMS_DATAPUMP to BDVEMPP;
grant EXECUTE on SYS.DBMS_JOB to SEGURIDAD_INFORMATICA;
grant EXECUTE on SYS.DBMS_TRANSACTION to SEGURIDAD_INFORMATICA;
grant READ on SYS.EXPORT to BDVEMPP;
grant SELECT on SYS.DBA_DIRECTORIES to BDVEMPP;
grant SELECT on SYS.DBA_TAB_PARTITIONS to BDVEMPP;
grant SELECT on SYS.DBA_TAB_SUBPARTITIONS to BDVEMPP;
grant WRITE on SYS.EXPORT to BDVEMPP;


--Posterior se crearon los Triggers faltantes, lo que se hizo fue consultar el toad en el ambiente de desarrollo y se hizo un cambio en el nombre del esquema, es decir de BDVEMP a BDVEMPP.

CREATE OR REPLACE TRIGGER BDVEMPP.REGCHEQ_TRI 
BEFORE INSERT ON BDVEMPP.REGCHEQARCHIVOS 
FOR EACH ROW
BEGIN
  SELECT REGCHEQARCHIVOS_SEQ.NEXTVAL
  INTO   :new.NUMREGISTRO
  FROM   dual;
END;
/

CREATE OR REPLACE TRIGGER BDVEMPP.LOG_OPERACIONES_AI
before insert ON BDVEMPP.LOG_OPERACIONES
    for each row
DISABLE
begin
            select log_seq.nextval
            into :new.id
            from dual;
        end;
/


CREATE OR REPLACE TRIGGER BDVEMPP.RINO_LOGOPERACIONESAI
before insert ON BDVEMPP.LOG_OPERACIONES
    for each row
begin
            select RINOLOGOPERACIONES_SEQ.nextval
            into :new.id
            from dual;
        end;
/

CREATE OR REPLACE TRIGGER BDVEMPP.PLSQL_ERRORLOG_TR
  BEFORE INSERT ON "BDVEMPP"."PLSQL_ERRORLOG"
  FOR EACH ROW
DECLARE
  v_code NUMBER(10);
BEGIN
  SELECT PLSQL_ERRORLOG_SQ.NEXTVAL INTO v_code FROM DUAL;
  :NEW.ID := v_code;
END;
/

CREATE OR REPLACE TRIGGER BDVEMPP.INSERT_NOTIF
BEFORE INSERT ON BDVEMPP.NOTIFICACIONES
FOR EACH ROW
DECLARE
ID_NOTIFN NUMBER(8);
ID_NOTIFD VARCHAR2(8);

BEGIN
SELECT BDVEMPP.SEQ_NOTIFICACIONES.NEXTVAL INTO ID_NOTIFN FROM DUAL;
ID_NOTIFD := TRIM(TO_CHAR(ID_NOTIFN,'00000000'));
SELECT ID_NOTIFD INTO :NEW.ID_NOTIFICACION FROM DUAL;
END;
/


CREATE OR REPLACE TRIGGER BDVEMPP.token_semillasAI
before insert ON BDVEMPP.TOKEN_SEMILLAS
    for each row
begin
            select token_semillas_seq.nextval
            into :new.id
            from dual;
        end;
/

--Despues se procedio a ejecutar el archivo en sql con @ddl_procedures_full_88.sql, el contenido de este archivo es bastante extenso por lo tanto no se encuentra aqui
--Hubo errores 
ALTER PROCEDURE BDVEMPP.MIGRAR_TRANSACCIONES_FIDE COMPILE;



--Visualizar cuantos indices, constrains, tables, procedures, objects, synonyms, sequences
set line 400
SELECT 
    (SELECT COUNT(1) FROM dba_indexes 		where owner = 'BDVEMPP') AS total_indices,
    (SELECT COUNT(1) FROM dba_constraints 	where owner = 'BDVEMPP') AS total_constraints,
    (SELECT COUNT(1) FROM dba_tables 		where owner = 'BDVEMPP') AS total_tables,
    (SELECT COUNT(1) FROM dba_procedures	where owner = 'BDVEMPP') AS total_procedures,
    (SELECT COUNT(1) FROM dba_objects 		where owner = 'BDVEMPP' AND object_type = 'PACKAGE') AS total_packages,
    (SELECT COUNT(1) FROM dba_objects 		where owner = 'BDVEMPP' and object_type = 'PACKAGE BODY') AS total_package_bodies,
    (SELECT COUNT(1) FROM dba_synonyms 		where owner = 'BDVEMPP') AS total_synonyms,
    (SELECT COUNT(1) FROM dba_sequences 	where SEQUENCE_OWNER = 'BDVEMPP') AS total_sequences
FROM dual;



------------------------------------------------------------------------------------------------------
SET LONG 200000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 10000000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON

BEGIN
  DBMS_METADATA.set_transform_param(DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
  DBMS_METADATA.set_transform_param(DBMS_METADATA.session_transform, 'PRETTY', true);
END;
/
spool ddl_procedures_full_88.sql;

/*
Este script SQL está diseñado para generar un archivo que contenga las definiciones completas (DDL) de todos los procedimientos almacenados en una base de datos Oracle. Este archivo DDL puede ser muy útil para diversas tareas, como:

Migración de esquema: Recrear el esquema en otra base de datos.
Respaldo del esquema: Crear una copia de seguridad de las definiciones de los procedimientos.
Análisis del esquema: Estudiar la estructura y dependencias de los procedimientos.
Cambios en el esquema: Modificar las definiciones de los procedimientos editando el archivo DDL generado.
Cómo funciona:

Configuración del entorno:
Se establecen varios parámetros para optimizar la generación del DDL:
LONG: Aumenta el tamaño máximo de los datos que se pueden procesar, permitiendo manejar definiciones de procedimientos largas.
LONGCHUNKSIZE: Define el tamaño de los fragmentos para objetos grandes (LOBs), mejorando el rendimiento.
PAGESIZE, LINESIZE, FEEDBACK, VERIFY, TRIMSPOOL: Estos parámetros ajustan la forma en que se muestra y guarda la salida, optimizando el formato y la legibilidad del archivo resultante.
Obtención de metadatos:
Se utiliza el paquete DBMS_METADATA para extraer la información de metadatos de los procedimientos almacenados. Este paquete proporciona una interfaz para acceder a la estructura de los objetos de la base de datos.
Los parámetros SQLTERMINATOR y PRETTY se configuran para asegurar que las sentencias SQL estén correctamente terminadas y que el formato del DDL sea legible.
Generación del archivo DDL:
La instrucción spool ddl_procedures_full_88.sql inicia el proceso de guardar la salida en un archivo llamado ddl_procedures_full_88.sql. Este archivo contendrá las definiciones DDL de todos los procedimientos, una por línea.
*/
------------------------------------------------------------------------------------------------------
 


 SELECT *
FROM (
	SELECT OBJECT_NAME
	FROM DBA_OBJECTS 
	WHERE OWNER='BDVEMPP'
	AND OBJECT_TYPE='PROCEDURE' 
	AND STATUS = 'INVALID'
		MINUS 
	SELECT OBJECT_NAME
	FROM DBA_OBJECTS@BDVEMPD
	WHERE OWNER='BDVEMP'
	AND OBJECT_TYPE='PROCEDURE' 
	AND STATUS = 'INVALID'
);

/*

Subconsulta 1:
SELECT OBJECT_NAME FROM DBA_OBJECTS WHERE OWNER='BDVEMPP' AND OBJECT_TYPE='PROCEDURE' AND STATUS = 'INVALID': Esta subconsulta busca todos los procedimientos inválidos del propietario BDVEMPP en la base de datos actual.

Subconsulta 2:
SELECT OBJECT_NAME FROM DBA_OBJECTS@BDVEMPD WHERE OWNER='BDVEMP' AND OBJECT_TYPE='PROCEDURE' AND STATUS = 'INVALID': Esta subconsulta busca todos los procedimientos inválidos del propietario BDVEMP en la base de datos de referencia BDVEMPD.

Operador MINUS:
El operador MINUS se utiliza para encontrar las diferencias entre los resultados de las dos subconsultas. En este caso, se busca identificar los procedimientos inválidos en la base de datos actual que no existen en la base de datos de referencia.

Consulta Principal:
SELECT * FROM (...): Esta consulta externa selecciona todos los campos (*) de los resultados de la operación MINUS. Esto significa que se seleccionarán los nombres de los procedimientos inválidos que están presentes en la base de datos actual pero no en la base de datos de referencia.

*/


scp -p ddl_procedures_full_ORIGEN.sql oracle11@sun2209q.banvenqa.com:/export/home/oracle11
