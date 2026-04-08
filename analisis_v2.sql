set echo on
REM **************************************************************************
REM EXTRACCION DE DATOS PARA INVENTARIO DE BD ORACLE
REM Author - ADSI DBA-TEAM 
REM **************************************************************************

set echo off
set termout on
set heading on
set feedback off
set trimspool on
set linesize 200
set pagesize 200
ALTER SESSION SET NLS_DATE_FORMAT="DD-MON-RRRR HH24:MI:SS";

set termout off
--set feedback off
column NAMEDB new_val D_NAME noprint
select NAME NAMEDB from v$database;
set termout on
--set feedback on

set markup html on spool on

Spool oracle_&D_NAME._reporte_inventario.html

-- Header html of report 
SET MARKUP HTML ENTMAP OFF

prompt <title> Oracle Database report </title>
prompt <style type="text/css"> .title h1 { font-size: 40px; } .title p { text-align: center; } h2 { font-size: 30px; } h3 { font-size: 20px; font-weight: bold; } table, td { background-color:rgb(222, 234, 246); } th {  background-color: rgb(91, 155, 213); color: white; } </style>
prompt <div class="title"> <h1> <center><b> EVALUACION DE LA BD &D_NAME V1.0.0 </b> <br> <p> ADSI DBA-TEAM </p> </center> </h1> </div>

SET MARKUP HTML ENTMAP ON




REM **************************************************************************
REM 	1 CARACTERISTICAS A NIVEL DE S.O
REM **************************************************************************

SET MARKUP HTML ENTMAP OFF
prompt <h2> 1 Caracteristicas a nivel de S.O </h2>
SET MARKUP HTML ENTMAP ON


SET MARKUP HTML ENTMAP OFF
prompt <h3> 1.1  Ver Hostname, Plataforma, CPU, CORES, SOCKETS Y MEMORIA FISICA DEL SERVIDOR  </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

-- Informacion de base de datos
SELECT ora_database_name as "DB name"
      ,D.DBID as "DB id"
      ,D.DB_UNIQUE_NAME as "Unique Name"
      ,D.DATABASE_ROLE as "Role"
      ,I.EDITION as "Edition"
      ,I.VERSION as "Release"
      ,p.value as "RAC"
      ,D.CDB
from V$instance I
    ,v$database D
    ,( select name, value 
         from v$parameter
        where name='cluster_database'
     )p ;

--Informacion de la instancia
SELECT I.INSTANCE_NAME "Instance Name"
      ,I.INSTANCE_NUMBER "Instance Number"
      ,TO_CHAR(STARTUP_TIME, 'HH24:MI DD-MON-YY') "Startup Time"
      ,SYS_CONTEXT ('USERENV', 'SESSION_USER')  "User Name"
  FROM V$instance I;

--Informacion de Plataforma
select I.HOST_NAME  "Hostname" 
   ,D.PLATFORM_NAME "Platform",
   (select max(value) from dba_hist_osstat 
    where stat_name = 'NUM_CPUS')        CPUs,
   (select max(value) from dba_hist_osstat 
    where stat_name = 'NUM_CPU_CORES')   "Cores",
   (select max(value) from dba_hist_osstat 
    where stat_name = 'NUM_CPU_SOCKETS') "Sockets",
   (select ROUND(max(value)/1024/1024/1024 , 2) from dba_hist_osstat
     where stat_name = 'PHYSICAL_MEMORY_BYTES') "Memory (GB)"
from V$instance I
    ,v$database D;



REM **************************************************************************
REM     2 CARACTERISTICAS DE AWR DE LA BD
REM **************************************************************************

SET MARKUP HTML ENTMAP OFF
prompt <h2> 2 Caracteristicas de AWR de la BD </h2>
SET MARKUP HTML ENTMAP ON


SET MARKUP HTML ENTMAP OFF
prompt <h3> 2.1 STATISTICS_LEVEL </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

show parameter statistics_level;


SET MARKUP HTML ENTMAP OFF
prompt <h3> 2.2 INTERVALO DE EJECUCION Y RETENCION (EN MINUTOS) </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

