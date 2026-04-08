
--Crear database link para conectarse 
CREATE PUBLIC DATABASE LINK PRUEBA_2 CONNECT TO SYSTEM IDENTIFIED BY bqsmt7aral8 USING 'BDVEMPD';


CREATE PUBLIC DATABASE LINK PRUEBA_3 CONNECT TO SYSTEM IDENTIFIED BY bqsmt7aral8 USING 'INTRNETD.SUN14DZ1';


CREATE PUBLIC DATABASE LINK PRUEBA_3 CONNECT TO SYSTEM IDENTIFIED BY k3r3p4kup41 USING 'RMAN';

CREATE PUBLIC DATABASE LINK PRUEBA_4 CONNECT TO SYSTEM IDENTIFIED BY bqsmt7aral8 USING 'INTRNETD';

nohup impdp system/oracle1 full=Y directory=EXPORT logfile=imp_expo_INTRNETD_full24042025.log network_link=PRUEBA_2 &

nohup impdp system/bqsmt7aral8 \
    directory=EXPORT \
    logfile=imp_expo_INTRNETD_constraints24042025.log \
    network_link=PRUEBA_3 \
    schemas=INTRANETCORP \
    include=CONSTRAINT &

--Ver dblinks
SET LINESIZE 120
SET PAGESIZE 50   

COLUMN owner FORMAT A20 HEADING 'Owner'
COLUMN db_link FORMAT A40 HEADING 'Database Link'
COLUMN username FORMAT A20 HEADING 'Username'
COLUMN host FORMAT A40 HEADING 'Host'
COLUMN created FORMAT A15 HEADING 'Created'
SELECT owner, db_link, username, host, created FROM all_db_links;


col OWNER format a20
col DB_LINK format a20
col USERNAME format a20
col HOST format a20
col CREATED format a20
SELECT * FROM DBA_DB_LINKS;


DROP PUBLIC DATABASE LINK PRUEBA_4.BANVENEZ.CORP;


--Verificar DBLINK

SELECT * FROM dual@PRUEBA.DLPORTBD01;
SELECT * FROM dual@ELPSOFTD.BANVENDES.CORP;

/*

CREATE PUBLIC DATABASE LINK PRUEBA_1: Esta parte del comando indica que se está creando un enlace de base de datos llamado PRUEBA_1. Un enlace de base de datos permite que una base de datos Oracle acceda a objetos en otra base de datos Oracle.
USING 'BDVEMPD': Esta parte especifica el nombre del servicio de la base de datos remota a la que se está conectando. BDVEMPD es el identificador de la base de datos (o TNS alias) que se encuentra en el archivo tnsnames.ora, que contiene la información necesaria para establecer la conexión.
*/

--Crear un Directorio
CREATE OR REPLACE DIRECTORY EXPORT AS '/exportdb/INTRNETD/backup_temp';
CREATE OR REPLACE DIRECTORY IMPORT AS '/exportdb/INTRNETD/backup_temp';
/*
Desglose
CREATE OR REPLACE DIRECTORY: Este comando se utiliza para crear un objeto de directorio en la base de datos Oracle. Si ya existe un directorio con el mismo nombre, lo reemplaza.

test_dir: Este es el nombre del objeto de directorio que estás creando. Este nombre se utilizará dentro de la base de datos para referirse a este directorio.

AS '/data/backup': Esta parte especifica la ruta del sistema de archivos del directorio físico en el servidor donde se almacenarán los archivos. En este caso, el directorio físico es /data/backup
*/
--Conceder Permisos sobre el Directorio
GRANT READ, WRITE ON DIRECTORY test_dir TO scott;
/*
GRANT: Este comando se utiliza para conceder privilegios a un usuario o rol en la base de datos.
READ, WRITE: Estos son los privilegios que se están concediendo.
READ: Permite al usuario leer archivos del directorio.
WRITE: Permite al usuario escribir (crear o modificar) archivos en el directorio.
ON DIRECTORY test_dir: Especifica que los privilegios se están concediendo sobre el objeto de directorio llamado test_dir.
TO scott: Especifica el usuario al que se le están concediendo los privilegios. En este caso, el usuario es scott.
*/

--Ver directorios
set pagesize 100
set linesize 400
col OWNER for a15
col DIRECTORY_NAME for a40
col DIRECTORY_PATH for a70
select OWNER, DIRECTORY_NAME, DIRECTORY_PATH from all_directories;
--WHERE directory_name = 'EXPORT';

--Revisar Recycle BIN

SELECT * FROM DBA_RECYCLEBIN WHERE OWNER = 'GIOM';

