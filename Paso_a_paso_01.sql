Pasos Migracion BDVEMP

ORIGEN
Depurar data.
	--Realizar particionamiento en las tablas importantes (6) -- Pruebas en desarrollo.
	--Migrar al histórico la data no necesaria antes de la migración.
	--Realizar export de las tablas historicas y solicitar almacenamiento en cinta de 10 años de las mismas.

Validar/Compilar Objetos Invalidos

Realizar pruebas de export.

	Revisar los directorios.


EXPORT 
/migra/BDVEMPP/MIGRACION/scripts


 Parfile_full
 
 vi 01_parfile_exp_full_BDVEMP.par
 
DIRECTORY=MIGRACION
FULL=Y
LOGFILE=EXP_FULL_BDVEMP.LOG
DUMPFILE=EXP_FULL_BDVEMP_%U.dmp
LOGTIME=ALL
METRICS=YES
PARALLEL=50
CLUSTER=N
EXCLUDE=AUDIT_TRAILS
EXCLUDE=STATISTICS


--Para verificar el paralelismo a colocar guiarse por show parameter cpu


Ejecucion_Parfiles_Verificacion_Workers

02.2.1.- EXPDP_FULL

nohup expdp system/k3r3p4kup41 parfile=01_parfile_exp_full_BDVEMP.par &

impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01




DESTINO
--Archivo Backup_Restore_BDVEMP.sql

-- Crear Backup Offline - Pasos Restore. -- preparar servidor, TBS.
-- Verificar espacios.
-- Verificar Directories.
-- Desactivar Archivelogs.


Subir query de LONG_OP
cd /exportdb/BDVEMPP/MIGRACION
sqlplus / as sysdba @long_operation.sql


Verificar y compilar objetos inválidos.

sqlplus / as sysdba

COLUMN object_name FORMAT A50
column OWNER format a30
set pagesize 1000
SELECT owner
      ,object_type
      ,object_name
      ,status
 FROM dba_objects
WHERE status = 'INVALID'
--and owner = 'PAGOF'
ORDER BY owner, object_type, object_name; 



@?/rdbms/admin/utlrp.sql

-- BDVEMPP                        JAVA CLASS              calcsha2                                           INVALID
-- BDVEMPP                        JAVA SOURCE             calcsha                                            INVALID
-- BDVEMPP                        PROCEDURE               ENCRIPTAR_SHA1                                     INVALID
-- BDVEMPP                        PROCEDURE               GET_PLANESINFOCOMPLETA                             INVALID
-- BDVEMPP                        PROCEDURE               GET_TIPO_FIDEICOMISO                               INVALID
-- BDVEMPP                        PROCEDURE               MTTO_PART_RT                                       INVALID
-- BDVEMPP                        PROCEDURE               PROC_TEMPORAL                                      INVALID
-- BDVEMPP                        PROCEDURE               PR_BNET_ENVIA_MAIL_TOKEN                           INVALID
-- BDVEMPP                        PROCEDURE               PR_CAMBIA_CLAVE                                    INVALID
-- BDVEMPP                        PROCEDURE               PR_CREA_NUEVA_CLAVE                                INVALID
-- BDVEMPP                        PROCEDURE               PR_CST_CIUDADES_CR                                 INVALID
-- BDVEMPP                        PROCEDURE               PR_CST_USER                                        INVALID
-- BDVEMPP                        PROCEDURE               PR_EMPCSTLIQUIDACIONPORLOTEPV                      INVALID
-- BDVEMPP                        PROCEDURE               PR_EMPCSTTOTALESLPL                                INVALID
-- BDVEMPP                        PROCEDURE               PR_EMP_CARGAR_INF_TOKEN                            INVALID
-- BDVEMPP                        PROCEDURE               PR_EMP_EMCRIPTAR_SHA1                              INVALID
-- BDVEMPP                        PROCEDURE               PR_GENERA_CLAVE                                    INVALID
-- BDVEMPP                        PROCEDURE               PR_REINICIO_CLAVE                                  INVALID
-- BDVEMPP                        PROCEDURE               UTILITARIO_CONVERSION_USER                         INVALID

ALTER PROCEDURE UTILITARIO_CONVERSION_USER COMPILE;

