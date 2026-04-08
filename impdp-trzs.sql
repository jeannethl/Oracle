

*
*****Prerrequisitos:
********************


*Aumentar tablespaces
*Setear la BD flasjback_off y noarchivelog



--------------- DESACTIVAR ARCHIVELOG  -------------------

1.-Verificar si esta activado el archive log y la direccion con: 
SELECT flashback_on FROM v$database;
ALTER DATABASE FLASHBACK OFF;
	archive log list;
2.-shutdown immediate;
3.-startup mount;
4.-alter database noarchivelog;
5.-alter database open;
6.-archive log list;






1.- Verificar tablespaces

	1.1 Tamaño_Tablespaces

		vi verificar_tamaño_tbs.sql
		
			--SELECT a.TABLESPACE_NAME "Name",
			--       ROUND((a.BYTES / 1024) / 1024, 2) "Size (MB)",
			--       ROUND((((a.BYTES - NVL(b.BYTES, 0)) / 1024) / 1024), 2) "Used (MB)",
			--       ROUND((NVL(b.BYTES, 0) / 1024) / 1024, 2) "Free (MB)",
			--       ROUND((100 - (((a.BYTES - NVL(b.BYTES, 0)) / a.BYTES) * 100)), 2) "% Free"
			--FROM (SELECT TABLESPACE_NAME, 
			--             SUM(BYTES) BYTES 
			--      FROM dba_data_files 
			--      GROUP BY TABLESPACE_NAME
			--      UNION ALL
			--      SELECT TABLESPACE_NAME, 
			--             SUM(BYTES) BYTES 
			--      FROM dba_temp_files 
			--      GROUP BY TABLESPACE_NAME) a
			--LEFT JOIN (SELECT TABLESPACE_NAME, 
			--                  SUM(BYTES) BYTES 
			--           FROM dba_free_space 
			--           GROUP BY TABLESPACE_NAME
			--           UNION ALL
			--           SELECT TABLESPACE_NAME, 
			--                  SUM(BYTES_FREE) BYTES 
			--           FROM v$temp_space_header 
			--           GROUP BY TABLESPACE_NAME) b
			--ON a.TABLESPACE_NAME = b.TABLESPACE_NAME
			--ORDER BY 5 DESC;
						
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

			
	1.2 Aumentar Tablespace (de ser necesario)

		vi aumento_tbs.sql (750G)
		--verificar tablespace_name y diskgroup_name
			ALTER TABLESPACE UNDOTBS1 ADD DATAFILE '+DATA_TRZSP' SIZE 32767M AUTOEXTEND OFF;

		vi aumento_tbs_tmp.sql

			ALTER TABLESPACE TEMP ADD TEMPFILE '+DATA_TRZSP' SIZE 32767M AUTOEXTEND OFF;


2.- Verificar Directorios


	2.1 Directorios

		vi Directories.sql

			SET LINE 400
			COL OWNER FORMAT A25
			COL DIRECTORY_NAME FORMAT A30
			COL DIRECTORY_PATH FORMAT A100
			SELECT OWNER, DIRECTORY_PATH, DIRECTORY_NAME FROM DBA_DIRECTORIES
			/

	2.2 Crear Directorio

		vi create_directory.sql

			CREATE OR REPLACE DIRECTORY MIGRACION_FULL AS '/Migracion3/TRZS/EXP_FULL_TRZS_20240914';
			GRANT READ,WRITE ON DIRECTORY MIGRACION_FULL TO SYSTEM;

			CREATE OR REPLACE DIRECTORY MIGRACION_DOEREXTMSG AS '/Migracion3/TRZS/EXP_DOEREXTMSG_TRZS_20240914';
			GRANT READ,WRITE ON DIRECTORY MIGRACION_DOEREXTMSG TO SYSTEM;

3.- validar temp_files

select tablespace_name
      ,sum(bytes)/1024/1024/1024 temp_gb
  from dba_temp_files 
 group by tablespace_name;