--Muestra las tablas de un esquema
SELECT 
    t.table_name AS table_name,
    NVL(SUM(s.bytes) / 1024 / 1024, 0) AS size_mb
FROM 
    dba_tables t
LEFT JOIN 
    dba_segments s ON t.table_name = s.segment_name AND t.owner = s.owner
WHERE 
    t.owner = 'INTTEGRIOBDV'
    --and t.table_name = 'ESTATUS_TRANSACCIONES'
GROUP BY 
    t.table_name
ORDER BY 
    t.table_name ASC;


SELECT 
    t.table_name AS table_name,
    NVL(SUM(s.bytes) / 1024 / 1024, 0) AS size_mb
FROM 
    dba_tables t
LEFT JOIN 
    dba_segments s ON t.table_name = s.segment_name AND t.owner = s.owner
WHERE 
    t.owner = 'COMPENSEC'
GROUP BY 
    t.table_name
ORDER BY 
    t.table_name ASC;


    SELECT 
    t.table_name AS table_name,
    NVL(SUM(s.bytes) / 1024 / 1024, 0) AS size_mb
FROM 
    dba_tables t
LEFT JOIN 
    dba_segments s ON t.table_name = s.segment_name AND t.owner = s.owner
WHERE 
    t.owner = 'BDVEMP'
    and t.table_name = 'ESTATUS_TRANSACCIONES'
GROUP BY 
    t.table_name
ORDER BY 
    t.table_name ASC;


--Muestra el esquema y sus tablas:
SELECT table_name FROM user_tables;

--Si quieres ver más detalles sobre las tablas, como sus columnas, puedes usar:
SELECT column_name, data_type, data_length 
FROM user_tab_columns 
WHERE table_name = 'NOMBRE_DE_LA_TABLA';

--Para mostrar todos los esquemas:
SELECT username FROM all_users;

--Para ver qué roles tienen los usuarios:
SELECT grantee, granted_role 
FROM dba_role_privs;

--Si deseas saber bajo qué esquema estás trabajando actualmente, puedes ejecutar:
SELECT user FROM dual;

--Si deseas obtener información sobre un esquema específico, puedes usar:
SELECT * FROM all_users WHERE username = 'NOMBRE_DEL_ESQUEMA';

--Puedes obtener información adicional sobre el esquema, como la fecha de creación y el estado, usando la vista dba_users:
SELECT username, created, profile, account_status, default_tablespace, temporary_tablespace
FROM dba_users
WHERE username = 'NOMBRE_DEL_ESQUEMA';

--Listar objetos del esquema
--Para ver todos los objetos (tablas, vistas, etc.) que pertenecen a un esquema específico:
SELECT object_type, object_name
FROM all_objects
WHERE owner = 'NOMBRE_DEL_ESQUEMA';

--Si deseas saber cuántos objetos hay en el esquema:
SELECT object_type, COUNT(*)
FROM all_objects
WHERE owner = 'NOMBRE_DEL_ESQUEMA'
GROUP BY object_type;

--Para ver los privilegios que tiene el esquema:
SELECT privilege
FROM dba_sys_privs
WHERE grantee = 'NOMBRE_DEL_ESQUEMA';

--Para ver los roles que tiene el esquema:
SELECT granted_role
FROM dba_role_privs
WHERE grantee = 'NOMBRE_DEL_ESQUEMA';

--Contar el número de tablas en el esquema
SELECT COUNT(*) AS total_tablas
FROM all_tables
WHERE owner = 'NOMBRE_DEL_ESQUEMA';

--Si deseas obtener más detalles sobre las tablas (como sus nombres), puedes usar una consulta diferente:
SELECT table_name
FROM all_tables
WHERE owner = 'BDVEMP';

SELECT table_name
FROM all_tables
WHERE owner = 'GIOM'
ORDER BY table_name ASC;


--Listar esquemas por peso en MB
set linesize 500
SELECT 
    u.USERNAME AS schema_name,
    NVL(SUM(s.BYTES) / 1024 / 1024, 0) AS size_mb
FROM 
    DBA_USERS u
LEFT JOIN 
    DBA_SEGMENTS s ON u.USERNAME = s.OWNER
GROUP BY 
    u.USERNAME
ORDER BY 
    size_mb DESC;



--Consulta para obtener el esquema de una tabla
SELECT owner
FROM all_tables
WHERE table_name = 'NOMBRE_DE_LA_TABLA';

SELECT username FROM dba_users;


--Utiliza el siguiente comando para exportar el esquema, incluyendo las estadísticas:
expdp tu_usuario/tupassword schemas=NOMBRE_DEL_ESQUEMA directory=export_dir dumpfile=nombre_dump.dmp logfile=export.log include=STATISTICS