select
   extract( day from snap_interval) *24*60+
   extract( hour from snap_interval) *60+
   extract( minute from snap_interval ) "Snapshot Interval",
   extract( day from retention) *24*60+
   extract( hour from retention) *60+
   extract( minute from retention ) "Retention Interval"
from
   dba_hist_wr_control;





REM **************************************************************************
REM     3 CARACTERISTICAS DE ESPACIO DE LA BD
REM **************************************************************************

SET MARKUP HTML ENTMAP OFF
prompt <h2> 3 Caracteristicas de espacio de la BD </h2>
SET MARKUP HTML ENTMAP ON



SET MARKUP HTML ENTMAP OFF
prompt <h3> 3.1 Consultar el tamano total de la BD </h3>
SET MARKUP HTML ENTMAP ON

prompt TAMANO TOTAL DE LA BD:

select d.data_size+t.temp_size+r.redo_size+c.controlfile_size "Database Size in GB" 
from (select SUM(bytes)/1024/1024/1024 data_size from v$datafile) d, 
(select nvl(sum(bytes),0)/1024/1024/1024 temp_size from v$tempfile) t, 
(select sum(bytes)/1024/1024/1024 redo_size from sys.v_$log ) r, 
(select sum(BLOCK_SIZE*FILE_SIZE_BLKS)/1024/1024/1024 controlfile_size from v$controlfile) c;



SET MARKUP HTML ENTMAP OFF
prompt <h3> 3.2 Consultar el tamano ocupado de la BD </h3>
SET MARKUP HTML ENTMAP ON

prompt ESPACIO OCUPADO DE LA BD:

select sum(round((a.BYTES/1024)/1024,2)) "Size (MB)"
,sum(round((((a.BYTES-b.BYTES)/1024)/1024),2)) "Used (MB)"
,sum(round((b.BYTES/1024)/1024,2)) "Free (MB)"
,round((sum(b.BYTES*100) / sum(a.BYTES)),2) "Free %"
from 
(
select TABLESPACE_NAME
,sum(BYTES) BYTES
from dba_data_files
group by TABLESPACE_NAME
) a,
(
select  TABLESPACE_NAME
,sum(BYTES) BYTES 
,max(BYTES) largest
from dba_free_space
group by TABLESPACE_NAME
) b
where a.TABLESPACE_NAME=b.TABLESPACE_NAME;



SET MARKUP HTML ENTMAP OFF
prompt <h3> 3.3 Consultar los diskgroups de ASM</h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:
select GROUP_NUMBER, NAME,TOTAL_MB, FREE_MB, USABLE_FILE_MB from V$ASM_DISKGROUP;





REM **************************************************************************
REM     4 CARACTERISTICAS DE TABLESPACES DE LA BD
REM **************************************************************************

SET MARKUP HTML ENTMAP OFF
prompt <h2> 4 Caracteristicas de tablespaces de la BD </h2>
SET MARKUP HTML ENTMAP ON



SET MARKUP HTML ENTMAP OFF
prompt <h3> 4.1 Listado de tablespaces, tempfile y su tamanos </h3>
SET MARKUP HTML ENTMAP ON

prompt TABLESPACES:


--Tablespaces
col Name format a60
select a.TABLESPACE_NAME "Name"
      ,round((a.BYTES/1024)/1024,2) "Size (MB)"
      ,round((((a.BYTES-b.BYTES)/1024)/1024),2) "Used (MB)"
      ,round((b.BYTES/1024)/1024,2) "Free (MB)"
      ,round((100-((a.BYTES-b.BYTES)/a.BYTES)*100),2) "% Free"
  from 
      ( select TABLESPACE_NAME
              ,sum(BYTES) BYTES
          from dba_data_files
         group by TABLESPACE_NAME ) a,
      ( select TABLESPACE_NAME
              ,sum(BYTES) BYTES 
              ,max(BYTES) largest
          from dba_free_space
         group by TABLESPACE_NAME ) b
 where a.TABLESPACE_NAME=b.TABLESPACE_NAME 
 order by 5 desc;