--verificar procedure
SELECT * FROM ALL_OBJECTS WHERE object_name = 'GET_PLANESINFOCOMPLETA';
--- Temrinar de compilar los objetos inavlidos en el origen.

Si existe problema con la conexión de EXP/IMP Ejecutar. --Igualmente ejecutar antes del restore (Despues de prueba 1404)
@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/utlrp.sql

Parfile IMPDP

vi 02_parfile_imp_full_BDVEMP.par
DIRECTORY=MIGRACION
FULL=Y
LOGFILE=IMP_FULL_BDVEMP.LOG
DUMPFILE=EXP_FULL_BDVEMP_%U.dmp
PARALLEL=50
METRICS=YES
CLUSTER=Y
LOGTIME=ALL



-- 
-- 
-- vi parfile_imp_data.par
-- 
-- DIRECTORY=MIGRACION
-- FULL=Y
-- LOGFILE=IMP_DATA_BDVEMP.LOG
-- DUMPFILE=EXP_FULL_BDVEMP_%U.dmp
-- METRICS=YES
-- PARALLEL=
-- EXCLUDE=STATISTICS
-- CONTENT=DATA_ONLY
-- CLUSTER=N
-- LOGTIME=ALL




select * from dba_datapump_jobs;



nohup impdp system/oracle1 parfile=parfile_imp_data.par &

tail -1000f nohup.out


impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01

nohup impdp system/oracle1 DIRECTORY=MIGRACION FULL=Y LOGFILE=IMP_DATA_BDVEMP.LOG DUMPFILE=EXP_FULL_BDVEMP_%U.dmp METRICS=YES EXCLUDE=STATISTICS CLUSTER=Y LOGTIME=ALL &



BDVEMPP



--Para CALIDAD 
En caso de requerir modificar el esquema:
SCHEMAS=HR \
REMAP_SCHEMA=HR:NEW_HR


--PRUEBA NETWORKLINK 
--vi parfile_imp_loc_mov_cta.par
--
--DIRECTORY=MIGRACION
--LOGFILE=IMP_LOC_MOV_CTA_01.LOG
--TABLES=BDVEMPP.LOC_MOVIMIENTO_CUENTA
--PARALLEL=20
--LOGTIME=ALL
--METRICS=Y
--
--CLUSTER=N
--NETWORK_LINK=PRUEBA
--EXCLUDE=STATISTICS
--REMAP_SCHEMA=BDVEMPP:BDVEMP

--nohup impdp system/oracle1 parfile=parfile_imp_loc_mov_cta.par &
--tail -1000f nohup.out
--impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01



--nohup impdp system/oracle1 DIRECTORY=MIGRACION LOGFILE=IMP_LOC_MOV_CTA_01.LOG TABLES=BDVEMPP.LOC_MOVIMIENTO_CUENTA NETWORK_LINK=PRUEBA CLUSTER=N EXCLUDE=STATISTICS REMAP_SCHEMA=BDVEMPP:BDVEMP &
--impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01


MONITOREO


vmstat 5 1000000
 
while true; do iostat -d -x 2 2 | sort -n -k 11; sleep 5; echo ------- ; done


Verificaciones Finales


prompt DB_ORIGEN
SELECT 
    (SELECT COUNT(1) FROM dba_indexes@BDVEMPSUN1001       where owner = 'BDVEMPP') AS total_indices,
    (SELECT COUNT(1) FROM dba_constraints@BDVEMPSUN1001   where owner = 'BDVEMPP') AS total_constraints,
    (SELECT COUNT(1) FROM dba_tables@BDVEMPSUN1001        where owner = 'BDVEMPP') AS total_tables,
    (SELECT COUNT(1) FROM dba_procedures@BDVEMPSUN1001    where owner = 'BDVEMPP') AS total_procedures,
    (SELECT COUNT(1) FROM dba_objects@BDVEMPSUN1001       where owner = 'BDVEMPP' AND object_type = 'PACKAGE') AS total_packages,
    (SELECT COUNT(1) FROM dba_objects@BDVEMPSUN1001       where owner = 'BDVEMPP' and object_type = 'PACKAGE BODY') AS total_package_bodies,
    (SELECT COUNT(1) FROM dba_synonyms@BDVEMPSUN1001      where owner = 'BDVEMPP') AS total_synonyms,
    (SELECT COUNT(1) FROM dba_sequences@BDVEMPSUN1001     where SEQUENCE_OWNER = 'BDVEMPP') AS total_sequences