/*
Desglose del comando:
tu_usuario/tupassword: Reemplaza con tu nombre de usuario y contraseña.
schemas=NOMBRE_DEL_ESQUEMA: Reemplaza NOMBRE_DEL_ESQUEMA con el nombre del esquema que deseas exportar.
directory=export_dir: Especifica el directorio donde se guardará el archivo de volcado.
dumpfile=nombre_dump.dmp: Nombre del archivo de volcado que se generará.
logfile=export.log: Nombre del archivo de registro que se generará.
include=STATISTICS: Esta opción asegura que las estadísticas se incluyan en la exportación.
*/

--Exportar tablas
nohup expdp system/bqsmt7aral8 directory=EXPORT TABLES=ADM_INFI.INFI_TB_234_VC_DIVISAS,ADM_INFI.INFI_TB_234_VC_DIVISAS_HIST dumpfile=EXPORT_INFI_30102024.dmp logfile=EXPORT_INFI_30102024.log PARALLEL=8 &

nohup expdp system/bqsmt7aral8 directory=EXPORT TABLES=POSVD.VPOS_SECURITY_QUESTION dumpfile=EXPORT_TABLA.dmp logfile=EXPORT_TABLA.log &

--exportar esquema y excluir una tabla 
nohup expdp system/bqsmt7aral8 schemas=POSVD exclude=TABLE:"IN('VPOS_SECURITY_QUESTION')" directory=EXPORT dumpfile=EXPORT_TAREA1.dmp logfile=EXPORT_TAREA1.log include=STATISTICS &

nohup expdp system/bqsmt7aral8 schemas=POSVD exclude=TABLE:"IN('VPOS_SECURITY_QUESTION')" directory=EXPORT dumpfile=EXPORT_TAREA1.dmp logfile=EXPORT_TAREA1.log &

Attached the job
-- Attach with another session
impdp system/bqsmt7aral8 ATTACH=SYS_IMPORT_FULL_01


nohup expdp system/bqsmt7aral8 schemas=BDVEMP directory=EXPORT dumpfile=EXPDP_BDVEMP.dmp logfile=EXPDP_BDVEMP.log &

expdp system/bqsmt7aral8 schemas=BDVEMP directory=EXPORT dumpfile=EXPDP_BDVEMP_20241111.dmp logfile=EXPDP_BDVEMP_20241111.log

--Importar tablas
nohup impdp system/bqsmt7aral8 directory=IMPORT tables=bdvemp.ESTATUS_TRANSACCIONES,bdvemp.REGISTRO_TRANSACCIONES logfile=IMPDP_BDVEMP3_20250711.log network_link=PRUEBA_2 content=data_only remap_schema=bdvemp:bdvempp table_exists_action=truncate &

--nohup impdp system/bqsmt7aral8 schemas=BDVEMP directory=IMPORT logfile=EXPDP_BDVEMP_20241111.log network_link=PRUEBA_1 remap_schema=BDVEMP:BDVEMPP REMAP_TABLESPACE=DATA:DATA_BDVEMPD &

nohup impdp system/bqsmt7aral8 schemas=BDVEMP directory=IMPORT logfile=EXPDP_BDVEMP_20241111.log network_link=PRUEBA_1 remap_schema=BDVEMP:BDVEMPP REMAP_TABLESPACE=DATA_BDVEMPD:DATA exclude=STATISTICS &

--nohup impdp system/bqsmt7aral8 schemas=BDVEMP directory=IMPORT dumpfile=EXPDP_BDVEMP.dmp logfile=IMPDP_BDVEMP.log remap_schema=BDVEMP:BDVEMPP &



nohup expdp system/oracle1 schemas=GIOM directory=EXPORT dumpfile=EXPDP_GIOM20250207.dmp logfile=EXPORT_GIOM20250207.log exclude=STATISTICS &

nohup impdp system/bqsmt7aral8 schemas=GIOM directory=IMPORT dumpfile=EXPDP_GIOM20250207.dmp logfile=IMPORT_GIOM20250207.log TABLE_EXISTS_ACTION=REPLACE &

--EXPORT FULL
nohup expdp system/bqsmt7aral8 full=Y directory=EXPORT_COMPENSEC dumpfile=expo_BVSOL02Q_COMPENSEC_full15042025.dmp logfile=expo_BVSOL02Q_COMPENSEC_full15042025.log exclude=STATISTICS &

nohup expdp system/bqsmt7aral8 full=Y directory=EXPORT dumpfile=expo_INTRNETD_full08082025.dmp logfile=expo_INTRNETD_full22042025.log exclude=STATISTICS &