4.- verificar cpu
show parameter cpu


5.- modificar max_datapump_parallel_per_job
show parameter PARALLEL
alter system set max_datapump_parallel_per_job=100;






6. Preparacion de metadata de indices



vi parfile_extract_ddl_index.par

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_DLL_INDEX_TRZSP.LOG
DUMPFILE=EXP_FULL_TRZS_20240911_%U.dmp
SQLFILE=ddl_index_trzsp.sql
METRICS=YES
PARALLEL=100
INCLUDE=INDEX
CLUSTER=N
LOGTIME=ALL

nohup impdp system/oracle1 parfile=parfile_extract_ddl_index.par &

impdp system/oracle1 ATTACH=SYS_SQL_FILE_FULL_01



7. Preparacion de metadata de constraint

vi parfile_extract_ddl_constraint.par

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_DLL_CONSTRAINT_TRZSP.LOG
DUMPFILE=EXP_FULL_TRZS_20240911_%U.dmp
SQLFILE=ddl_constraint_trzsp.sql
METRICS=YES
PARALLEL=100
INCLUDE=CONSTRAINT
CLUSTER=N
LOGTIME=ALL

nohup impdp system/oracle1 parfile=parfile_extract_ddl_constraint.par &

impdp system/oracle1 ATTACH=SYS_SQL_FILE_FULL_01

SYS_SQL_FILE_FULL_01


8.Agregar paralelismo al .sql de indices yno validate a constraint



sed -i 's/PARALLEL 1/PARALLEL 64/' ddl_index_trzsp.sql
sed -i 's/ENABLE/ ENABLE NOVALIDATE/' ddl_constraint_trzsp.sql











------------------------
Pasos de importacion

1.- Parfile importacion de metadata

1.1 Parfile_imp_metadata FULL

vi parfile_imp_metadata.par

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_METADATA_TRZS_1.LOG
DUMPFILE=EXP_FULL_TRZS_20240914_%U.dmp
METRICS=YES
PARALLEL=100
EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS,TABLESPACE
CONTENT=METADATA_ONLY
LOGTIME=ALL


1.1 Parfile_imp_metadata DOEREXTMSG (dem)

vi parfile_imp_metadata_dem.par

DIRECTORY=MIGRACION_DOEREXTMSG
FULL=Y
LOGFILE=IMP_METADATA_DEM_1.LOG
DUMPFILE=EXP_DOEREXTMSG_TRZS_20240914_%U.dmp
METRICS=YES
PARALLEL=100
EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS,TABLESPACE
CONTENT=METADATA_ONLY
LOGTIME=ALL

--ACCESS_METHOD=DIRECT_PATH

2.- Parfile para import de DATA 

2.1 - Parfile_imp_data FULL

vi parfile_imp_data.par

DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=IMP_DATA_TRZS_1.LOG
DUMPFILE=EXP_FULL_TRZS_20240914_%U.dmp
METRICS=YES
PARALLEL=100
EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS
CONTENT=DATA_ONLY
CLUSTER=N





while true; do egrep -i TRAN_2024_ IMP_DATA_TRZS_1.LOG; sleep 60; clear; done
while true; do egrep -i DOER_2024 IMP_DATA_TRZS_1.LOG; sleep 60; clear; done





2.1 - Parfile_imp_data DEM

vi parfile_imp_data_dem.par

DIRECTORY=MIGRACION_DOEREXTMSG
FULL=Y
LOGFILE=IMP_DATA_DEM_TRZS_1.LOG
DUMPFILE=EXP_DOEREXTMSG_TRZS_20240914_%U.dmp
METRICS=YES
PARALLEL=100
EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS
CONTENT=DATA_ONLY
CLUSTER=N

3.- Set de cluster_database en FALSE 

sqlplus / as sysdba 

alter system set cluster_database=FALSE scope=spfile;