FROM dual;


prompt BD_DESTINO
SELECT 
    (SELECT COUNT(1) FROM dba_indexes           where owner = 'BDVEMPP') AS total_indices,
    (SELECT COUNT(1) FROM dba_constraints       where owner = 'BDVEMPP') AS total_constraints,
    (SELECT COUNT(1) FROM dba_tables            where owner = 'BDVEMPP') AS total_tables,
    (SELECT COUNT(1) FROM dba_procedures        where owner = 'BDVEMPP') AS total_procedures,
    (SELECT COUNT(1) FROM dba_objects           where owner = 'BDVEMPP' AND object_type = 'PACKAGE') AS total_packages,
    (SELECT COUNT(1) FROM dba_objects           where owner = 'BDVEMPP' and object_type = 'PACKAGE BODY') AS total_package_bodies,
    (SELECT COUNT(1) FROM dba_synonyms          where owner = 'BDVEMPP') AS total_synonyms,
    (SELECT COUNT(1) FROM dba_sequences         where SEQUENCE_OWNER = 'BDVEMPP') AS total_sequences
FROM dual;


--Primera prueba de import --Export antes de depuracion de tablas.

-- ORIGEN
-- 
-- TOTAL_INDICES TOTAL_CONSTRAINTS TOTAL_TABLES TOTAL_PROCEDURES TOTAL_PACKAGES TOTAL_PACKAGE_BODIES TOTAL_SYNONYMS TOTAL_SEQUENCES
-- ------------- ----------------- ------------ ---------------- -------------- -------------------- -------------- ---------------
--           192               321          162              340              1                    1              0              28
-- DESTINO
-- 
-- TOTAL_INDICES TOTAL_CONSTRAINTS TOTAL_TABLES TOTAL_PROCEDURES TOTAL_PACKAGES TOTAL_PACKAGE_BODIES TOTAL_SYNONYMS TOTAL_SEQUENCES
-- ------------- ----------------- ------------ ---------------- -------------- -------------------- -------------- ---------------
--           220               320          242              348              1                    1              0              28



DBA_REGISTRY

set time on timi on

     COL COMP_NAME FORMAT A60
     COL VERSION FORMAT A14
      set pagesize 100
    set lin 240 

     SELECT COMP_ID, COMP_NAME, VERSION, STATUS
      FROM DBA_REGISTRY;



--COMP_ID         COMP_NAME                           VERSION        STATUS
----------------- ----------------------------------- -------------- -----------
--CATALOG         Oracle Database Catalog Views       19.0.0.0.0     VALID
--CATPROC         Oracle Database Packages and Types  19.0.0.0.0     VALID
--RAC             Oracle Real Application Clusters    19.0.0.0.0     VALID
--JAVAVM          JServer JAVA Virtual Machine        19.0.0.0.0     VALID
--XML             Oracle XDK                          19.0.0.0.0     VALID
--CATJAVA         Oracle Database Java Packages       19.0.0.0.0     VALID
--APS             OLAP Analytic Workspace             19.0.0.0.0     VALID
--XDB             Oracle XML Database                 19.0.0.0.0     VALID
--OWM             Oracle Workspace Manager            19.0.0.0.0     VALID
--CONTEXT         Oracle Text                         19.0.0.0.0     VALID
--ORDIM           Oracle Multimedia                   19.0.0.0.0     VALID
--SDO             Spatial                             19.0.0.0.0     VALID
--XOQ             Oracle OLAP API                     19.0.0.0.0     VALID
--OLS             Oracle Label Security               19.0.0.0.0     VALID
--DV              Oracle Database Vault               19.0.0.0.0     VALID






--SELECT partition_name, 
--       segment_name AS "TABLE_NAME", 
--       SUM(BYTES) AS "[Bytes]", 
--       SUM(BYTES) / 1024 AS "[Kb]", 
--       SUM(BYTES) / (1024*1024) AS "[Mb]", 
--       SUM(BYTES) / (1024*1024*1024) AS "[Gb]"
--FROM dba_segments 
--WHERE segment_name = 'LOC_MOVIMIENTO_CUENTA' 
-- -- AND segment_type = 'TABLE PARTITION' 
--GROUP BY partition_name, segment_name;
--