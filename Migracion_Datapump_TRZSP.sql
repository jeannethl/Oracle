Migracion TRZSP

Servidor sun1120p a plbdtrz01

+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
	Resumen:
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
Origen
01.- Actividades Previas
01.1- Verificar y Crear Directories (ORIGEN)
01.1.1.- verificar_directories 
01.1.2.- crear_directory
01.2 Correr Estadisticas (DIA)

Destino
01.3.- Crear un Backup Offline en el destino.
01.4.- Desactivar archive logs en el destino.
01.4.1.- verificar y desactivar el flashback
01.4.2.- verificar y desactivar los archivelogs.
01.5.- Verificar Tablespaces
01.6- Verificar y Crear Directories (DESTINO)
01.6.1.- verificar_directories 
01.6.2.- crear_directory


+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
02.- Actividades en el origen +*Export*+ (SUN1120P)
Export:
02.1.- Crear_Parfiles_EXPDP
02.1.1.- Parfile_EXPDP_FULL (excluyendo TABLE=DOEREXTMSG)
02.1.2.- Parfile_EXPDP_DOEREXTMSG
02.2 Ejecucion_Parfiles_Verificacion_Workers
02.2.1 EXPDP_FULL
02.2.1 EXPDP_DOEREXTMSG
02.3 Monitoreo
02.3.1 Tablas en el LOG
02.3.2 S.O
02.3.3 Monitoreo de las long_operations



+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
03.- Actividades en el destino +*Import*+ (PLBDTRZ01)
Import
03.1. Crear_Parfiles_IMPDP
03.1..- Parfile_metadata_indices
03.1..- Parfile_metadata_constraints
03.1..- Parfile_metadata_FULL
03.1..- Parfile_metadata_DOEREXTMSG
03.1..- Parfile_data_FULL
03.1..- Parfile_data_DOEREXTMSG
03.2.- Ejecucion_Parfiles_Verificacion_Workers_IDX_CONST
03.3.- Modificar las salidas .sql de los archivos de metadata generados.




+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +

01.- Actividades Previas
Origen

01.1- Verificar y Crear Directories (ORIGEN)

01.1.1.- verificar_directories 

df -k

>sql

SET LINE 400
COL OWNER FORMAT A25
COL DIRECTORY_NAME FORMAT A30
COL DIRECTORY_PATH FORMAT A100
SELECT OWNER, DIRECTORY_PATH, DIRECTORY_NAME FROM DBA_DIRECTORIES
/


01.1.2.- crear_directory

--CREATE DIRECTORY NAME_DIRECTORY AS 'RUTA';
--GRANT READ,WRITE ON DIRECTORY NAME_DIRECTORY TO SYSTEM;

CREATE DIRECTORY MIGRACION_FULL AS '/Migracion3/TRZS';
GRANT READ,WRITE ON DIRECTORY MIGRACION_FULL TO SYSTEM;

--OWNER  DIRECTORY_PATH      DIRECTORY_NAME
-------- ------------------- --------------
--SYS    /Migracion3/TRZS    MIGRACION_FULL

01.2 Correr Estadisticas

**Por las preubas de EXPDP realizadas se llegó al punto en que las estadisticas
deben ser actualizadas antes de correr los archivos parfiles ya que estos estan
relacionados con las trazas las cuales permiten que trabajen mas workers y los 
mismos implementen paralelismo lo que optimiza los tiempos de ejecucion del expdp**

cd /Migracion3/TRZS/scripts

sqlplus / as sysdba @estadisticas.sql

--exec DBMS_STATS.GATHER_SYSTEM_STATS;
--exec DBMS_STATS.GATHER_DICTIONARY_STATS(Degree=> 64);
--exec dbms_stats.lock_table_stats (null,'X$KCCLH');
--exec DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;
--EXEC DBMS_STATS.gather_database_stats(Degree=> 64, cascade => TRUE,estimate_percent =>dbms_stats.auto_sample_size, gather_sys=>true);





01.3.- Crear un Backup_offline en el destino.
	haber Creado Tablespaces (Con el mismo espacio) - modificar los UNDOTBS2 y UNDOTBS3 rbd_token
	crear los directorios definitivos


01.4.- Desactivar archive log en el destino. *(listo)

01.4.1.- verificar y desactivar el flashback
	
	sql>

SELECT flashback_on FROM v$database;

ALTER DATABASE FLASHBACK OFF;


01.4.2.- verificar y desactivar los archivelogs.
	
	sql>

archive log list;

shutdown immediate;

startup mount;

alter database noarchivelog;

alter database open;

archive log list;



01.5.- Verificar y Aumentar Tablespaces

01.5.1.- verificar tablespaces

cd /Migracion3/TRZS/scripts

--vi verificar_tbs
--
SELECT a.TABLESPACE_NAME "Name",
       ROUND((a.BYTES / 1024) / 1024, 2) "Size (MB)",
       ROUND((((a.BYTES - NVL(b.BYTES, 0)) / 1024) / 1024), 2) "Used (MB)",
       ROUND((NVL(b.BYTES, 0) / 1024) / 1024, 2) "Free (MB)",
       ROUND(CASE 
                 WHEN a.BYTES = 0 THEN 0 
                 ELSE (100 - (((a.BYTES - NVL(b.BYTES, 0)) / a.BYTES) * 100)) 
              END, 2) "% Free"
FROM (SELECT TABLESPACE_NAME, 
             SUM(BYTES) BYTES 
      FROM dba_data_files 
      GROUP BY TABLESPACE_NAME
      UNION ALL
      SELECT TABLESPACE_NAME, 
             SUM(BYTES) BYTES 
      FROM dba_temp_files 
      GROUP BY TABLESPACE_NAME) a
LEFT JOIN (SELECT TABLESPACE_NAME, 
                  SUM(BYTES) BYTES 
           FROM dba_free_space 
           GROUP BY TABLESPACE_NAME
           UNION ALL
           SELECT TABLESPACE_NAME, 
                  SUM(BYTES_FREE) BYTES 
           FROM v$temp_space_header 
           GROUP BY TABLESPACE_NAME) b
ON a.TABLESPACE_NAME = b.TABLESPACE_NAME
ORDER BY 5 DESC;


sqlplus / as sysdba @verificar_tbs

01.5.2.- aumentar tablespace

--ALTER TABLESPACE NAME_TBS ADD DATAFILE '+NAME_DISCKGROUP' SIZE 32767M AUTOEXTEND OFF;

	sql>

ALTER TABLESPACE UNDOTBS1 ADD DATAFILE '+DATA_TRZSP' SIZE 32767M AUTOEXTEND OFF;

--O armar un .sql con la cantidad de datafiles necesario (en este caso eran necesarios 750GB) hacerlo para UNDOTBS2 y UNDOTBS3 
--cd /Migracion3/TRZS/scripts
--sqlplus / as sysdba @aumentar_tbs