Bajar base de datos 

srvctl stop database -d TRZSP

subir instancia

srvctl start instance -d TRZSP -i TRZSP1
--nota: este proceso se puede hacer antes.


4.- Import de metadata
4.1 import_metadata_full

nohup impdp system/oracle1 parfile=parfile_imp_metadata.par &
impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01

4.2 import_metadata_dem

nohup impdp system/oracle1 parfile=parfile_imp_metadata_dem.par &
impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01


--ALTER TABLE TX.POSTING PARALLEL 16;

CREATE OR REPLACE TRIGGER enable_parallel_dml_trigger
AFTER LOGON ON DATABASE
BEGIN
EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
END;

--EXECUTE IMMEDIATE 'ALTER SESSION FORCE PARALLEL QUERY PARALLEL 16';


5.- Consultar_triggers

	5.1 Consultar_triggers_existentes

COL OWNER FORMAT A30
COL TRIGGER_NAME FORMAT A30
COL TABLE_NAME FORMAT A30
COL TRIGGERING_EVENT FORMAT A40
SELECT OWNER, TRIGGER_NAME, TABLE_NAME, STATUS, TRIGGER_TYPE, TRIGGERING_EVENT
FROM ALL_TRIGGERS
WHERE OWNER = 'TX'
AND STATUS = 'ENABLED';




					*Consultar existencia de trigger
--COL OWNER FORMAT A30
--COL TRIGGER_NAME FORMAT A30
--COL TABLE_NAME FORMAT A30
--COL TRIGGERING_EVENT FORMAT A40
--SELECT OWNER, TRIGGER_NAME, TABLE_NAME, STATUS, TRIGGER_TYPE, TRIGGERING_EVENT
--FROM ALL_TRIGGERS
--WHERE TABLE_NAME = 'POSTING';


SET SERVEROUTPUT ON
DECLARE v_sentence    VARCHAR2(500);
BEGIN
FOR t IN (SELECT OWNER, TRIGGER_NAME, TABLE_NAME, STATUS, TRIGGER_TYPE, TRIGGERING_EVENT
FROM ALL_TRIGGERS
WHERE OWNER = 'TX'
AND STATUS = 'ENABLED')
  LOOP
    BEGIN
      v_sentence := 'ALTER TRIGGER ' || t.OWNER || '.' || t.TRIGGER_NAME || ' DISABLED;';
      DBMS_OUTPUT.PUT_LINE(v_sentence);
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
  END LOOP;
END;
/
--EXECUTE IMMEDIATE v_sentence;
443 TRIGGERS







SELECT OWNER, TRIGGER_NAME, TRIGGER_BODY
FROM ALL_TRIGGERS
WHERE TRIGGER_NAME = 'TBIR_POSTING';


--6.- Paralelismo TX.POSTING

--ALTER TABLE TX.POSTING PARALLEL 16;

7.- Import de data

4.1 import_metadata_full

nohup impdp system/oracle1 parfile=parfile_imp_data.par &
impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01

4.2 import_metadata_dem

nohup impdp system/oracle1 parfile=parfile_imp_data_dem.par &
impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01




		--/Migracion3/TRZS/20240831
		--
		--Monitoreo de tablas
		--while true; do egrep -i POSTING IMP_DATA_TRZSP_1.LOG; sleep 60; clear; done
		while true; do egrep -i TRAN_2024_ IMP_DATA_TRZS_2.LOG; sleep 600; clear; done
		while true; do egrep -i DOER_2024_ IMP_DATA_TRZS_2.LOG; sleep 600; clear; done
		--while true; do egrep -i BATCH IMP_DATA_TRZSP_1.LOG; sleep 60; clear; done







select TABLE_NAME, DEGREE from dba_tables where TABLE_NAME = 'POSTING';



Pendiente proceso de indices, constraint y analisis de procedures que coincidan con el numero de procedures en produccion.
