prompt TOTAL DE TABLESPACES:

SELECT COUNT(1) 
FROM DBA_TABLESPACES;

--Tablespace temp
prompt TEMPFILE:

col file_name format a60
col tablespace_name format a20
col maxbytes format 9999999999999999
select inst_id,file_id,file_name,tablespace_name,status
      ,autoextensible,increment_by
      ,round((user_bytes/1024)/1024,2) "USER_SIZE (MB)"
      ,user_blocks,shared
      ,round((bytes/1024)/1024,2) "SIZE (MB)"
      ,round((maxbytes/1024)/1024,2) "MAXSIZE (MB)"
  from dba_temp_files;




SET MARKUP HTML ENTMAP OFF
prompt <h3> 4.2 Listado de datafiles y sus tamanos </h3>
SET MARKUP HTML ENTMAP ON

prompt LISTADO DE DATAFILES:

set line 380
col file_name format a80
set pagesize 200
select file_id,file_name 
      ,tablespace_name
      ,round((BYTES/1024)/1024,2) "Size (MB)"
from dba_data_files;


prompt TOTAL DE DATAFILES:

select count(1)
from dba_data_files;





REM **************************************************************************
REM     5 CARACTERISTICAS DE RECURSOS DE LA BD
REM **************************************************************************

SET MARKUP HTML ENTMAP OFF
prompt <h2> 5 Caracteristicas de recursos de la BD </h2>
SET MARKUP HTML ENTMAP ON


SET MARKUP HTML ENTMAP OFF
prompt <h3> 5.1 Numero de CPU, Parametros SGA y PGA </h3>
SET MARKUP HTML ENTMAP ON

prompt CPU:
SHOW PARAMETER CPU_COUNT;

prompt PARAMETROS SGA:
show parameter sga;

prompt PARAMETROS PGA
show parameter pga;



SET MARKUP HTML ENTMAP OFF
prompt <h3> 5.2 Entonacion de SGA </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT SGA_SIZE
,SGA_SIZE_FACTOR
,ESTD_DB_TIME
,ESTD_PHYSICAL_READS 
FROM V$SGA_TARGET_ADVICE;  



SET MARKUP HTML ENTMAP OFF
prompt <h3> 5.3 Entonacion de PGA </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT PGA_TARGET_FOR_ESTIMATE
,PGA_TARGET_FACTOR
,ESTD_TIME
,ESTD_PGA_CACHE_HIT_PERCENTAGE
,ESTD_OVERALLOC_COUNT 
FROM V$PGA_TARGET_ADVICE;



SET MARKUP HTML ENTMAP OFF
prompt <h3> 5.4 Entonacion del SHARED POOL </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

select SHARED_POOL_SIZE_FOR_ESTIMATE
,SHARED_POOL_SIZE_FACTOR
,ESTD_LC_MEMORY_OBJECTS
,ESTD_LC_TIME_SAVED
,ESTD_LC_TIME_SAVED_FACTOR 
from V_$SHARED_POOL_ADVICE;





REM **************************************************************************
REM 	6 CARACTERISTICAS GENERALES DE LA BD
REM **************************************************************************

SET MARKUP HTML ENTMAP OFF
prompt <h2> 6 Caracteristicas generales de la BD </h2>
SET MARKUP HTML ENTMAP ON


SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.1 Nombre de la BD </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT NAME 
FROM V$DATABASE;



SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.2  Fecha de creacion de la BD </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT CREATED 
FROM V$DATABASE;




SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.3 Version de la BD y parches aplicados </h3>
SET MARKUP HTML ENTMAP ON

prompt VERSION:

SELECT BANNER_FULL 
FROM V$VERSION;

prompt PARCHES:

SELECT COMP_ID
,COMP_NAME
,VERSION
,VERSION_FULL
,STATUS
,MODIFIED
FROM DBA_REGISTRY;



SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.4 Base de datos CDB o NON-CDB </h3>
SET MARKUP HTML ENTMAP ON