spool 10_add_datafiles_tbs.sql
SET SERVEROUTPUT ON
DECLARE v_name_tablespace   VARCHAR2(300);
        v_size              NUMBER;
        v_cant_datafile     NUMBER;
        v_sentence          VARCHAR2(1000);

    CURSOR cur_datafile IS
        SELECT TABLESPACE_NAME
		, SUM(BYTES/1024/1024/1024) SIZE_GB
		, CASE ROUND(SUM(BYTES/1024/1024/1024)/30, 0) 
			WHEN 0 THEN 1
			ELSE ROUND(SUM(BYTES/1024/1024/1024)/30, 0) END CANT_DATAFILE
		FROM  DBA_DATA_FILES
		WHERE TABLESPACE_NAME NOT IN ('SYSTEM',
		'SYSAUX',
		'UNDOTBS1',
		'UNDOTBS2',
		'UNDOTBS3',
		'TEMP',
		'USERS')
		GROUP BY TABLESPACE_NAME
		HAVING SUM(BYTES/1024/1024/1024) BETWEEN 31 AND 64;
    row_cur_datafile cur_datafile%ROWTYPE;

BEGIN 
    OPEN cur_datafile;
    FETCH cur_datafile INTO row_cur_datafile;
    WHILE cur_datafile%FOUND
    LOOP
        v_name_tablespace   := row_cur_datafile.TABLESPACE_NAME;
        v_size              := row_cur_datafile.SIZE_GB;


        DBMS_OUTPUT.PUT_LINE('ALTER TABLESPACE ' || v_name_tablespace || ' ADD DATAFILE ' || CHR(39) || '+DATA_TRZSP' || CHR(39) || ' SIZE 32767M AUTOEXTEND OFF;');
        DBMS_OUTPUT.PUT_LINE('ALTER TABLESPACE ' || v_name_tablespace || ' ADD DATAFILE ' || CHR(39) || '+DATA_TRZSP' || CHR(39) || ' SIZE 32767M AUTOEXTEND OFF;');

        DBMS_OUTPUT.PUT_LINE(CHR(10));
    FETCH cur_datafile INTO row_cur_datafile;
    END LOOP;
    CLOSE cur_datafile;
END;
/
spool off;










01.6- Verificar y Crear Directories (DESTINO)

01.6.1.- verificar_directories 
df -k

>sql

SET LINE 400
COL OWNER FORMAT A25
COL DIRECTORY_NAME FORMAT A30
COL DIRECTORY_PATH FORMAT A100
SELECT OWNER, DIRECTORY_PATH, DIRECTORY_NAME FROM DBA_DIRECTORIES
/


01.6.2.- crear_directory

CREATE DIRECTORY MIGRACION_FULL AS '/Migracion3/TRZS';
GRANT READ,WRITE ON DIRECTORY MIGRACION_FULL TO SYSTEM;



+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +


02.- Actividades en el origen +*Export*+ (SUN1120P)


02.1.- Crear_Parfiles_EXPDP

02.1.1.- Parfile_EXPDP_FULL (excluyendo TABLE=DOEREXTMSG)

vi parfile_expdp_full_TRZS_v4.par

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=EXPDP_FULL_TRZS_1.LOG
DUMPFILE=EXP_FULL_TRZS_%L.dmp
LOGTIME=ALL
METRICS=Y
PARALLEL=59
CLUSTER=N
#TRACE=1ff0300
EXCLUDE=AUDIT_TRAILS
EXCLUDE=STATISTICS
EXCLUDE=TABLE:"IN('DOEREXTMSG')"
EXCLUDE=TABLE:"IN('RDX_EVENTLOG')"
--FILESIZE=10G
EXCLUDE=PROCOBJ


02.1.2.- Parfile_EXPDP_DOEREXTMSG

vi parfile_expdp_table_doerextmsg.par

DIRECTORY=MIGRACION_FULL
DUMPFILE=EXP_DOEREXTMSG_TRZS_%T_%L.dmp
LOGFILE=EXPDP_DOEREXTMSG_TRZS_3.LOG
TABLES=TX.DOEREXTMSG
PARALLEL=58
LOGTIME=ALL
TRACE=1ff0300
METRICS=Y
CLUSTER=N
EXCLUDE=STATISTICS

vi parfile_expdp_table_doerextmsg_with_trace.par
DIRECTORY=MIGRACION_FULL
DUMPFILE=EXP_DOEREXTMSG_TRZS_%T_%L.dmp
LOGFILE=EXPDP_DOEREXTMSG_TRZS_3.LOG
TABLES=TX.DOEREXTMSG
PARALLEL=58
LOGTIME=ALL
TRACE=1ff0300
METRICS=Y
CLUSTER=N
EXCLUDE=STATISTICS



parfile RDX_EVENTLOG

vi parfile_expdp_metadata_rdx_eventlog.par
DIRECTORY=MIGRACION_FULL
DUMPFILE=EXP_RDX_EVENTLOG_TRZS_%T_%L.dmp
LOGFILE=EXPDP_RDX_EVENTLOG_TRZS.LOG
TABLES=TX.RDX_EVENTLOG
PARALLEL=10
LOGTIME=ALL
METRICS=Y
CLUSTER=N
EXCLUDE=STATISTICS
CONTENT=METADATA_ONLY

PARFILE BALANCE_HIST

vi parfile_expdp_table_balancehist.par
DIRECTORY=MIGRACION_FULL
DUMPFILE=EXP_BALANCEHIST_TRZS_%L.dmp
LOGFILE=EXPDP_BALANCEHIST_TRZS_.LOG
TABLES=TX.BALANCEHIST
PARALLEL=58
LOGTIME=ALL
METRICS=Y
CLUSTER=N
EXCLUDE=STATISTICS
FILESIZE=2G



02.2.- Ejecucion_Parfiles_Verificacion_Workers

02.2.1.- EXPDP_FULL

nohup expdp system/bdv23ccs2 parfile=parfile_expdp_full_TRZS_v4.par &

expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_FULL_01
-- status
-- kill_job

02.2.1.- EXPDP_DOEREXTMSG

--nohup expdp system/bdv23ccs2 parfile=parfile_expdp_table_doerextmsg_with_trace.par &
nohup expdp system/bdv23ccs2 parfile=parfile_expdp_table_doerextmsg.par &

expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_TABLE_01

**********
02.2.1.- EXPDP_METADATA_RDX_EVENTLOG

nohup expdp system/bdv23ccs2 parfile=parfile_expdp_metadata_rdx_eventlog.par &

expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_TABLE_01


parfile_expdp_table_doerextmsg.par

02.3.- Monitoreo

02.3.1.- Tablas en el LOG