nohup expdp system/bqsmt7aral8 full=Y directory=EXPORT dumpfile=expo_INTRNETD_structure08082025.dmp logfile=expo_INTRNETD_structure22042025.log content=METADATA_ONLY &

--IMPORT FULL
nohup impdp system/bqsmt7aral8 full=Y directory=EXPORT logfile=imp_expo_INTRNETD_full07052025.log network_link=PRUEBA_3 &



nohup impdp system/bqsmt7aral8 full=Y directory=IMPORT logfile=imp_expo_INTRNETD_full13072025.log network_link=PRUEBA_3 &



nohup impdp system/bqsmt7aral8 full=Y directory=IMPORT logfile=imp_expo_INTRNETD_full13072025.log network_link=PRUEBA_3 &

nohup impdp system/oracle1 full=Y directory=EXPORT logfile=imp_expo_RMAN11_full07052025.log network_link=PRUEBA_3 &


nohup expdp system/bqsmt7aral8 schemas=INTRANETCORP directory=EXPORT logfile=INTRNETD_13072025.log dumpfile=INTRNETD_13072025.dmp exclude=STATISTICS &

nohup expdp system/bqsmt7aral8 DIRECTORY=EXPORT DUMPFILE=export_sav_perito.dmp LOGFILE=export_sav_perito.log TABLES=SOLICITUDES.SAV_PERITO,SOLICITUDES.SAV_PERITO_BCK CONTENT=DATA_ONLY exclude=STATISTICS &


nohup impdp system/bqsmt7aral8 DIRECTORY=EXPORT DUMPFILE=export_sav_perito.dmp LOGFILE=import_sav_perito.log REMAP_SCHEMA=SOLICITUDES:SOLICITUDES TABLES=SOLICITUDES.SAV_PERITO,SOLICITUDES.SAV_PERITO_BCK CONTENT=DATA_ONLY exclude=STATISTICS &

nohup impdp system/bqsmt7aral8 schemas=INTRANETCORP directory=EXPORT logfile=INTRNETD_import_13072025.log dumpfile=INTRNETD_13072025.dmp exclude=STATISTICS &
---------------------------------------
set linesize 900
SELECT * FROM dba_datapump_jobs;

SELECT INSTANCE_NAME FROM V$INSTANCE;

SELECT job_name
FROM dba_datapump_jobs
WHERE state IN ('N', 'FAILED');

CREATE TABLESPACE DATA03
DATAFILE 
  '+DATA' SIZE 200M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;
/*


Desglose de las Consultas
1. set linesize 900
¿Qué hace? Esta instrucción no es una consulta SQL en sí, sino un comando específico para herramientas como SQL*Plus o SQL Developer. Sirve para ajustar el ancho máximo de una línea en la salida de los resultados de una consulta.
Por qué se usa: Al establecer linesize en 900, se garantiza que los resultados de las consultas, incluso aquellos con campos de texto muy largos, se muestren en una sola línea, evitando saltos de línea innecesarios y facilitando la lectura.
2. SELECT * FROM dba_datapump_jobs;
¿Qué hace? Esta consulta selecciona todas las columnas de la vista de diccionario de datos dba_datapump_jobs.
¿Para qué sirve? Esta vista contiene información detallada sobre los trabajos de Data Pump, una herramienta de Oracle utilizada para exportar e importar grandes volúmenes de datos. Con esta consulta, puedes obtener una visión general de todos los trabajos de Data Pump que se han ejecutado o están en ejecución en la base de datos, incluyendo su estado, hora de inicio, hora de finalización, etc.
3. SELECT INSTANCE_NAME FROM V$INSTANCE;
¿Qué hace? Esta consulta selecciona el nombre de instancia de la vista dinámica v$instance.
¿Para qué sirve? La vista v$instance proporciona información sobre la instancia de la base de datos en ejecución. Con esta consulta, puedes identificar el nombre específico de la instancia de Oracle a la que te estás conectando.
4. SELECT job_name FROM dba_datapump_jobs WHERE state IN ('N', 'FAILED');
¿Qué hace? Esta consulta selecciona los nombres de los trabajos de Data Pump que se encuentran en estado "Nuevo" (N) o "Fallido" (FAILED).
¿Para qué sirve? Esta consulta es útil para identificar trabajos que aún no han comenzado a ejecutarse o que han experimentado errores durante su ejecución. Al conocer estos trabajos, puedes tomar acciones correctivas, como reiniciar trabajos fallidos o investigar las causas de los errores.
Propósito General de las Consultas
En conjunto, estas consultas se utilizan comúnmente para:

Monitorear trabajos de Data Pump: Verificar el estado de los trabajos en ejecución o recientemente completados.
Identificar problemas: Detectar trabajos fallidos y obtener información sobre las posibles causas de los errores.
Diagnosticar problemas: Recopilar información sobre la instancia de la base de datos y los trabajos de Data Pump para solucionar problemas.
*/
---------------------------------------