prompt CDB:

SELECT CDB 
FROM V$DATABASE;


prompt PDBS PRESENTES:
show pdbs;



SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.5 BD en cluster y numero de instancias </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SHOW PARAMETER CLUSTER_DATABASE;




SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.6  Numero del Resetlog Change#  </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT *
FROM V$DATABASE_INCARNATION; 





SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.7 Directorios de diagnostico </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT * 
FROM V$DIAG_INFO;




SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.8  Wallet de encriptacion </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT *
FROM V$ENCRYPTION_WALLET;




SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.9  Verificar si esta habilitado el Flashback y su retencion </h3>
SET MARKUP HTML ENTMAP ON

prompt STATUS DEL FLASHBACK:
--Verificar status del flashback
select flashback_on 
from v$database;

prompt RETENCION DEL FLASHBACK:
--Verificar retención del flashback
show parameter flashback;




SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.10 Ubicacion y tamano de los archives </h3>
SET MARKUP HTML ENTMAP ON

prompt UBICACION Y TAMANO DEL AREA DE RECOVERY:
show parameter db_recovery_file_dest


prompt UBICACION DE LOS ARCHIVES:
show parameter log_archive_dest







SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.11 Ver si la BD esta en modo archive </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT LOG_MODE FROM V$DATABASE;





SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.12 Consultar el SPFILE y  los controlfiles</h3>
SET MARKUP HTML ENTMAP ON

prompt SPFILE:
show parameter spfile;

prompt CONTROLFILES:
show parameter control_files;




SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.13 Listado de los redologs y standby redologs</h3>
SET MARKUP HTML ENTMAP ON

prompt REDOLOGS:

select a.group#,
a.thread#,
a.sequence#,
a.archived,
a.status,
b.member as redolog_file_name,
(a.bytes/1024/1024) as size_mb
from v$log a
JOIN v$logfile b on a.group#=b.group#
order by a.group# asc;   


prompt STANDBY REDOLOGS:

SELECT 
     a.GROUP#
    ,a.THREAD#
    ,a.SEQUENCE#
    ,a.ARCHIVED
    ,a.STATUS
    ,b.member redolog_file_name
    ,(a.BYTES/1024/1024) SIZE_MB 
FROM 
     V$STANDBY_LOG a
    ,v$logfile b
WHERE
     a.group#=b.group#
order by a.group# asc;   



SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.14 Consultar si el undo requiere entonacion </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

col "ACTUAL UNDO SIZE [MByte]" format 99999999
col "UNDO RETENTION [Sec]" format a20
SELECT d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MByte]",
       SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]",
       ROUND((d.undo_size / (to_number(f.value) *
       g.undo_block_per_sec))) "OPTIMAL UNDO RETENTION [Sec]"
  FROM (
       SELECT SUM(a.bytes) undo_size
          FROM v$datafile a,
               v$tablespace b,
               dba_tablespaces c
         WHERE c.contents = 'UNDO'
           AND c.status = 'ONLINE'
           AND b.name = c.tablespace_name
           AND a.ts# = b.ts#
       ) d,
       v$parameter e, v$parameter f,
       (
       SELECT MAX(undoblks/((end_time-begin_time)*3600*24)) undo_block_per_sec
         FROM v$undostat
       ) g    WHERE e.name = 'undo_retention'   AND f.name = 'db_block_size';




SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.15 Consultar la recyclebin </h3>
SET MARKUP HTML ENTMAP ON

prompt STATUS DE LA RECYCLEBIN:

-- Ver estatus de la recyclebin (por default en on)
show parameter recyclebin;


prompt <h2> OBJETOS EN LA RECYCLEBYN <h2>

--Consultar objetos de la recyclebin
select object_name
,original_name
,type,operation
,droptime
,can_undrop
from user_recyclebin;




SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.16 Consultar objetos invalidos</h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

--- Mostrar todos los objetos invalidos 
select OWNER,OBJECT_NAME,OBJECT_TYPE,STATUS 
from dba_objects
where status = 'INVALID'
order by OWNER,OBJECT_TYPE,OBJECT_NAME;