--while true; do egrep -i TABLA ARCHIVO.LOG; sleep 60; clear; done
--
--while true; do egrep -i POSTING EXPDP_FULL_TRZS_v4_1.LOG; sleep 60; clear; done
--while true; do egrep -i TRAN_2024_ EXPDP_FULL_TRZS_v4_3.LOG; sleep 60; clear; done
--while true; do egrep -i DOER_2024 EXPDP_FULL_TRZS_v4_3.LOG; sleep 60; clear; done
--while true; do egrep -i BATCH EXPDP_FULL_TRZS_v4_1.LOG; sleep 60; clear; done


02.3.2.- S.O

vmstat 5 1000000
 
while true; do iostat -d -x 2 2 | sort -n -k 11; sleep 5; echo ------- ; done

02.3.3.- Monitoreo de las long_operations

cd /Migracion3/TRZS/scripts/Monitoreo
sqlplus / as sysdba @show_long_operations





+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +

03.- Actividades en el destino +*Import*+ (PLBDTRZ01)

MIGRACION_FULL

MIGRACION_DOEREXTMSG


03.1.- Crear_Parfiles_IMPDP

03.1.1.- Parfile_metadata_indices_FULL

vi parfile_extract_ddl_index.par

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_DLL_INDEX_TRZSP_1.LOG
DUMPFILE=EXP_FULL_TRZS_20240914_%U.dmp
SQLFILE=ddl_index_trzsp_full.sql
METRICS=YES
PARALLEL=100
INCLUDE=INDEX
CLUSTER=N
LOGTIME=ALL


03.1.2.- Parfile_metadata_indices_DOEREXTMSG

vi parfile_extract_ddl_index_dem.par

DIRECTORY=MIGRACION_DOEREXTMSG
FULL=Y
LOGFILE=IMP_DLL_INDEX_TRZSP_DEM.LOG
DUMPFILE=EXP_DOEREXTMSG_TRZS_20240914_%U.dmp
SQLFILE=ddl_index_trzsp_dem.sql
METRICS=YES
PARALLEL=100
INCLUDE=INDEX
CLUSTER=N
LOGTIME=ALL


***

Parfile_metadata_indices_BALANCEHIST

vi parfile_extract_ddl_index_balancehist.par

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_DLL_INDEX_TRZSP_BH.LOG
DUMPFILE=EXP_BALANCEHIST_TRZS_%L.dmp
SQLFILE=ddl_index_trzsp_balancehist.sql
METRICS=YES
PARALLEL=100
INCLUDE=INDEX
CLUSTER=N
LOGTIME=ALL

**

Parfile_metadata_indices_RDX_JS_THREADEDJOBPARAM

vi parfile_extract_ddl_index_thread.par

DIRECTORY=MIGRACION_FULL
LOGFILE=IMP_DDL_INDEX_TRZSP_THREAD.LOG
DUMPFILE=EXP_FULL_TRZS_%L.dmp
SQLFILE=ddl_index_trzsp_full_21.sql
METRICS=YES
PARALLEL=100
INCLUDE=INDEX
CLUSTER=N
INCLUDE=INDEX:"IN('PK_RDX_JS_THREADEDJOBPARAM')"

****
Parfile_metadata_indices_IDX_RDX_JS_THREADEDJOB_NEXT

vi parfile_extract_ddl_index_IDX_RDX_JS_THREADEDJOB_NEXT.par

DIRECTORY=MIGRACION_FULL
LOGFILE=IMP_DDL_INDEX_TRZSP_IDX_RDX_JS_THREADEDJOB_NEXT.LOG
DUMPFILE=EXP_FULL_TRZS_%L.dmp
SQLFILE=ddl_index_trzsp_full_23.sql
METRICS=YES
PARALLEL=100
INCLUDE=INDEX:"IN('IDX_RDX_JS_THREADEDJOB_NEXT')"
CLUSTER=N
******
Parfile_metadata_indices_PK_RDX_JS_THREADEDJOB

vi parfile_extract_ddl_index_PK_RDX_JS_THREADEDJOB.par

DIRECTORY=MIGRACION_FULL
LOGFILE=IMP_DDL_INDEX_TRZSP_PK_RDX_JS_THREADEDJOB.LOG
DUMPFILE=EXP_FULL_TRZS_%L.dmp
SQLFILE=ddl_index_trzsp_full_24.sql
METRICS=YES
PARALLEL=100
INCLUDE=INDEX:"IN('PK_RDX_JS_THREADEDJOB')"
CLUSTER=N

IDX_RDX_JS_THREADEDJOB_NEXT
PK_RDX_JS_THREADEDJOB

INCLUDE=INDEX:"IN('PK_BALANCEHIST')"

INCLUDE=INDEX:"IN('IDX_BALANCEHIST_ACCOUNT')"

IDX_RDX_JS_THREADEDJOB_NEXT
PK_RDX_JS_THREADEDJOB

**
03.1.3.- Parfile_metadata_constraints_FULL

vi parfile_extract_ddl_constraint.par

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_DLL_CONSTRAINT_TRZSP_1.LOG
DUMPFILE=EXP_FULL_TRZS_20240914_%U.dmp
SQLFILE=ddl_constraint_trzsp_full.sql
METRICS=YES
PARALLEL=100
INCLUDE=CONSTRAINT
CLUSTER=N
LOGTIME=ALL


03.1.3.- Parfile_metadata_constraints_DOEREXTMSG

vi parfile_extract_ddl_constraint_dem.par

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_DLL_CONSTRAINT_TRZSP_DEM.LOG
DUMPFILE=EXP_DOEREXTMSG_TRZS_20240914_%U.dmp
SQLFILE=ddl_constraint_trzsp_dem.sql
METRICS=YES
PARALLEL=100
INCLUDE=CONSTRAINT
CLUSTER=N
LOGTIME=ALL

***


Parfile_metadata_constraints_BALANCEHIST

vi parfile_extract_ddl_constraint_balancehist.par

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_DLL_CONSTRAINT_TRZSP_BH.LOG
DUMPFILE=EXP_BALANCEHIST_TRZS_%L.dmp
SQLFILE=ddl_constraint_trzsp_balancehist.sql
METRICS=YES
PARALLEL=100
INCLUDE=CONSTRAINT
CLUSTER=N
LOGTIME=ALL


***


03.1..- Parfile_metadata_FULL

vi parfile_imp_metadata.par

--DIRECTORY=MIGRACION_FULL
--FULL=Y
--LOGFILE=IMP_METADATA_TRZS_2.LOG
--DUMPFILE=EXP_FULL_TRZS_20240914_%U.dmp
--METRICS=YES
--PARALLEL=100
--EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS,TABLESPACE
--CONTENT=METADATA_ONLY
--LOGTIME=ALL

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_METADATA_TRZS_4.LOG
DUMPFILE=EXP_FULL_TRZS_20240914_%U.dmp
METRICS=YES
PARALLEL=50
EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS,TABLESPACE
CONTENT=METADATA_ONLY
LOGTIME=ALL