/*
Desglose del Comando

nohup:
Significa "no hang up". Este comando permite que el proceso continúe ejecutándose incluso si la sesión de terminal se cierra. Es útil para ejecutar tareas largas en segundo plano.

expdp:
Es la utilidad de Oracle Data Pump Export, utilizada para exportar datos y metadatos de la base de datos.

system/bqsmt7aral8:
system es el nombre de usuario de la base de datos, y bqsmt7aral8 es la contraseña del usuario. Este usuario debe tener los privilegios necesarios para realizar la exportación.

directory=EXPORT:
Especifica el directorio donde se almacenarán los archivos de volcado (dump files) y de registro (log files). Este directorio debe estar previamente creado en Oracle y debe tener los permisos adecuados.

TABLES=ADM_INFI.INFI_TB_234_VC_DIVISAS,ADM_INFI.INFI_TB_234_VC_DIVISAS_HIST:
Indica las tablas específicas que se van a exportar. En este caso, se están exportando dos tablas: INFI_TB_234_VC_DIVISAS y INFI_TB_234_VC_DIVISAS_HIST, ambas pertenecientes al esquema ADM_INFI.

dumpfile=EXPORT_INFI_30102024.dmp:
Especifica el nombre del archivo de volcado que se generará. Este archivo contendrá los datos exportados.

logfile=EXPORT_INFI_30102024.log:
Especifica el nombre del archivo de registro que se generará. Este archivo contendrá información sobre el proceso de exportación, incluidos errores y estadísticas.

PARALLEL=8:
Indica que se utilizarán 8 procesos paralelos para realizar la exportación. Esto puede acelerar el proceso de exportación, especialmente si se están exportando grandes volúmenes de datos.



&:
Coloca el comando en segundo plano, lo que significa que podrás seguir utilizando la terminal mientras el proceso de exportación se ejecuta.
Resumen
Este comando exporta dos tablas específicas de la base de datos utilizando Oracle Data Pump, generando un archivo de volcado y un archivo de registro en un directorio designado. Utiliza múltiples procesos paralelos para mejorar la eficiencia y se ejecuta en segundo plano para que no interfiera con otras tareas en la terminal.
*/

--- verificar los directios
set pagesize 100
set linesize 400
col OWNER for a15
col DIRECTORY_NAME for a40
col DIRECTORY_PATH for a70
select OWNER, DIRECTORY_NAME, DIRECTORY_PATH from all_directories;

/*
Desglose del Comando
set pagesize 100:
Este comando establece el número de filas que se mostrarán en cada página de resultados a 100. Si el resultado de la consulta tiene más de 100 filas, se paginará, y se mostrará una nueva página después de cada 100 filas.

set linesize 400:
Este comando establece el ancho de la línea a 400 caracteres. Esto es útil para asegurarse de que las columnas de salida no se corten y se muestren correctamente en la pantalla.

col OWNER for a15:
Este comando formatea la columna OWNER para que tenga un ancho fijo de 15 caracteres. Si el contenido de la columna es más largo, se truncará.

col DIRECTORY_NAME for a40:
Similar al anterior, este comando formatea la columna DIRECTORY_NAME para que tenga un ancho fijo de 40 caracteres.

col DIRECTORY_PATH for a70:
Este comando formatea la columna DIRECTORY_PATH para que tenga un ancho fijo de 70 caracteres.

select OWNER, DIRECTORY_NAME, DIRECTORY_PATH from all_directories;:
Esta es la consulta principal que selecciona tres columnas de la vista all_directories:
OWNER: El propietario del directorio.
DIRECTORY_NAME: El nombre del directorio.
DIRECTORY_PATH: La ruta del directorio en el sistema de archivos.
*/






	
nohup expdp full=Y directory=EXPORT_COMPENSEC dumpfile=expo_BVSOL02Q_COMPENSEC_full15042025.dmp logfile=expo_BVSOL02Q_COMPENSEC_full15042025.log


**********************************
directorio 


vi impdp_esquemas_falt.par 


DIRECTORY=IMPORT 
SCHEMAS=BDVEMP 
LOGFILE=EXPDP_BDVEMP_CONST.LOG 
SQLFILE=EXPDP_BDVEMP_CONST.SQL 
INCLUDE=CONSTRAINT 
CONTENT=METADATA_ONLY 
NETWORK_LINK=PRUEBA_1 
REMAP_SCHEMA=BDVEMP:BDVEMPP 
REMAP_TABLESPACE=DATA_BDVEMPD:DATA 
EXCLUDE=STATISTICS 