--- Conteo de los objetos invalidos por squema
select count(1) OBJECT_INVALID
      ,OWNER, STATUS
from dba_objects 
where status ='INVALID'
group by OWNER, status 
order by OWNER desc;



SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.17 Validacion de objetos tipo tabla e indice que puedan estar en un mismo tablespace</h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

select tablespace_name
,segment_type
,count(1) CANTIDAD
from dba_segments
where segment_type in ('TABLE','INDEX')
and owner not in ('SYS'
,'SYSTEM'
,'OUTLN'
,'DBSNMP'
,'WMSYS'
,'ORDSYS'
,'ORDPLUGINS'
,'CTXSYS'
,'ANONYMOUS'
,'OLAPSYS'
,'SYSAUX'
,'STATSPACK_DATA')
AND TABLESPACE_NAME NOT IN ('SYSTEM','SYSAUX','USERS')
group by segment_type,tablespace_name
order by tablespace_name, segment_type;



SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.17 Validacion de objetos que estan en tablespace de SYSTEM </h3>
SET MARKUP HTML ENTMAP ON

--- Obtener esquemas que tienen objetos creados en el tablespace SYSTEM
col OWNER format a25
SELECT count(1) COUNT 
      ,OWNER
      ,SEGMENT_TYPE
FROM DBA_SEGMENTS
WHERE TABLESPACE_NAME = 'SYSTEM'
group by OWNER,SEGMENT_TYPE,TABLESPACE_NAME
order by OWNER,SEGMENT_TYPE;

SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.17 Validacion de objetos que estan en tablespace de SYSAUX </h3>
SET MARKUP HTML ENTMAP ON

--- Obtener esquemas que tienen objetos creados en el tablespace SYSAUX
col OWNER format a25
SELECT count(1) COUNT 
      ,OWNER
      ,SEGMENT_TYPE
FROM DBA_SEGMENTS
WHERE TABLESPACE_NAME = 'SYSAUX'
group by OWNER,SEGMENT_TYPE,TABLESPACE_NAME
order by OWNER,SEGMENT_TYPE;


SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.18 Verificar que el parametro _gc_policy_minimum tenga un valor de 15000 para un SGA>=100GB </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT a.ksppinm "Parameter",
       b.ksppstvl "Session Value",
       c.ksppstvl "Instance Value",
       decode(bitand(a.ksppiflg/256,1),1,'TRUE','FALSE') IS_SESSION_MODIFIABLE, 
       decode(bitand(a.ksppiflg/65536,3),1,'IMMEDIATE',2,'DEFERRED',3,'IMMEDIATE','FALSE') IS_SYSTEM_MODIFIABLE
FROM   x$ksppi a,
       x$ksppcv b,
       x$ksppsv c
WHERE  a.indx = b.indx
AND    a.indx = c.indx
AND    a.ksppinm LIKE '/_gc_policy_minimum' escape '/';



SET MARKUP HTML ENTMAP OFF
prompt <h3> 6.19 Verificar que el parametro gcs_server_processes tenga un valor de CPU/4 para un SGA>=100GB </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

show parameter gcs_server_processes;

SET MARKUP HTML ENTMAP OFF
prompt <p>Resource limit</p>
SET MARKUP HTML ENTMAP ON

-- Mostrar todos los limites de RESOURCE_LIMIT
col RESOURCE_NAME format a40
select * from gv$RESOURCE_LIMIT order by LIMIT_VALUE;


SET MARKUP HTML ENTMAP OFF
prompt <p>Database users</p>
SET MARKUP HTML ENTMAP ON

-- Database users 
select USER_ID, USERNAME, ACCOUNT_STATUS, LOCK_DATE, EXPIRY_DATE, DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE, PROFILE, CREATED from DBA_USERS order by ACCOUNT_STATUS;


REM **************************************************************************
REM     7 CARACTERISTICAS DE ESTADISTICAS DE LA BD
REM **************************************************************************