03.1..- Parfile_metadata_DOEREXTMSG

vi parfile_imp_metadata_dem.par

--DIRECTORY=MIGRACION_DOEREXTMSG
--FULL=Y
--LOGFILE=IMP_METADATA_DEM_2.LOG
--DUMPFILE=EXP_DOEREXTMSG_TRZS_20240914_%U.dmp
--METRICS=YES
--PARALLEL=100
--EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS,TABLESPACE
--CONTENT=METADATA_ONLY
--LOGTIME=ALL

DIRECTORY=MIGRACION_DOEREXTMSG
FULL=Y
LOGFILE=IMP_METADATA_DEM_4.LOG
DUMPFILE=EXP_DOEREXTMSG_TRZS_20240914_%U.dmp
METRICS=YES
PARALLEL=100
EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS,TABLESPACE
CONTENT=METADATA_ONLY
LOGTIME=ALL



**** parfile_metadata_balancehist

vi parfile_imp_metadata_balancehist.par

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_METADATA_BH_1.LOG
DUMPFILE=EXP_BALANCEHIST_TRZS_%L.dmp
METRICS=YES
PARALLEL=100
EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS,TABLESPACE
CONTENT=METADATA_ONLY
LOGTIME=ALL





03.1..- Parfile_data_FULL

vi parfile_imp_data.par

--DIRECTORY=MIGRACION_FULL
--FULL=Y
--LOGFILE=IMP_DATA_TRZS_2.LOG
--DUMPFILE=EXP_FULL_TRZS_20240914_%U.dmp
--METRICS=YES
--PARALLEL=100
--EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS
--CONTENT=DATA_ONLY
--CLUSTER=N

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_DATA_TRZS_4.LOG
DUMPFILE=EXP_FULL_TRZS_20240914_%U.dmp
METRICS=YES
PARALLEL=100
EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS
CONTENT=DATA_ONLY
CLUSTER=N
LOGTIME=ALL


03.1..- Parfile_data_DOEREXTMSG

vi parfile_imp_data_dem.par

--DIRECTORY=MIGRACION_DOEREXTMSG
--FULL=Y
--LOGFILE=IMP_DATA_DEM_TRZS_1.LOG
--DUMPFILE=EXP_DOEREXTMSG_TRZS_20240914_%U.dmp
--METRICS=YES
--PARALLEL=100
--EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS
--CONTENT=DATA_ONLY
--CLUSTER=N

DIRECTORY=MIGRACION_DOEREXTMSG
FULL=Y
LOGFILE=IMP_DATA_DEM_TRZS_4.LOG
DUMPFILE=EXP_DOEREXTMSG_TRZS_20240914_%U.dmp
METRICS=YES
PARALLEL=50
EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS
CONTENT=DATA_ONLY
CLUSTER=N


vi parfile_imp_data_balancehist.par

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_DATA_BH_TRZS_1.LOG
DUMPFILE=EXP_BALANCEHIST_TRZS_%L.dmp
METRICS=YES
PARALLEL=50
EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS
CONTENT=DATA_ONLY
CLUSTER=N



******
********
*********

parfile index_balancehist

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_DDL_INDEX_TRZSP_BALHIST.LOG
DUMPFILE=EXP_INDEX_BALHIST_TRZS_%L.dmp
SQLFILE=ddl_index_trzsp_balhist.sql
METRICS=YES
PARALLEL=100
INCLUDE=INDEX
CLUSTER=N
LOGTIME=ALL


03.2.- Ejecucion_Parfiles_Verificacion_Workers_IDX_CONST

Indices
*full
nohup impdp system/oracle1 parfile=parfile_extract_ddl_index.par &
impdp system/oracle1 ATTACH=SYS_SQL_FILE_FULL_01

*doer
nohup impdp system/oracle1 parfile=parfile_extract_ddl_index_dem.par &
impdp system/oracle1 ATTACH=SYS_SQL_FILE_FULL_01


hacer un get_ddl para sacar los constraints
Constraints
*full
nohup impdp system/oracle1 parfile=parfile_extract_ddl_constraint.par &
impdp system/oracle1 ATTACH=SYS_SQL_FILE_FULL_01

*doer
nohup impdp system/oracle1 parfile=parfile_extract_ddl_constraint_dem.par &
impdp system/oracle1 ATTACH=SYS_SQL_FILE_FULL_01



03.3.- Modificar las salidas .sql de los archivos de metadata generados.

sed -i 's/PARALLEL 8/PARALLEL 4/' ddl_index_trzsp_full_*.sql --Aumentar Paralelismo
sed -i 's/PARALLEL 1/PARALLEL 8/' ddl_index_trzsp_dem.sql --Aumentar Paralelismo

sed -i 's/ENABLE/ ENABLE NOVALIDATE/' ddl_constraint_trzsp_full.sql --NoValidate
sed -i 's/ENABLE/ ENABLE NOVALIDATE/' ddl_constraint_trzsp_dem.sql --NoValidate

sed -i 's/ ENABLE/  ENABLE NOVALIDATE)/' 07_constraints_faltantes_C.sql --NoValidate



ALTER SYSTEM FLUSH SHARED_POOL;

03.4.- Ejecucion_Parfiles_Verificacion_Workers_METADATA



FULL
nohup impdp system/oracle1 parfile=parfile_imp_metadata.par &
tail -1000f nohup.out
impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01


DOEREXTMSG
nohup impdp system/oracle1 parfile=parfile_imp_metadata_dem.par &
impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01





03.5.- Verificar y Deshabilitar Triggers.

03.5.1.- Verificar Triggers enable existentes

	sql>

	COL OWNER FORMAT A30
	COL TRIGGER_NAME FORMAT A30
	COL TABLE_NAME FORMAT A30
	COL TRIGGERING_EVENT FORMAT A40
	SELECT OWNER, TRIGGER_NAME, TABLE_NAME, STATUS, TRIGGER_TYPE, TRIGGERING_EVENT
	FROM ALL_TRIGGERS
	WHERE OWNER = 'TX'
	AND STATUS = 'ENABLED';



03.5.2.- Deshabilitar Triggers

cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG

sqlplus / as sysdba @01_disable_trigger.sql