nohup impdp system/bqsmt7aral8 parfile=impdp_esquemas_falt.par &

alter system set log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST valid_for=(ALL_LOGFILES,ALL_ROLES) MAX_FAILURE=1 REOPEN=5 DB_UNIQUE_NAME=LABORATORIO ALTERNATE=LOG_ARCHIVE_DEST_10';

alter system set log_archive_dest_10='location=+DATA valid_for=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=LABORATORIO ALTERNATE=LOG_ARCHIVE_DEST_1';



MONITOREO


vmstat 5 1000000
 
while true; do iostat -d -x 2 2 | sort -n -k 11; sleep 5; echo ------- ; done


Verificaciones Finales

prompt DB_ORIGEN
SELECT 
    (SELECT COUNT(1) FROM dba_indexes@PRUEBA_3       where owner = 'INTRANETCORP') AS total_indices,
    (SELECT COUNT(1) FROM dba_constraints@PRUEBA_3   where owner = 'INTRANETCORP') AS total_constraints,
    (SELECT COUNT(1) FROM dba_tables@PRUEBA_3        where owner = 'INTRANETCORP') AS total_tables,
    (SELECT COUNT(1) FROM dba_procedures@PRUEBA_3    where owner = 'INTRANETCORP') AS total_procedures,
    (SELECT COUNT(1) FROM dba_objects@PRUEBA_3       where owner = 'INTRANETCORP' AND object_type = 'PACKAGE') AS total_packages,
    (SELECT COUNT(1) FROM dba_objects@PRUEBA_3       where owner = 'INTRANETCORP' and object_type = 'PACKAGE BODY') AS total_package_bodies,
    (SELECT COUNT(1) FROM dba_synonyms@PRUEBA_3      where owner = 'INTRANETCORP') AS total_synonyms,
    (SELECT COUNT(1) FROM dba_sequences@PRUEBA_3     where SEQUENCE_OWNER = 'INTRANETCORP') AS total_sequences
FROM dual;


prompt BD_DESTINO
SELECT 
    (SELECT COUNT(1) FROM dba_indexes           where owner = 'INTRANETCORP') AS total_indices,
    (SELECT COUNT(1) FROM dba_constraints       where owner = 'INTRANETCORP') AS total_constraints,
    (SELECT COUNT(1) FROM dba_tables            where owner = 'INTRANETCORP') AS total_tables,
    (SELECT COUNT(1) FROM dba_procedures        where owner = 'INTRANETCORP') AS total_procedures,
    (SELECT COUNT(1) FROM dba_objects           where owner = 'INTRANETCORP' AND object_type = 'PACKAGE') AS total_packages,
    (SELECT COUNT(1) FROM dba_objects           where owner = 'INTRANETCORP' and object_type = 'PACKAGE BODY') AS total_package_bodies,
    (SELECT COUNT(1) FROM dba_synonyms          where owner = 'INTRANETCORP') AS total_synonyms,
    (SELECT COUNT(1) FROM dba_sequences         where SEQUENCE_OWNER = 'INTRANETCORP') AS total_sequences
FROM dual;



SELECT grantee, granted_role
FROM dba_role_privs
WHERE grantee = 'NM04708';

SELECT *
FROM dba_role_privs
WHERE GRANTEE = 'NM04708';

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


 SELECT *
FROM (
	SELECT OBJECT_NAME
	FROM DBA_OBJECTS 
	WHERE OWNER='INTRANETCORP'
	AND OBJECT_TYPE='PROCEDURE' 
		MINUS 
	SELECT OBJECT_NAME
	FROM DBA_OBJECTS@PRUEBA_3
	WHERE OWNER='INTRANETCORP'
	AND OBJECT_TYPE='PROCEDURE' 
);

SELECT owner, object_name, object_type
FROM all_objects
WHERE status = 'INVALID';


SELECT owner, object_name, object_type
FROM all_objects
WHERE status = 'INVALID';

SET LINESIZE 100
SET PAGESIZE 50

COL OBJECT_NAME FORMAT A30
COL OWNER FORMAT A20
COL OBJECT_TYPE FORMAT A20



 SELECT *
FROM (
	SELECT OBJECT_NAME
	FROM DBA_OBJECTS 
	WHERE OWNER='INTRANETCORP'
	AND OBJECT_TYPE='PROCEDURE' 
		MINUS 
	SELECT OBJECT_NAME
	FROM DBA_OBJECTS@PRUEBA_3
	WHERE OWNER='INTRANETCORP'
	AND OBJECT_TYPE='PROCEDURE' 
);

