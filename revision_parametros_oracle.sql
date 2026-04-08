REM
REM File Name: caracteristicas_db.sql
REM 
REM Name: 
REM   caracteristicas_db.sql - Toma de parametros
REM
REM Description:
REM   Este script extrae los parametros de bases de datos importantes para la revision del best practice. 
REM
REM Modified:
REM   09/03/2023 - Creacion de script.
REM   
REM
REM Call Syntax:
REM   @caracteristicas_db.sql
REM
REM Last Modified: 31/12/2023
REM

spool caracteristicas_db.lst 


set line 380;
set timi on;
set time on;
set pagesize 500;

REM **************************************************************************
REM INFORMACION DE PLATAFORMA Y CONFIGURACION DE DB 
REM **************************************************************************

-- Informacion de base de datos
col "DB name" format a15
col "Unique Name" format a20
col "RAC" format a10
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

-- Informacion de la instancia
col "User Name" format a20
SELECT I.INSTANCE_NAME "Instance Name"
      ,I.INSTANCE_NUMBER "Instance Number"
      ,TO_CHAR(STARTUP_TIME, 'HH24:MI DD-MON-YY') "Startup Time"
      ,SYS_CONTEXT ('USERENV', 'SESSION_USER')  "User Name"
  FROM V$instance I;


-- Informacion de Plataforma
col "Hostname" format a20
col "Platform" format a20
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


-- Fecha de creacion de la base de datos
ALTER SESSION SET NLS_DATE_FORMAT="DD-MON-RRRR HH24:MI:SS";

select created from dba_users where username = 'SYS';
select min(created) FROM dba_objects;
select created from v$database;


REM **************************************************************************
REM VERSION DE BASE DE DATOS Y PARCHES
REM **************************************************************************

-- Version de base de datos 
colum product format a40;
colum version format a25;
colum status format a40;
col BANNER_FULL format a60
col BANNER_LEGACY format a60
col BANNER format a60

select * from v$version;

select * from product_component_version;

select comp_id, version from dba_registry;

col action_time format a30
col action format a12
col namespace format a10
col COMMENTS format a80
col bundle_series for a10
select * from registry$history;

--select * from registry$sqlpatch;

-- Validar version de producto de base de datos 
col product format a50;
col version format a20;
col status format a25;
col VERSION_FULL format a40
select * from product_component_version;


-- Validar parches aplicados en la base de datos 
set pagesize 100
col action_time for a40
col action for a12
col namespace for a10
col version for a22
col comments for a80
SELECT TO_CHAR(action_time, 'YYYY-MM-DD HH24:MI') AS FECHA
      ,action
      ,namespace
      ,version
      ,comments
    --,bundle_series
  FROM sys.registry$history
 ORDER by action_time;


REM **************************************************************************
REM INFORMACION A NIVEL DE DB CDB-PDB
REM **************************************************************************

-- Validar fecha de creacion de las db cdb y pdb
select cdb, con_id
      ,con_dbid
      ,db_unique_name
      ,created 
  from v$database;

-- Mostar nombre de todas las cdb y pdb 
select name, con_id, dbid, con_uid, guid from v$containers order by con_id;

show parameter name
show pdbs

-- Verificar version de producto oracle 
col status format a20
col product format a50
col version format a20
col version_full format a25
select * from product_component_version;  

--- Ver baner de version oracle completo 
select BANNER_FULL from v$VERSION; 


REM **************************************************************************
REM PARAMETROS DE BASES DE DATOS
REM **************************************************************************

-- Parametros de cluster 
show parameter cluster

-- Nombre de la intancia 
show parameter db_name

-- Nombre de la base de datos 
show parameter instance_name

-- Nombre de unico de la base de datos 
show parameter db_unique_name  

-- Remote listener y local listener
show parameter remote_listener
show parameter local_listener

-- Parametro db_bock size
show parameter db_block_size 

-- Parametro processes
show parameter processes 

-- Ruta del PFILE / SPFILE
show parameter pfile

-- Ubicacion control file 

show parameter control_files

-- Parametro de version compatible
col name format a20;
col value format a20;
select name,value
from v$parameter
where name like 'comp%';