--vi disabled_triggers.sql
--
--spool Disabled_Triggers.lst 
--
--SET SERVEROUTPUT ON
--DECLARE v_sentence    VARCHAR2(500);
--BEGIN
--FOR t IN (SELECT OWNER, TRIGGER_NAME, TABLE_NAME, STATUS, TRIGGER_TYPE, TRIGGERING_EVENT
--FROM ALL_TRIGGERS
--WHERE OWNER = 'TX'
--AND STATUS = 'ENABLED')
--  LOOP
--    BEGIN
--      v_sentence := 'ALTER TRIGGER ' || t.OWNER || '.' || t.TRIGGER_NAME || ' DISABLE;';
--      DBMS_OUTPUT.PUT_LINE(v_sentence);
--    EXCEPTION WHEN OTHERS THEN
--      NULL;
--    END;
--  END LOOP;
--END;
--/
--
--spool off;
--
--- - - -
-- sqlplus / as sysdba @03_Disabled_Triggers.sql
-- 
-- 	sql>
-- 	SET SERVEROUTPUT ON
-- 	DECLARE v_sentence    VARCHAR2(500);
-- 	BEGIN
-- 	FOR t IN (SELECT OWNER, TRIGGER_NAME, TABLE_NAME, STATUS, TRIGGER_TYPE, TRIGGERING_EVENT
-- 	FROM ALL_TRIGGERS
-- 	WHERE OWNER = 'TX'
-- 	AND STATUS = 'ENABLED')
-- 	  LOOP
-- 	    BEGIN
-- 	      v_sentence := 'ALTER TRIGGER ' || t.OWNER || '.' || t.TRIGGER_NAME || ' DISABLED;';
-- 	      DBMS_OUTPUT.PUT_LINE(v_sentence);
-- 	    EXCEPTION WHEN OTHERS THEN
-- 	      NULL;
-- 	    END;
-- 	  END LOOP;
-- 	END;
-- 	/





03.5.2.- Preparar querys para rollback de Triggers

--**La salida del paso anterior modificarla y cambiar la palabra disabled por enable.(Sublime)**

cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG

02_enable_trigger.sql



03.6.- CREAR Trigger DML_PARALLEL @04trigger_dml

CREATE OR REPLACE TRIGGER enable_parallel_dml_trigger
AFTER LOGON ON DATABASE
BEGIN
EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
END;




--03.7.- Hablitar parallel tabñas DOER y TRAN
--
--ALTER TABLE TX.TRAN PARALLEL 16;
--ALTER TABLE TX.DOER PARALLEL 16;





03.8.- Ejecucion_Parfiles_Verificacion_Workers_DATA

FULL
nohup impdp system/oracle1 parfile=parfile_imp_data.par &

impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01


DOEREXTMSG
nohup impdp system/oracle1 parfile=parfile_imp_data_dem.par &

impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01


03.9.- Habilitar Triggers

cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG

sqlplus / as sysdba @02_enable_trigger.sql



03.10.- Ejecutar archivo .sql de indexes y constraints

cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG

Indices

FULL

sqlplus / as sysdba @03_ddl_index_trzsp_full.sql

DOEREXTMSG

sqlplus / as sysdba @04_ddl_index_trzsp_dem.sql


Constraints 

FULL

sqlplus / as sysdba @05_ddl_constraint_trzsp_full.sql

DOEREXTMSG

sqlplus / as sysdba @06_ddl_constraint_trzsp_dem.sql


03.10.1.- drop indexes y constraints

cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG


Indices 
drop_index
sqlplus / as sysdba @.sql


Constraints
drop_constraint
sqlplus / as sysdba @.sql



04. Validar y Compilar objetos invalidos

cd /Migracion3/TRZSP/scripts

vi objetos_invalidos.sql

COLUMN object_name FORMAT A50
column OWNER format a30
set pagesize 1000
SELECT owner
      ,object_type
      ,object_name
      ,status
 FROM dba_objects
WHERE status = 'INVALID'
ORDER BY owner, object_type, object_name;


sqlplus / as sysdba @objetos_invalidos



Compilar objetos_invalidos

@?/rdbms/admin/utlrp


Compilar manualmente objetos invalidos 

GRANT EXECUTE ON DBMS_CRYPTO TO TX;
ALTER PACKAGE TX.CRYPTO COMPILE BODY; ---746/13   PLS-00201: identifier 'DBMS_CRYPTO' must be declared


GRANT EXECUTE ON SYS.DBMS_NETWORK_ACL_ADMIN TO TX;
GRANT EXECUTE ON SYS.DBMS_LOCK TO TX;
ALTER PACKAGE TX.RDX_SOAP COMPILE BODY; 

-----368/18   PLS-00201: identifier 'SYS.DBMS_NETWORK_ACL_ADMIN' must be

GRANT EXECUTE ON SYS.DBMS_SYSTEM TO BACKOFFICE;
ALTER PACKAGE BACKOFFICE.MAINTENANCE COMPILE BODY;


ALTER PROCEDURE BACKOFFICE.MANTPARTITIONS COMPILE;