SELECT *
FROM (
    SELECT PROCEDURE_NAME, OWNER, OBJECT_NAME
    FROM dba_procedures@PRUEBA_3
    WHERE OWNER='INTRANETCORP' 
        MINUS 
    SELECT PROCEDURE_NAME, OWNER, OBJECT_NAME
    FROM dba_procedures
    WHERE OWNER='INTRANETCORP'
);

SELECT *
FROM (
    SELECT OBJECT_NAME, OWNER, OBJECT_TYPE
    FROM DBA_OBJECTS 
    WHERE STATUS = 'INVALID'
        MINUS 
    SELECT OBJECT_NAME, OWNER, OBJECT_TYPE
    FROM DBA_OBJECTS@PRUEBA_3
    WHERE STATUS = 'INVALID'
);

SELECT username FROM all_users;

SELECT *
FROM (
    SELECT username
    FROM all_users 
        MINUS 
    SELECT username
    FROM all_users@PRUEBA_2
);


SELECT *
FROM (
    SELECT OBJECT_NAME, OWNER, OBJECT_TYPE
    FROM DBA_OBJECTS@PRUEBA_2 
    WHERE OWNER = 'INTRANETCORP'  
      AND OBJECT_TYPE = 'CONSTRAINT'
    MINUS 
    SELECT OBJECT_NAME, OWNER, OBJECT_TYPE
    FROM DBA_OBJECTS
    WHERE OWNER = 'INTRANETCORP'  
      AND OBJECT_TYPE = 'CONSTRAINT'
);


SELECT OWNER, OBJECT_NAME, OBJECT_TYPE
FROM DBA_OBJECTS
WHERE OBJECT_NAME = 'intranet_fideicomitente';



SELECT * FROM dual@HRSYSD.BANVENEZ.CORP;

Link Name	HRSYSD.BANVENEZ.CORP


CREATE DATABASE LINK "HRSYSD.BANVENEZ.CORP"
 CONNECT TO SOLICITUDES
 IDENTIFIED BY bqsmt7aral8
 USING 'HRSYSD.BANVENEZ.CORP';

 DROP DATABASE LINK "HRSYSD.BANVENEZ.CORP";



nohup impdp system/bqsmt7aral8 schemas=INTRANETCORP directory=EXPORT logfile=imp_expo_SOLICITUDES_esquema25042025.log network_link=PRUEBA_3 &


--Compilar objetos_invalidos

@?/rdbms/admin/utlrp



OBJECT_NAME                    OWNER                OBJECT_TYPE
------------------------------ -------------------- --------------------
PKG_GST_PD                     PUBLIC               SYNONYM
PKG_FIDE_UTIL                  SOLICITUDES          PACKAGE BODY
PKG_HEX_UTIL                   SOLICITUDES          PACKAGE BODY
PKG_PEOPLE_UTIL                SOLICITUDES          PACKAGE BODY
PKG_SAV_DW                     SOLICITUDES          PACKAGE BODY
PKG_SAV_UTIL                   SOLICITUDES          PACKAGE BODY
PKG_STC_UTIL                   SOLICITUDES          PACKAGE BODY
PKG_STC_UTIL_RESP              SOLICITUDES          PACKAGE BODY
PKG_UTIL                       SOLICITUDES          PACKAGE BODY
PKG_VAC_OLD_UTIL               SOLICITUDES          PACKAGE BODY
PKG_VAC_UTIL                   SOLICITUDES          PACKAGE BODY

OBJECT_NAME                    OWNER                OBJECT_TYPE
------------------------------ -------------------- --------------------
PKG_MAN_UTIL                   MANUALES             PACKAGE
PKG_CONSULTA_UTIL              MANUALES             PACKAGE
PRUEBA                         MANUALES             PACKAGE
PKG_GST_PD                     ARQSYS               PACKAGE
PKG_ASI_PRUEBAS                ASI                  PACKAGE
F_DATOSEMPLEADOS               BDVDAS               FUNCTION
F_DATOS_EMPLEADOS              BDVDAS               FUNCTION
F_INSERT_REFTEC_SOLICITUD      GSTP                 FUNCTION
F_INSERT_SOLICITUD             GSTP                 FUNCTION
AUMENTASUELDO                  BDVDAS               PROCEDURE
INGRESOEMPLE                   BDVDAS               PROCEDURE

