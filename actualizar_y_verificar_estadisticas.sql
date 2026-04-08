

exec dbms_stats.unlock_table_stats (null,'X$KCCLH');
commit;

vi estadisticas_20240813.sql

spool estadisticas_20240813.lst
SET SERVEROUTPUT ON;
set timi on time on
set line 240



exec DBMS_STATS.GATHER_SYSTEM_STATS;
exec DBMS_STATS.GATHER_DICTIONARY_STATS(Degree=> 64);
exec dbms_stats.lock_table_stats (null,'X$KCCLH');
exec DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;
EXEC DBMS_STATS.gather_database_stats(Degree=> 64, cascade => TRUE,estimate_percent =>dbms_stats.auto_sample_size, gather_sys=>true);

spool off;


**************
nohup sqlplus / as sysdba @estadisticas_20240812.sql




A.-DE SISTEMA

SELECT * FROM SYS.AUX_STATS$;

Donde aparecerá algo así:

SYSSTATS_INFO	STATUS		COMPLETED
SYSSTATS_INFO	DSTART		02-18-2024 02:09  <-----DE INTERES TENER LA FECHA MAS RECIENTE
SYSSTATS_INFO	DSTOP		02-18-2024 02:09  <-----DE INTERES TENER LA FECHA MAS RECIENTE
SYSSTATS_INFO	FLAGS	1	
SYSSTATS_MAIN	CPUSPEEDNW	2787	
SYSSTATS_MAIN	IOSEEKTIM	10	
SYSSTATS_MAIN	IOTFRSPEED	4096	
SYSSTATS_MAIN	SREADTIM		
SYSSTATS_MAIN	MREADTIM		
SYSSTATS_MAIN	CPUSPEED		
SYSSTATS_MAIN	MBRC		
SYSSTATS_MAIN	MAXTHR		
SYSSTATS_MAIN	SLAVETHR		



B.-DE DICCIONARIO

set pages 200
SELECT NVL(TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), 'NO STATS') last_analyzed
,OWNER
,COUNT(1) dictionary_tables
FROM dba_tables
WHERE owner IN ('SYS', 'SYSTEM')
GROUP BY TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), OWNER
ORDER BY 1 DESC;


C.-DE FIXED_OBJECTS

select NVL(TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), 'NO STATS') last_analyzed
,COUNT(1) fixed_objects
FROM dba_tab_statistics
WHERE object_type = 'FIXED TABLE'
GROUP BY TO_CHAR(last_analyzed, 'YYYY-Mon-DD')
ORDER BY 1 DESC;


D.-DE BASE DE DATOS

REM To list the objects having stale statistics (excluding SYS, SYSTEM, SYSMAN, DBSNMP objects)
REM Run the following from SYS or SYSTEM

set lines 120
column owner format a20
column table_name format a30
SELECT DT.OWNER,
       DT.TABLE_NAME, DT.LAST_ANALYZED,
       ROUND ( (DELETES + UPDATES + INSERTS) / NUM_ROWS * 100) STALE_PERCENT, NUM_ROWS
FROM   DBA_TABLES DT, DBA_TAB_MODIFICATIONS DTM
WHERE      DT.OWNER = DTM.TABLE_OWNER
       AND DT.TABLE_NAME = DTM.TABLE_NAME
       AND NUM_ROWS > 0 
       AND ROUND ( (DELETES + UPDATES + INSERTS) / NUM_ROWS * 100) >= 10 AND OWNER NOT IN ('SYS','SYSTEM','SYSMAN','DBSNMP')
ORDER BY 4 desc,5 desc;




REM To list the objects having stale statistics (excluding SYS, SYSTEM, SYSMAN, DBSNMP objects)
REM Run the following from SYS or SYSTEM
set lines 120
column owner format a20
column table_name format a30
SELECT DT.OWNER,
       DT.TABLE_NAME, DT.LAST_ANALYZED,
       ROUND ( (DELETES + UPDATES + INSERTS) / NUM_ROWS * 100) STALE_PERCENT, NUM_ROWS
FROM   DBA_TABLES DT, DBA_TAB_MODIFICATIONS DTM
WHERE      DT.OWNER = DTM.TABLE_OWNER
       AND DT.TABLE_NAME = DTM.TABLE_NAME
       AND NUM_ROWS > 0 
       AND ROUND ( (DELETES + UPDATES + INSERTS) / NUM_ROWS * 100) >= 10 AND OWNER NOT IN ('SYS','SYSTEM','SYSMAN','DBSNMP')
ORDER BY 4 desc,5 desc;











exec DBMS_STATS.GATHER_SYSTEM_STATS;
exec DBMS_STATS.GATHER_DICTIONARY_STATS(Degree=> 64);
exec dbms_stats.lock_table_stats (null,'X$KCCLH');
exec DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;
EXEC DBMS_STATS.gather_database_stats(Degree=> 64, cascade => TRUE,estimate_percent =>dbms_stats.auto_sample_size, gather_sys=>true);