CREATE OR REPLACE PROCEDURE KILL_DB_SESSION_SYS(sid IN integer, serial# IN integer, inst_id IN integer)
IS
BEGIN
EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION '''||sid||','||serial#||',@'||inst_id||''' immediate';
END;
/

GRANT EXECUTE ON KILL_DB_SESSION_SYS TO TX;
GRANT EXECUTE ON KILL_DB_SESSION_SYS TO TX_RUN_ROLE;


CREATE OR REPLACE PROCEDURE TX.KILL_DATABASE_SESSION(sid IN integer, serial# IN integer, inst_id IN integer)
IS
BEGIN
SYS.KILL_DB_SESSION_SYS(sid, serial#, inst_id);
END;
/


ALTER PACKAGE TX.RDX_ARTE COMPILE BODY; ----255/38   PL/SQL: ORA-00942: table or view does not exist

ALTER PACKAGE TX.RDX_ARTE_UTILS COMPILE BODY; ---- 97/117   PL/SQL: ORA-00942: table or view does not exist

ALTER PACKAGE TX.RDX_LOCK COMPILE BODY; --84/43    PL/SQL: ORA-00942: table or view does not exist
GRANT EXECUTE ON DBMS_LOCK TO TX;

ALTER PACKAGE TX.RDX_UTILS COMPILE BODY;----312/51   PL/SQL: ORA-00942: table or view does not exist

ALTER PACKAGE TX.TRANSACTIONS COMPILE BODY; ---841/36   PL/SQL: ORA-00942: table or view does not exist

ALTER PACKAGE TX.TRANSACTIONSMAINTENANCE COMPILE BODY; ----440/90   PL/SQL: ORA-00942: table or view does not exist


ALTER PROCEDURE TX.KILL_DATABASE_SESSION COMPILE; ---4/1      PLS-00201: identifier 'SYS.KILL_DB_SESSION_SYS' must be declared
GRANT EXECUTE ON SYS.KILL_DB_SESSION_SYS TO TX;





SET LINESIZE 300
COL OWNER FORMAT A10 
COL REFERENCED_OWNER FORMAT A20
COL REFERENCED_NAME FORMAT A30
COL REFERENCED_TYPE FORMAT A20
COL DEPENDENCY_TYPE FORMAT A20
COL NAME FORMAT A50
SELECT OWNER 
, NAME 
, TYPE
, REFERENCED_OWNER
, REFERENCED_NAME
, REFERENCED_TYPE
, DEPENDENCY_TYPE
FROM DBA_DEPENDENCIES
WHERE NAME = 'RDX_ARTE'
/

OWNER      NAME                                               TYPE                REFERENCED_OWNER     REFERENCED_NAME                REFERENCED_TYPE      DEPENDENCY_TYPE
---------- -------------------------------------------------- ------------------- -------------------- ------------------------------ -------------------- --------------------
TX         RDX_ARTE                                           PACKAGE             SYS                  STANDARD                       PACKAGE              HARD
TX         RDX_ARTE                                           PACKAGE BODY        SYS                  STANDARD                       PACKAGE              HARD
TX         RDX_ARTE                                           PACKAGE BODY        SYS                  DBMS_STANDARD                  PACKAGE              HARD
TX         RDX_ARTE                                           PACKAGE BODY        PUBLIC               V$SESSION                      SYNONYM              HARD
TX         RDX_ARTE                                           PACKAGE BODY        PUBLIC               DBMS_APPLICATION_INFO          SYNONYM              HARD
TX         RDX_ARTE                                           PACKAGE BODY        TX                   RDX_EASSESSION                 TABLE                HARD
TX         RDX_ARTE                                           PACKAGE BODY        TX                   SQN_RDX_ARTERQID               SEQUENCE             HARD
TX         RDX_ARTE                                           PACKAGE BODY        TX                   RDX_AC_USER                    TABLE                HARD
TX         RDX_ARTE                                           PACKAGE BODY        TX                   RDX_SYSTEM                     TABLE                HARD
TX         RDX_ARTE                                           PACKAGE BODY        TX                   RDX_ARTE                       PACKAGE              HARD
TX         RDX_ARTE                                           PACKAGE BODY        TX                   RDX_ARTE_VARS                  PACKAGE              HARD

OWNER      NAME                                               TYPE                REFERENCED_OWNER     REFERENCED_NAME                REFERENCED_TYPE      DEPENDENCY_TYPE
---------- -------------------------------------------------- ------------------- -------------------- ------------------------------ -------------------- --------------------
TX         RDX_ARTE                                           PACKAGE BODY        TX                   RDX_ENVIRONMENT                PACKAGE              HARD
TX         RDX_ARTE                                           PACKAGE BODY        TX                   RDX_ENVIRONMENT_VARS           PACKAGE              HARD
TX         RDX_ARTE                                           PACKAGE BODY        TX                   RDX_TRACE                      PACKAGE              HARD
TX         RDX_ARTE                                           PACKAGE BODY        TX                   RDX_UTILS                      PACKAGE              HARD
TX         RDX_ARTE                                           PACKAGE BODY        TX                   RDX_META_VARS                  PACKAGE              HARD





verificasr cantidad de objetos en la base en la base de datos origen y destino


prompt DB_ORIGEN
SELECT 
    (SELECT COUNT(1) FROM dba_indexes@TRZSP_SUN 		where owner = 'TX') AS total_indices,
    (SELECT COUNT(1) FROM dba_constraints@TRZSP_SUN 	where owner = 'TX') AS total_constraints,
    (SELECT COUNT(1) FROM dba_tables@TRZSP_SUN 		where owner = 'TX') AS total_tables,
    (SELECT COUNT(1) FROM dba_procedures@TRZSP_SUN	where owner = 'TX') AS total_procedures,
    (SELECT COUNT(1) FROM dba_objects@TRZSP_SUN 		where owner = 'TX' AND object_type = 'PACKAGE') AS total_packages,
    (SELECT COUNT(1) FROM dba_objects@TRZSP_SUN 		where owner = 'TX' and object_type = 'PACKAGE BODY') AS total_package_bodies,
    (SELECT COUNT(1) FROM dba_synonyms@TRZSP_SUN 		where owner = 'TX') AS total_synonyms,
    (SELECT COUNT(1) FROM dba_sequences@TRZSP_SUN 	where SEQUENCE_OWNER = 'TX') AS total_sequences
FROM dual;


prompt BD_DESTINO
SELECT 
    (SELECT COUNT(1) FROM dba_indexes 		where owner = 'TX') AS total_indices,
    (SELECT COUNT(1) FROM dba_constraints 	where owner = 'TX') AS total_constraints,
    (SELECT COUNT(1) FROM dba_tables 		where owner = 'TX') AS total_tables,
    (SELECT COUNT(1) FROM dba_procedures	where owner = 'TX') AS total_procedures,
    (SELECT COUNT(1) FROM dba_objects 		where owner = 'TX' AND object_type = 'PACKAGE') AS total_packages,
    (SELECT COUNT(1) FROM dba_objects 		where owner = 'TX' and object_type = 'PACKAGE BODY') AS total_package_bodies,
    (SELECT COUNT(1) FROM dba_synonyms 		where owner = 'TX') AS total_synonyms,
    (SELECT COUNT(1) FROM dba_sequences 	where SEQUENCE_OWNER = 'TX') AS total_sequences
FROM dual;



trzsp_new

TOTAL_INDICES TOTAL_CONSTRAINTS TOTAL_TABLES TOTAL_PROCEDURES TOTAL_PACKAGES TOTAL_PACKAGE_BODIES TOTAL_SYNONYMS TOTAL_SEQUENCES
------------- ----------------- ------------ ---------------- -------------- -------------------- -------------- ---------------
         2225              5800          826             2387            108                  106              0             351

TOTAL_INDICES TOTAL_CONSTRAINTS TOTAL_TABLES TOTAL_PROCEDURES TOTAL_PACKAGES TOTAL_PACKAGE_BODIES TOTAL_SYNONYMS TOTAL_SEQUENCES
------------- ----------------- ------------ ---------------- -------------- -------------------- -------------- ---------------
         2225              7149          826             2388            108                  106              0             351

****hacer uno que saque la diferencia el minus****




****************************************** 01102024
******************************************

TOTAL_INDICES TOTAL_CONSTRAINTS TOTAL_TABLES TOTAL_PROCEDURES TOTAL_PACKAGES TOTAL_PACKAGE_BODIES TOTAL_SYNONYMS TOTAL_SEQUENCES
------------- ----------------- ------------ ---------------- -------------- -------------------- -------------- ---------------
         2225              6794          826             2387            108                  106              0             351

TOTAL_INDICES TOTAL_CONSTRAINTS TOTAL_TABLES TOTAL_PROCEDURES TOTAL_PACKAGES TOTAL_PACKAGE_BODIES TOTAL_SYNONYMS TOTAL_SEQUENCES
------------- ----------------- ------------ ---------------- -------------- -------------------- -------------- ---------------
         2225              7149          826             2388            108                  106              0             351





dblink

TRZSP_SUN =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = SUN011SCAN)(PORT = 1560))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = TRZSP)
    )
  )





TRZSP =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = LX001SCAN)(PORT = 1560))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = TRZSP)
    )
  )