OBJECT_NAME                    OWNER                OBJECT_TYPE
------------------------------ -------------------- --------------------
INICIASORTEO                   SORTEO               PROCEDURE
PRUEBA_ARRAY                   CONACT               PROCEDURE
SAV_INC_CALENDARIO             SOLICITUDES          VIEW
LOS_PRODUCTOS                  BDVDAS               PACKAGE BODY
LOS_PRODUCTOS2                 BDVDAS               PACKAGE BODY
PKG_EXTRANET_UTIL              BDVDAS               PACKAGE BODY
PKG_PRUEBA_UTIL                BDVDAS               PACKAGE BODY
ENG_WF_UTIL                    ENG_WF               PACKAGE BODY
PKG_BORRAR_DATOS               ENG_WF               PACKAGE BODY
SCDC_DEPARTAMENTOS_PKG         SCDC                 PACKAGE BODY
PKG_LDAP_UTIL                  USU_INTRANET         PACKAGE BODY

OBJECT_NAME                    OWNER                OBJECT_TYPE
------------------------------ -------------------- --------------------
PKG_ACTIVOS_CAI_UTIL_A         HISTORICO            PACKAGE BODY
PKG_CONSULTA_UTIL              MANUALES             PACKAGE BODY
PKG_MAN_UTIL                   MANUALES             PACKAGE BODY
PRUEBA                         MANUALES             PACKAGE BODY
PKG_LLENAR_FLAGS               CAJA                 PACKAGE BODY
PKG_GST_PD                     ARQSYS               PACKAGE BODY
PKG_PRUEBA_UTIL                ASISTENCIA           PACKAGE BODY
PKG_ASI_PRUEBAS                ASI                  PACKAGE BODY
WWV_BIU_FLOW_FILE_OBJECTS      FLOWS_FILES          TRIGGER
PKG_INTRANET_UTIL_OLD          INTRANETCORP         PACKAGE
PKG_INTRANET_UTIL_OLD          INTRANETCORP         PACKAGE BODY

OBJECT_NAME                    OWNER                OBJECT_TYPE
------------------------------ -------------------- --------------------
PKG_LDAP_UTIL2                 INTRANETCORP         PACKAGE BODY
PKG_MANTENIMIENTO_APLICACIONES INTRANETCORP         PACKAGE BODY





CREATE TABLESPACE DATA
DATAFILE 
  '+DATA' SIZE 3G AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

CREATE TABLESPACE DATA02
DATAFILE 
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE DATA03
DATAFILE 
  '+DATA' SIZE 300M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

CREATE TABLESPACE DATA04
DATAFILE 
  '+DATA' SIZE 2000M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE DATA05
DATAFILE 
  '+DATA' SIZE 6G AUTOEXTEND OFF,
  '+DATA' SIZE 6G AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE DATA06
DATAFILE 
  '+DATA' SIZE 800M AUTOEXTEND OFF,
  '+DATA' SIZE 800M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE DATA08
DATAFILE 
  '+DATA' SIZE 10G AUTOEXTEND OFF,
  '+DATA' SIZE 10G AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE DATA10
DATAFILE 
  '+DATA' SIZE 600M AUTOEXTEND OFF,
  '+DATA' SIZE 600M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE DATA_ARI
DATAFILE 
  '+DATA' SIZE 200M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE DATA_CDC
DATAFILE 
  '+DATA' SIZE 100M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

CREATE TABLESPACE DATA_GSTP
DATAFILE 
  '+DATA' SIZE 100M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

CREATE TABLESPACE DATA_ISLR
DATAFILE 
  '+DATA' SIZE 2G AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

CREATE TABLESPACE DATA_ITF
DATAFILE 
  '+DATA' SIZE 10G AUTOEXTEND OFF,
  '+DATA' SIZE 10G AUTOEXTEND OFF,
  '+DATA' SIZE 10G AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

CREATE TABLESPACE DATA_MSINT
DATAFILE 
  '+DATA' SIZE 100M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE DATA_PIRAMIDE
DATAFILE 
  '+DATA' SIZE 2G AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE DATA_SGU
DATAFILE 
  '+DATA' SIZE 100M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

CREATE TABLESPACE DATA_VAC
DATAFILE 
  '+DATA' SIZE 2G AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

CREATE TABLESPACE INDX03
DATAFILE 
  '+DATA' SIZE 200M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE INDX05
DATAFILE 
  '+DATA' SIZE 200M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE INDX06
DATAFILE 
  '+DATA' SIZE 300M AUTOEXTEND OFF,
  '+DATA' SIZE 300M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE INDX08
DATAFILE 
  '+DATA' SIZE 3000M AUTOEXTEND OFF,
  '+DATA' SIZE 3000M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

CREATE TABLESPACE INDX10
DATAFILE 
  '+DATA' SIZE 100M AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

CREATE TABLESPACE LOB_INTRANET
DATAFILE 
  '+DATA' SIZE 8G AUTOEXTEND OFF,
  '+DATA' SIZE 8G AUTOEXTEND OFF
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;