SET MARKUP HTML ENTMAP OFF
prompt <h2> 7 Caracteristicas de estadisticas de la BD </h2>
SET MARKUP HTML ENTMAP ON



SET MARKUP HTML ENTMAP OFF
prompt <h3> 7.1 Validacion los STALE STATISTICS </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT DT.OWNER,
       DT.TABLE_NAME, DT.LAST_ANALYZED,
       ROUND ( (DELETES + UPDATES + INSERTS) / NUM_ROWS * 100) STALE_PERCENT
       ,NUM_ROWS
FROM   DBA_TABLES DT
       ,DBA_TAB_MODIFICATIONS DTM
WHERE  DT.OWNER = DTM.TABLE_OWNER
       AND DT.TABLE_NAME = DTM.TABLE_NAME
       AND NUM_ROWS > 0 
       AND ROUND ( (DELETES + UPDATES + INSERTS) / NUM_ROWS * 100) >= 10 
       AND OWNER NOT IN ('SYS','SYSTEM','SYSMAN','DBSNMP')
ORDER BY 4 desc,5 desc;




SET MARKUP HTML ENTMAP OFF
prompt <h3> 7.2 Validacion de estadisticas del diccionario de datos </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT NVL(TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), 'NO STATS') last_analyzed
,OWNER
,COUNT(1) dictionary_tables
FROM dba_tables
WHERE owner IN ('SYS', 'SYSTEM')
GROUP BY TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), OWNER
ORDER BY 1 DESC;


SET MARKUP HTML ENTMAP OFF
prompt <h3> 7.3 Validacion de estadisticas de los FIXED_OBJECTS </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

select NVL(TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), 'NO STATS') last_analyzed
,COUNT(1) fixed_objects
FROM dba_tab_statistics
WHERE object_type = 'FIXED TABLE'
GROUP BY TO_CHAR(last_analyzed, 'YYYY-Mon-DD')
ORDER BY 1 DESC;



SET MARKUP HTML ENTMAP OFF
prompt <h3> 7.4 Validacion de las estadisticas del sistema</h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT * FROM SYS.AUX_STATS$;




REM **************************************************************************
REM     8 CARACTERISTICAS DE AUDITORIA DE LA BD
REM **************************************************************************

SET MARKUP HTML ENTMAP OFF
prompt <h2> 8 Caracteristicas de auditoria de la BD </h2>
SET MARKUP HTML ENTMAP ON


SET MARKUP HTML ENTMAP OFF
prompt <h3> 8.1 Validacion de la auditoria  </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

select name, value
from v$parameter
where name like 'audit_trail';



SET MARKUP HTML ENTMAP OFF
prompt <h3> 8.2 Validacion de la auditoria unificada </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT PARAMETER
,VALUE 
FROM V$OPTION 
WHERE PARAMETER = 'Unified Auditing';



SET MARKUP HTML ENTMAP OFF
prompt <h3> 8.3 Verificar los parametros de auditoria audit_sys_operations </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

show parameter audit_sys_operations;


SET MARKUP HTML ENTMAP OFF
prompt <h3> 8.4 Verificar el directorio de auditoria </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

SELECT VALUE FROM V$PARAMETER WHERE NAME = 'audit_file_dest';



SET MARKUP HTML ENTMAP OFF
prompt <h3> 8.5 Verificar el si la auditoria esta en un tablespace dedicado </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

col OWNER format a20
col SEGMENT_NAME format a40
col TABLESPACE_NAME format a40
select owner, segment_name, tablespace_name 
from dba_segments 
where segment_name like '%AUD$'or segment_name like '%FGA_LOG%';



SET MARKUP HTML ENTMAP OFF
prompt <h3> 8.6 Verificar el tamano de los objetos AUD </h3>
SET MARKUP HTML ENTMAP ON

prompt [Output]:

select owner
,segment_name
,segment_type
,BYTES/1024/1024 SIZE_MB 
from dba_segments 
where segment_name like '%AUD$' or segment_name like '%FGA_LOG%';


spool off
set markup html off
exit