show parameter compatible;

-- Parametro db_writer_processes
show parameter db_writer_processes; 

--- Ruta del controlfile 
show parameter control_files

--- Parametro del character set
col parameter format a50;
col value format a30;
SELECT *
  FROM nls_database_parameters
 WHERE parameter in ('NLS_NCHAR_CHARACTERSET','NLS_CHARACTERSET');

-- Parametros de recopilacion de estadisticas para el awr
show parameter statistics_level
show parameter statis

-- Consultar el intervalo de retención dias 

col snap_interval format a30
col retention format a30
select snap_interval
      ,retention 
  from dba_hist_wr_control;

-- Validar limites en el resource limit

col RESOURCE_NAME format a35
col INITIAL_ALLOCATION format a20
col LIMIT_VALUE format a20
select * from gv$resource_limit order by INST_ID,RESOURCE_NAME;

-- Parametros de sga, pga y shared_pool
show parameter sga
show parameter pga
show parameter shared_pool_size
show parameter gcs_server_processes 

-- Revision de parametros ocultos _gc_policy_minimum
set line 240
col "Session Value" format a20
col "Instance Value" format a20
col Parameter format a50

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
AND    a.ksppinm LIKE '/_gc_policy_min%' escape '/'  
/


REM **************************************************************************
REM CONFIGURACIONES DE FLASHBACK, ARCHIVE, ETC
REM **************************************************************************

-- Validar si esta en modo archive
archive log list;

-- ubicacion y tamaño de los archive
show parameter db_recovery_file_dest
show parameter db_recovery_file_dest_size
show parameter log_archive_dest

-- Verificar si esta habilitado el Flashback
select * from v$option where parameter like 'Flashback%';

-- Verificar fecha del open resetlog
select * from v$database_incarnation; 


--- Ver estatus de la recyclebin (por default en on)
show parameter recyclebin;

---Consultar objetos de la recyclebin
col owner format a25
col original_name format a35
col object_name format a40
select object_name, original_name,type,operation, droptime, can_undrop
  from user_recyclebin;



REM **************************************************************************
REM TAMAÑO DE TABLESPACE, DATAFILE, TEMPFILE, REDOLOG Y DB 
REM **************************************************************************

-- Listado de tablespaces y su tamaños
SET MARKUP HTML ENTMAP OFF
prompt -----
prompt Press enter to show all tablespace
prompt -----
SET MARKUP HTML ENTMAP ON

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
   AND a.TABLESPACE_NAME=nvl('&1',a.TABLESPACE_NAME)
 order by 5 desc
/


-- Listar los datafiles y sus tamaños
set line 380
col file_name format a80
set pagesize 200
select file_id,file_name 
      ,tablespace_name
      ,round((BYTES/1024)/1024,2) "Size (MB)"
  from dba_data_files 
 where tablespace_name=nvl('&1',tablespace_name);


--- Cantidad de tablespace 
col Tablespace format a30; 
col Fichero_de_datos format a80; 

SELECT t.tablespace_name "Tablespace"
      ,t.status "Estado"
      ,ROUND(MAX(d.bytes)/1024/1024,2) "MB_Tamano"
      ,ROUND((MAX(d.bytes)/1024/1024) - (SUM(decode(f.bytes, NULL,0, f.bytes))/1024/1024),2) "MB_Usados"
      ,ROUND(SUM(decode(f.bytes, NULL,0, f.bytes))/1024/1024,2) "MB_Libres"
      ,t.pct_increase "%_incremento"
      ,SUBSTR(d.file_name,1,80) "Fichero_de_datos"  
  FROM DBA_FREE_SPACE f
      ,DBA_DATA_FILES d
      ,DBA_TABLESPACES t  
 WHERE t.tablespace_name = d.tablespace_name 
   AND f.tablespace_name(+) = d.tablespace_name    
   AND f.file_id(+) = d.file_id 
 GROUP BY t.tablespace_name
         ,d.file_name
         ,t.pct_increase
         ,t.status
 ORDER BY 1,3 DESC;