--CREATE DATABASE LINK TRZSP_SUN
--CONNECT TO system IDENTIFIED BY bdv23ccs2
--USING '(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = SUN011SCAN)(PORT = 1560)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = TRZSP) ) )';




CREATE DATABASE LINK TRZSP_SUN
CONNECT TO system IDENTIFIED BY bdv23ccs2
USING 'TRZSP_SUN';



--SELECT * FROM dual@TRZSP_SUN;
--
--
-- drop database LINK TRZSP_SUN;
--
--
--
--
--CREATE DATABASE LINK TRZSP_SUN
--CONNECT TO system IDENTIFIED BY oracle1
--USING '(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = LX001SCAN)(PORT = 1560)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = TRZSP) ) ) ';
--
--SELECT * FROM dual@TRZSP_SUN;
--

SELECT COUNT(1) 
FROM dba_constraints 
where owner = 'TX';



SELECT COUNT(1) 
FROM dba_constraints@TRZSP_SUN 
where owner = 'TX';






SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM dba_constraints 
where owner = 'TX';



SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM dba_constraints@TRZSP_SUN 
where owner = 'TX';

--4155
set pagesize 5000
set linesize 300
col CONSTRAINT_NAME format A50
col owner format a10 
col CONSTRAINT_TYPE format a16
select count(1), CONSTRAINT_TYPE
from (
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM dba_constraints 
where owner = 'TX' and CONSTRAINT_NAME not like 'SYS_%'
minus
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM dba_constraints@TRZSP_SUN 
where owner = 'TX' and CONSTRAINT_NAME not like 'SYS_%'
)
GROUP by CONSTRAINT_TYPE; 


select count(1)
FROM dba_constraints@TRZSP_SUN 
where owner = 'TX' 
union all 
SELECT count(1)
FROM dba_constraints 
where owner = 'TX' 

  COUNT(1) CONSTRAINT_TYPE
---------- ----------------
         3 R
        17 O
      4151 C
         1 U




alter session force parallel dml parallel 4;
alter session force parallel query parallel 4;

  	SET LONG 200000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 10000000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
  	BEGIN
  	  DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
  	  DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
  	END;
  	/
  	spool ddl_constraint_trzsp_full.sql;
	select dbms_metadata.get_ddl('CONSTRAINT', CONSTRAINT_NAME, 'TX')
	from (
		SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE
		FROM dba_constraints 
		where owner = 'TX'
	minus
		SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE
		FROM dba_constraints@TRZSP_SUN 
		where owner = 'TX'
	) where CONSTRAINT_TYPE='C';
  	spool off


*********************************************************