-- Cantidad de datafiles 
col name format a80
select name, file#, status, checkpoint_change# "checkpoint" from v$datafile;


-- Cantidada de redologs files 
select * from v$log;   

--- Grupos de redologs 
select group#,sequence#,bytes/1024/1024m,members,status from v$log;     

-- NOTA: Los Redologs multiplexados : Es cuando tienen mas de un grupo de redos.

-- Verificar el undo, la retencion es en segundos
show parameters undo_retention;

--

REM **************************************************************************
REM SCHEMAS DE BASE DE DATOS
REM **************************************************************************

--- Usuarios de la base de datos 
col USERNAME format a25;
col ACCOUNT_STATUS format a20;
col PROFILE format a25;
col TEMPORARY_TABLESPACE format a10;
col DEFAULT_TABLESPACE format a20;
select USER_ID, USERNAME, ACCOUNT_STATUS, LOCK_DATE, EXPIRY_DATE, DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE, PROFILE, CREATED from DBA_USERS;

-- Total de usuarios
--select count(*) Total_usuarios FROM DBA_USERS;


--- Contar sessiones conectadas por usuario (sencillo y mas usado)

set line 240
col username format a20
col MACHINE format a80
select count(1), username , inst_id, MACHINE from gv$session
--where username='XX'
 group by username, inst_id, machine
 order by 2,3
/

REM **************************************************************************
REM PARAMETROS DE DATAGUARD
REM **************************************************************************

-- Parametros de dataguard
show parameter LOG_ARCHIVE_CONFIG
show parameter DB_FILE_NAME_CONVERT
show parameter LOG_FILE_NAME_CONVERT
show parameter LOG_ARCHIVE_DEST_
show parameter LOG_ARCHIVE_DEST_STATE_
show parameter DG_BROKER_START
show parameter DG_BROKER_CONFIG_FILE1
show parameter DG_BROKER_CONFIG_FILE2
--show parameter STANDBY_ARCHIVE_DEST
show parameter STANDBY_FILE_MANAGEMENT
show parameter FAL_SERVER
show parameter FAL_CLIENT


REM **************************************************************************
REM OBJETOS DE BASES DE DATOS
REM **************************************************************************

-- Validar si existen objetos invalidos 
col OWNER format a40
col OBJECT_NAME format a40
select OWNER
      ,OBJECT_NAME
      ,OBJECT_TYPE
      ,STATus  
  from dba_objects
where status = 'INVALID';

--- Validar el status los componentes de la base de datos
col COMP_NAME format a40
col VERSION format a20
col STATUS format a20

SELECT comp_name
      ,version
      ,status
  FROM dba_registry;

-- Objetos en el tablespace SYS

select owner
      --,segment_name
      ,segment_type 
  from dba_segments 
 where tablespace_name='SYSAUX'
 group by owner,segment_type 
order by 2,1;


-- Objetos en el tablespace SYSTEM

select owner
      --,segment_name
      ,segment_type 
  from dba_segments 
 where tablespace_name='SYSTEM'
 group by owner,segment_type 
order by 2,1;

--- Objetos en tablespaces separados

set line 380
set pagesize 1000
col OWNER format a35
col SEGMENT_NAME format a40
select count(1) count
      ,owner
      ,segment_name
      ,segment_type
      ,tablespace_name
      ,sum(bytes)/1024/1024/1024 "size (GB)"
from dba_segments
where tablespace_name not in ('UNDOTBS1', 'UNDOTBS2')
group by segment_type, tablespace_name,segment_name,owner
order by 6,5 
/





REM --------------------------------------------------------------------------


REM **************************************************************************
REM VER UBICACION DE WALLET
REM *************************************************************************

--Validar parámetros del wallet
col WRL_PARAMETER format a45
col status format a10
SELECT * FROM V$ENCRYPTION_WALLET;

REM
REM --------------------------------------------------------------------------
REM


REM **************************************************************************
REM VER ENTONACION DE UNDO
REM *************************************************************************

--VER SI EL UNDO REQUIERE ENTONACION

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



REM
REM --------------------------------------------------------------------------
REM

spool off
--exit