homologacion 

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

       spool 12_exec_homologacion_permisologia.sql
       select 'spool 09_1_homologacion_permisologia.lst' from dual;
       select 'set timi on ' from dual;
       select 'set time on ' from dual;
       select ' ' from dual;

        select *
        from (
        select 'grant '||PRIVILEGE||' on '||OWNER||'.'||TABLE_NAME||' to '||GRANTEE||';' 
        from dba_tab_privs@TRZSP_SUN
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

        set heading on
        set feedback on 
        set verify on 
        set echo on
        set termout on 
        set timi on
        set time on

Ejecutar el script 

    homologacion_permisologia.sql







**********************************************************************
validacionusuarios
***********************************************************************
spool 16_validar_usuarios.lst 
        set timi on 
        set time on 

            ECHO 'estatus usuarios en SOURCE'

            select count(1)
                  ,ACCOUNT_STATUS
              from dba_users@TRZSP_SUN
             group 
                by ACCOUNT_STATUS;


            echo 'estatus usuarios en TARGET'

            select count(1)
                  ,ACCOUNT_STATUS
              from dba_users
             group 
                by ACCOUNT_STATUS;

            echo 'Comparacion final sincronziacion estatus OPEN'

            select count(1),ACCOUNT_STATUS
              from dba_users@TRZSP_SUN
              where ACCOUNT_STATUS = 'OPEN'
              group by ACCOUNT_STATUS
            minus
            select count(1),ACCOUNT_STATUS
              from dba_users
              where ACCOUNT_STATUS = 'OPEN'
              group by ACCOUNT_STATUS;


        spool off






**************************************************************************************

comparacion tbs origen_dest

**************************************************************************************
select tablespace_name from dba_tablespaces@TRZSP_SUN
        minus
        select tablespace_name from dba_tablespaces;



        select tablespace_name from dba_tablespaces
        minus
        select tablespace_name from dba_tablespaces@TRZSP_SUN;



        SET SERVEROUTPUT ON
        SET PAGESIZE 1000
        SET LINESIZE 255
        SET FEEDBACK OFF

        PROMPT
        PROMPT Tablespaces nearing 0% free
        PROMPT ***************************
        select * from (
        select * from (
        SELECT b.tablespace_name
        ,
               nvl(b.size_kb,0)
               , 'origen'
           --    nvl(a.free_kb,0),
           --    Trunc((nvl(a.free_kb,0)/b.size_kb) * 100) "FREE_%"
        FROM   (SELECT tablespace_name,
                       Trunc(Sum(bytes)/1024/1024) free_kb
                FROM   dba_free_space@TRZSP_SUN
        WHERE TABLESPACE_NAME = nvl('&1',TABLESPACE_NAME)
                GROUP BY tablespace_name) a,
               (SELECT tablespace_name,
                       Trunc(Sum(nvl(bytes,0))/1024/1024) size_kb
                FROM   dba_data_files@TRZSP_SUN
        WHERE TABLESPACE_NAME = nvl('&1',TABLESPACE_NAME)
                GROUP BY tablespace_name) b
        WHERE  a.tablespace_name(+) = b.tablespace_name
        order by 1 desc
        )
        union all 
        select * from (
        SELECT b.tablespace_name
        ,
               nvl(b.size_kb,0)
               , 'destino'
           --    nvl(a.free_kb,0),
           --    Trunc((nvl(a.free_kb,0)/b.size_kb) * 100) "FREE_%"
        FROM   (SELECT tablespace_name,
                       Trunc(Sum(bytes)/1024/1024) free_kb
                FROM   dba_free_space
        WHERE TABLESPACE_NAME = nvl('&1',TABLESPACE_NAME)
                GROUP BY tablespace_name) a,
               (SELECT tablespace_name,
                       Trunc(Sum(nvl(bytes,0))/1024/1024) size_kb
                FROM   dba_data_files
        WHERE TABLESPACE_NAME = nvl('&1',TABLESPACE_NAME)
                GROUP BY tablespace_name) b
        WHERE  a.tablespace_name(+) = b.tablespace_name
        order by 1 desc
        )
        )
        order by 1, 3
        /


************************************************************************


DBA_REGISTRY

vi 18_dba_registry.sql

spool 18_dba_registry.lst
set time on timi on

     COL COMP_NAME FORMAT A60
     COL VERSION FORMAT A14
      set pagesize 100
    set lin 240 

     SELECT COMP_ID, COMP_NAME, VERSION, STATUS
      FROM DBA_REGISTRY;

spool off;

**********

COMP_ID                        COMP_NAME                                                    VERSION        STATUS
------------------------------ ------------------------------------------------------------ -------------- -----------
CATALOG                        Oracle Database Catalog Views                                19.0.0.0.0     VALID
CATPROC                        Oracle Database Packages and Types                           19.0.0.0.0     VALID
RAC                            Oracle Real Application Clusters                             19.0.0.0.0     VALID
JAVAVM                         JServer JAVA Virtual Machine                                 19.0.0.0.0     VALID
XML                            Oracle XDK                                                   19.0.0.0.0     VALID
CATJAVA                        Oracle Database Java Packages                                19.0.0.0.0     VALID
APS                            OLAP Analytic Workspace                                      19.0.0.0.0     VALID
XDB                            Oracle XML Database                                          19.0.0.0.0     VALID
OWM                            Oracle Workspace Manager                                     19.0.0.0.0     VALID
CONTEXT                        Oracle Text                                                  19.0.0.0.0     VALID
ORDIM                          Oracle Multimedia                                            19.0.0.0.0     VALID
SDO                            Spatial                                                      19.0.0.0.0     VALID
XOQ                            Oracle OLAP API                                              19.0.0.0.0     VALID
OLS                            Oracle Label Security                                        19.0.0.0.0     VALID
DV                             Oracle Database Vault                                        19.0.0.0.0     VALID


************************************************************************

select count(1)
, table_name 
from dba_tab_partitions 
where TABLE_OWNER ='TX'
group by table_name
order by 1;





select count(1)
, index_name 
from dba_ind_partitions 
where INDEX_OWNER ='TX'
group by index_name
order by 1;






********************************************************************

--create pfile='/home/oracle19/pfile_TRZSP_NEW_011024.ora' from spfile;

/home/oracle19/pfile_TRZSP_NEW_011024.ora

--create pfile='/home/oracle19/pfile_TRZSP_SUND_230924.ora' from spfile;




********************************************************************
SET LONG 20000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
BEGIN
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
END;
/

SELECT DBMS_METADATA.get_ddl ('TABLESPACE', t.TABLESPACE_NAME)
FROM   dba_tablespaces t
WHERE  TABLESPACE_NAME  in('DATA_AUDITORIA','MANTENIMIENTOS_TX');


***************************************
DATA_AUDITORIA    
MANTENIMIENTOS_TX 
***************************************


 CREATE TABLESPACE "DATA_AUDITORIA" DATAFILE
  SIZE 1073741824
  AUTOEXTEND ON NEXT 1073741824 MAXSIZE 32767M,
  SIZE 1073741824
  AUTOEXTEND ON NEXT 2146435072 MAXSIZE 32767M,
  SIZE 1073741824
  AUTOEXTEND ON NEXT 2146435072 MAXSIZE 32767M
  LOGGING ONLINE PERMANENT BLOCKSIZE 8192
  EXTENT MANAGEMENT LOCAL AUTOALLOCATE DEFAULT
 NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO;



  CREATE TABLESPACE "MANTENIMIENTOS_TX" DATAFILE
  SIZE 32212254720
  AUTOEXTEND ON NEXT 524288000 MAXSIZE 32767M
  LOGGING ONLINE PERMANENT BLOCKSIZE 8192
  EXTENT MANAGEMENT LOCAL AUTOALLOCATE
  ENCRYPTION USING 'AES192' ENCRYPT DEFAULT
 NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO;



C.- Mover objetos de auditoria al tablespace separado 

BEGIN
DBMS_AUDIT_MGMT.set_audit_trail_location(
 audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED, --this moves table Unified Audit
 audit_trail_location_value => 'DATA_AUDITORIA');
END;
/

D.- Verificar el tablespace AUDIT_TBS

COL FILE_NAME FORMAT A80
SELECT FILE_ID,FILE_NAME
      ,TABLESPACE_NAME
      ,AUTOEXTENSIBLE
      ,MAXBYTES 
  FROM DBA_DATA_FILES 
 WHERE TABLESPACE_NAME = 'DATA_AUDITORIA';







 select /*+ full(x) parallel(x 64) */ count(1) 
from tx.token x
where x.status = 'Active' 
and x.productid = 41;


 select /*+ full(x) parallel(x 64) */ count(1) 
from tx.token x
where x.status = 'Active' 
and x.productid = 3;



select job_name from dba_scheduler_jobs
where owner='BACKOFFICE';






**********************************************

vi parfiles_ddl_indexes_part.sql


#!/bin/bash

. ~/.profile

sqlplus -S / as sysdba <<EOF >> create_parfile_index.sh
set timi off time off
set feed off head off
set pages 0
select 'cat <<EOF > parfile_extract_ddl_index_'||di_1.INDEX_NAME||'.par'||chr(10)||
'DIRECTORY=MIGRACION_FULL'||chr(10)||
'LOGFILE=IMP_DDL_INDEX_TRZSP_'||di_1.INDEX_NAME||'.LOG'||chr(10)||
'DUMPFILE=EXP_FULL_TRZS_%L.dmp'||chr(10)||
'SQLFILE=ddl_index_trzsp_full_'||(rownum+25)||'.sql'||chr(10)||
'METRICS=YES'||chr(10)|| 
'PARALLEL=20'||chr(10)||
'INCLUDE=INDEX'||chr(10)||
'CLUSTER=N'||chr(10)||
'INCLUDE=INDEX:"IN('''||di_1.INDEX_NAME||''')"'||chr(10)||
'EOF'||chr(10) X
from ( select DIP.INDEX_OWNER, DI.TABLE_NAME, DIP.INDEX_NAME
from DBA_IND_PARTITIONS DIP
, DBA_INDEXES DI
where DIP.INDEX_OWNER='TX'
and DI.OWNER='TX'
and DIP.INDEX_OWNER=DI.OWNER
and DIP.INDEX_NAME=DI.INDEX_NAME
and DI.INDEX_TYPE !='LOB'
group by DIP.INDEX_OWNER, DI.TABLE_NAME, DIP.INDEX_NAME
order by di.table_name desc) di_1;
exit;
EOF

chmod +x create_parfile_index.sh && ./create_parfile_index.sh

FILE_IMPORT=02_imports_trzsp.sh
BASE=base_import.txt

cat $BASE > $FILE_IMPORT
echo -e "\n" >> ${FILE_IMPORT}

for parfile in $(ls -1 parfile_extract_ddl_index_*.par)
do
echo "impdp system/oracle1 parfile=${parfile}" >> ${FILE_IMPORT}
done




sqlplus -S / as sysdba <<EOF > test_output.txt
SELECT STATUS FROM V\$INSTANCE;
exit;
EOF
