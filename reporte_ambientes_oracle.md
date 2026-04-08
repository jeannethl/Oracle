# Reporte de BD <!-- omit in toc -->

## Index <!-- omit in toc -->

- [Show statistics level](#show-statistics-level)
- [Show retention snap\_interval](#show-retention-snap_interval)
- [show `_gcs_server_proceses` y `shared_pool`](#show-_gcs_server_proceses-y-shared_pool)
  - [Show \_gc\_policy\_minimum](#show-_gc_policy_minimum)
- [Show oracle home](#show-oracle-home)
- [REVISION DEL NOMBRE DE LOS NODOS](#revision-del-nombre-de-los-nodos)
- [Size Redologs](#size-redologs)
- [VERSION DEL SISTEMA OPERATIVO](#version-del-sistema-operativo)
- [ver hostname de la maquina](#ver-hostname-de-la-maquina)
- [ver parametros del kernel linux](#ver-parametros-del-kernel-linux)
- [Show resource limits](#show-resource-limits)
- [Errores en el alert log en el ultimo mes](#errores-en-el-alert-log-en-el-ultimo-mes)
- [Revisar Grid, crs, ASM](#revisar-grid-crs-asm)
- [Validar timezone de los ultimos reinicios](#validar-timezone-de-los-ultimos-reinicios)
  - [Revisión de parches instalados](#revisión-de-parches-instalados)
  - [Tanto en grid como oracle desde SO](#tanto-en-grid-como-oracle-desde-so)
- [Memoria ram](#memoria-ram)
  - [Ram en Windows](#ram-en-windows)
  - [Linux-unix](#linux-unix)
  - [Solaris](#solaris)
  - [AIX](#aix)
  - [HP-UX](#hp-ux)
- [Memoria swap](#memoria-swap)
- [Numero de procesadores](#numero-de-procesadores)
  - [Windows](#windows)
  - [Procesadores en linux](#procesadores-en-linux)
- [VERSION DEL MANEJADOR DE BD](#version-del-manejador-de-bd)
- [INFORMACION DE LA BD](#informacion-de-la-bd)
- [INFORMACION DE LA INSTANCIA](#informacion-de-la-instancia)
- [Tamaño sga](#tamaño-sga)
- [PARAMETOS DE BD](#parametos-de-bd)
- [Character set](#character-set)
- [DISCOS DE ASM](#discos-de-asm)
- [CANTIDAD DE DATAFILES](#cantidad-de-datafiles)
- [Propiedades del diccionario bd](#propiedades-del-diccionario-bd)
- [REVISION BACKUPS](#revision-backups)
  - [SHOW OUTPUT BACKUP](#show-output-backup)
- [Componentes instalados validos en la base de datos](#componentes-instalados-validos-en-la-base-de-datos)
- [REVISION DE PATCH](#revision-de-patch)
- [REVISION Esperas de eventos](#revision-esperas-de-eventos)
- [REVISION DE OBJETOS DE DIFERENTE TIPO EN EL MISMO TABLESPACE](#revision-de-objetos-de-diferente-tipo-en-el-mismo-tablespace)
- [REVISION DE TABLAS CON 10 O MAS INDICES](#revision-de-tablas-con-10-o-mas-indices)
- [REVISION DE INDICES CON MAYOR TAMAÑO QUE SUS TABLAS](#revision-de-indices-con-mayor-tamaño-que-sus-tablas)
- [REVISION DE TABLAS FRAGMENTADAS](#revision-de-tablas-fragmentadas)
- [Tamaño de los redologs no óptimos](#tamaño-de-los-redologs-no-óptimos)
- [REVISION DE ESTADISTICAS VENCIDAS](#revision-de-estadisticas-vencidas)
- [REVISION DE OBJETOS INVALIDOS](#revision-de-objetos-invalidos)
- [REVISION DE OBJETOS EN PAPELERA DE RECICLAJE](#revision-de-objetos-en-papelera-de-reciclaje)
- [REVISION DE tablespaces](#revision-de-tablespaces)
- [REVISION DATAFILES AUTOEXTEND](#revision-datafiles-autoextend)
- [REVISION TABLAS SIN PRIMARY KEY](#revision-tablas-sin-primary-key)
- [Tablespace Auto Management](#tablespace-auto-management)
- [Uso de TAF](#uso-de-taf)
- [INDEX NO UTILIZADOS](#index-no-utilizados)
- [tamaño de la bd](#tamaño-de-la-bd)
- [OBTENER IP DEL SERVIDOR DE BD](#obtener-ip-del-servidor-de-bd)
- [REVISION DE REDOS](#revision-de-redos)
- [Tamaño de schemas](#tamaño-de-schemas)
- [REVISION DE ESPERAS POR OBJETO](#revision-de-esperas-por-objeto)
- [SHOW TABLES](#show-tables)
- [SHOW INDEXES](#show-indexes)
- [REVISION DE CARDINALIDAD DE LOS INDICES](#revision-de-cardinalidad-de-los-indices)
  - [PLSQL correr unicamente](#plsql-correr-unicamente)
- [REVISION CANDIDATAS A PARTICIONAR](#revision-candidatas-a-particionar)
- [REVISION FILAS ENCADENADAS](#revision-filas-encadenadas)
- [QUERIES MAS COSTOSOS](#queries-mas-costosos)
  - [Windows statspack 9i](#windows-statspack-9i)
- [REVISION INDICES CON PROPIEDAD LOGIN NO ACTIVA](#revision-indices-con-propiedad-login-no-activa)
- [REVISION ALL SQLTEXT](#revision-all-sqltext)
- [REVISION ADVISOR DEL SGA](#revision-advisor-del-sga)
- [REVISION CANTIDAD DE OBJETOS POR SCHEMA](#revision-cantidad-de-objetos-por-schema)
- [REVISION Objetos con ITL Waits](#revision-objetos-con-itl-waits)
- [REVISION QUERIES CON MAS DE 20 VERSIONES](#revision-queries-con-mas-de-20-versiones)
- [REVISION Esperas de eventos DB CPU](#revision-esperas-de-eventos-db-cpu)
- [REVISION USO DE CPU POR USUARIO](#revision-uso-de-cpu-por-usuario)
- [REVISION OBJETOS CON CARACTERISTICAS DE RESPALDO](#revision-objetos-con-caracteristicas-de-respaldo)
- [REVISION DATAFILES IRRECUPERABLES POR TABLESPACE NO LOGGIN](#revision-datafiles-irrecuperables-por-tablespace-no-loggin)
- [CHECK DATAFILES](#check-datafiles)

## Show statistics level

El parametro `statistics_level` debe estar en **ALL**, de esa forma obtener metricas de I/O.

```sql
show parameter statistics_level
```

## Show retention snap_interval

El valor de `snap_interval` se recomienda que este en 15min

```sql
SELECT snap_interval
, retention 
FROM dba_hist_wr_control;
```

## show `_gcs_server_proceses` y `shared_pool`

Para ambientes que poseen SGA > 100GB, se debe modificar los siguientes parámetros:

- _gcs_server_proceses
- shared_pool
- _gc_policy_minimum

```sql
show parameter _gcs_server_proceses
show parameter shared_pool
```

### Show _gc_policy_minimum

```sql
SET LINES 235
COL PARAMETER   FOR A20
COL INSTANCE    FOR A10
COL DESCRIPTION FOR A40 WORD_WRAPPED
SELECT
  a.ksppinm  "Parameter",
  c.ksppstvl "Instance",      
  a.ksppdesc "Description"
FROM
  x$ksppi     a,
  x$ksppcv    b,
  x$ksppsv    c,
  v$parameter p
WHERE
  a.indx = b.indx
AND
  a.indx = c.indx  
AND
  p.name(+) = a.ksppinm  
AND
  UPPER(a.ksppinm) LIKE UPPER('%gc_policy%')
ORDER BY
  a.ksppinm;
```

## Show oracle home

```sql
var oracle_home clob;
exec dbms_system.get_env('ORACLE_HOME', :oracle_home);
print oracle_home;
```

## REVISION DEL NOMBRE DE LOS NODOS

Con usuario grid

```bash
olsnodes
```

## Size Redologs

```sql
col h0 format 9999
col h1 format 9999
col h2 format 9999
col h3 format 9999
col h4 format 9999
col h5 format 9999
col h6 format 9999
col h7 format 9999
col h8 format 9999
col h9 format 9999
col h10 format 9999
col h11 format 9999
col h12 format 9999
col h13 format 9999
col h14 format 9999
col h15 format 9999
col h16 format 9999
col h17 format 9999
col h18 format 9999
col h19 format 9999
col h20 format 9999
col h21 format 9999
col h22 format 9999
col h23 format 9999
col Day format a3
col Total format 9999
set lin 240 pagesize 300
alter session set nls_date_format='dd-mm-rrrr';
SELECT TRUNC(first_time) "Date"
, TO_CHAR(first_time, 'Dy') "Day"
, COUNT (1) "Total",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '00', 1, 0)) "h0",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '01', 1, 0)) "h1",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '02', 1, 0)) "h2",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '03', 1, 0)) "h3",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '04', 1, 0)) "h4",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '05', 1, 0)) "h5",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '06', 1, 0)) "h6",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '07', 1, 0)) "h7",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '08', 1, 0)) "h8",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '09', 1, 0)) "h9",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '10', 1, 0)) "h10",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '11', 1, 0)) "h11",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '12', 1, 0)) "h12",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '13', 1, 0)) "h13",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '14', 1, 0)) "h14",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '15', 1, 0)) "h15",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '16', 1, 0)) "h16",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '17', 1, 0)) "h17",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '18', 1, 0)) "h18",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '19', 1, 0)) "h19",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '20', 1, 0)) "h20",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '21', 1, 0)) "h21",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '22', 1, 0)) "h22",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '23', 1, 0)) "h23"
FROM v$log_history
where to_char(first_time,'YYYY-MM-DD') >= to_char(sysdate-15,'YYYY-MM-DD')
GROUP BY TRUNC(first_time), TO_CHAR(first_time, 'Dy')
ORDER BY 1 
/
```

## VERSION DEL SISTEMA OPERATIVO

```bash
cat /etc/oracle-release
```

```bash
hostnamectl
```

```sql
sqlplus -S / as sysdba<<EOF
select dbms_utility.port_string from dual;
select os, COUNT(1) from dbmon.hosts group by os;
select platform_id,platform_name from v$database;
exit;
EOF
```

## ver hostname de la maquina

```bash
hostname
```

## ver parametros del kernel linux

```bash
sysctl -a
```

## Show resource limits

```sql
SELECT inst_id
, resource_name
, current_utilization
, max_utilization
, limit_value 
FROM gv$resource_limit;
```

## Errores en el alert log en el ultimo mes

```sql
query
```

## Revisar Grid, crs, ASM

```sql
Querys
```

## Validar timezone de los ultimos reinicios

```sql
SET SPACE 1 LINESIZE 80 PAGES 1000
SELECT * FROM (
select to_char(ORIGINATING_TIMESTAMP,'YYYY/MM/DD HH24:MI:SS TZH:TZM') as TIMESATMP
from V$DIAG_ALERT_EXT
WHERE trim(COMPONENT_ID)='rdbms'
and MESSAGE_TEXT like ('PMON started with%')
order by originating_timestamp desc )
WHERE rownum < 20;
```

### Revisión de parches instalados

```sql
set lines 255 pages 300
col action_time for a40
col action for a8
col namespace for a7
col version for a11
col comments for a40
select substr(ACTION_TIME,1,40) action_time
, substr(ACTION,1,8) action
, substr(NAMESPACE,1,7) namespace
, substr(VERSION,1,11) version
-- , ID
, substr(COMMENTS,1,40) comments
, BUNDLE_SERIES 
from registry$history
where BUNDLE_SERIES='PSU';
```

```sql
SELECT patch_id,
version,
status,
bundle_id,
bundle_series
FROM dba_registry_sqlpatch;
```

### Tanto en grid como oracle desde SO

```bash
$ORACLE_HOME/OPatch/opatch lsinventory | egrep "Patch  |Unique Patch ID|Patch description"
```

## Memoria ram

### Ram en Windows

```sql
col VALUE for 999,999,999
select max(value)/1024/1024 VALUE
from dba_hist_osstat
where stat_name = 'PHYSICAL_MEMORY_BYTES';
```

### Linux-unix

```bash
free -m
```

### Solaris
  
```bash
prtconf | grep -i mem
```

### AIX
  
```bash
lsdev -C | grep mem
```

### HP-UX

```bash
/usr/contrib/bin/machinfo
vmstat 1 2 | tail -1 | awk '{ print $4/1024  }'
```

## Memoria swap

```bash
swapinfo -tm
```

## Numero de procesadores

### Windows

```sql
col c1 heading '#|CPUs'        format 999
col c2 heading '#|CPU|Cores'   format 999
col c3 heading '#|CPU|Sockets' format 999
select
   (select max(value) from dba_hist_osstat 
    where stat_name = 'NUM_CPUS')        c1,
   (select max(value) from dba_hist_osstat 
    where stat_name = 'NUM_CPU_CORES')   c2,
   (select max(value) from dba_hist_osstat 
    where stat_name = 'NUM_CPU_SOCKETS') c3
from dual;
```

### Procesadores en linux

```bash
nproc --all

cat /proc/cpuinfo | grep "model name"

cat /proc/cpuinfo | grep "cpu cores"
```

## VERSION DEL MANEJADOR DE BD

```sql
SELECT version FROM V$INSTANCE;
```

## INFORMACION DE LA BD

```sql
SELECT DBID, NAME FROM V$DATABASE;
```

## INFORMACION DE LA INSTANCIA

```sql
SELECT INSTANCE_NAME FROM V$INSTANCE;
SELECT name FROM v$database;
```

## Tamaño sga

```sql
break on report on name skip 1
compute sum label "SGA TOTAL:"  of MB on report
SELECT name
, ROUND(value/1024/1024,2) MB 
FROM v$sga
order by 1;
clear column
clear break
```

## PARAMETOS DE BD

```sql
set line 380
col parameter format a32
col value format a32
select parameter,value from nls_database_parameters ;


set line 180 pages 300
col value format a60
col "PARAMETER_NAME" format a45
col ISMODIFIED format a15
SELECT NAME "PARAMETER_NAME"
, VALUE
, ISMODIFIED 
FROM V$PARAMETER 
WHERE NAME IN ('_adg_parselock_timeout'
, 'archive_lag_target'
, '_clusterwide_global_transactions'
, 'audit_file_dest'
, 'audit_trail'
, 'cluster_database'
, 'compatible'
, 'control_files'
, 'db_block_size'
, 'db_domain'
, 'db_file_name_convert'
, 'db_files'
, 'db_name'
, 'db_recovery_file_dest'
, 'db_recovery_file_dest_size'
, 'db_securefile'
, 'db_writer_processes'
, 'dg_broker_config_file1'
, 'dg_broker_config_file2'
, 'dg_broker_start'
, 'diagnostic_dest'
, 'dispatchers'
, 'fal_client'
, 'fal_server'
, 'gcs_server_processes'
, 'global_txn_processes'
, 'instance_number'
, 'job_queue_processes'
, 'log_archive_config'
, 'log_archive_dest_1'
, 'log_archive_dest_2'
, 'log_archive_dest_state_1'
, 'log_archive_dest_state_2'
, 'log_archive_format'
, 'log_archive_max_processes'
, 'log_archive_min_succeed_dest'
, 'log_archive_start'
, 'log_archive_trace'
, 'log_file_name_convert'
, 'max_dump_file_size'
, 'nls_date_format'
, 'noncdb_compatible'
, 'open_cursors'
, 'parallel_threads_per_cpu'
, 'pdb_file_name_convert'
, 'pga_aggregate_target'
, 'processes'
, 'remote_login_passwordfile'
, 'session_cached_cursors'
, 'sessions'
, 'sga_max_size'
, 'sga_target'
, 'shared_server_sessions'
, 'spfile'
, 'standby_archive_dest'
, 'standby_file_management'
, 'thread'
, 'threaded_execution'
, 'undo_tablespace') 
order by 1;
```

## Character set

```sql
set line 180 pages 300
column VALUE format a32
column PARAMETER format a30
select * from v$nls_parameters;


set line 180 pages 300
col PROPERTY_NAME for a40
col value for a50
SELECT PROPERTY_NAME, SUBSTR(property_value, 1, 30) value
FROM DATABASE_PROPERTIES
ORDER BY PROPERTY_NAME
/
```

## DISCOS DE ASM

```sql
set line 180 pages 300
col STATE for a15
col TYPE for a10
col TOTAL_MB for 999999999
col FREE_MB for 999999999
col PCT_USED for a15
col USABLE_FILE_MB for 999999999
col NAME for a25
select STATE
, TYPE
, TOTAL_MB
, FREE_MB
, DECODE(ROUND(((TOTAL_MB-FREE_MB)/DECODE(TOTAL_MB,0,1,TOTAL_MB))*100,2),0,0,ROUND(((TOTAL_MB-FREE_MB)/DECODE(TOTAL_MB,0,1,TOTAL_MB))*100,2)) ||'%' PCT_USED
, REQUIRED_MIRROR_FREE_MB
, USABLE_FILE_MB
, NAME
from v$asm_diskgroup;
```

## CANTIDAD DE DATAFILES

```sql
select count(1) from v$datafile;
```

## Propiedades del diccionario bd

```sql
set line 380 pages 300
col value$ format a32
col name format a32
select NAME, VALUE$ from sys.props$;
```

## REVISION BACKUPS

```sql
set lines 380;
set pages 300
col INICIO format a18;
col FIN format a18;
col STATUS format a30;
col device format a10;
col TIPO format a11;
SELECT to_char(start_time,'dd-mm-yy hh24:mi:ss') as INICIO
, to_char(end_time,'dd-mm-yy hh24:mi:ss') as FIN
, NVL(output_device_type, 'SBT_TYPE') DEVICE
, REPLACE(input_type,'DB FULL','DB_FULL') TIPO
, REPLACE(status,'COMPLETED WITH WARNINGS','COMPLETED_WITH_WARNINGS') STATUS
FROM v$rman_backup_job_details
where  trunc(start_TIME) >= trunc(sysdate-7)
order by start_time;
```

### SHOW OUTPUT BACKUP

```sql
set lines 380
set pages 1000
col cf for 9,99
col df for 9,99
col elapsed_seconds format 999999
col elapsed_seconds heading "ELAPSED|SECONDS"
col i0 for 9,99
col i1 for 9,99
col l for 9,99
col END_TIME format a20
col start_time format a20
col dow format a9
col output_mbytes for 9,999,999 heading "OUTPUT|MBYTES"
col session_recid for 999999 heading "SESSION|RECID"
col session_stamp for 99999999999 heading "SESSION|STAMP"
col status for a10 trunc
col time_taken_display for a10 heading "TIME|TAKEN"
col output_instance for 9999 heading "OUT|INST"
select
  j.session_recid, j.session_stamp,
  to_char(j.start_time, 'yyyy-mm-dd hh24:mi:ss') start_time,
  to_char(j.end_time, 'yyyy-mm-dd hh24:mi:ss') end_time,
  (j.output_bytes/1024/1024) output_mbytes
  , j.status
  , j.input_type
  , decode(to_char(j.start_time, 'd'), 1, 'Sunday', 2, 'Monday',
                                     3, 'Tuesday', 4, 'Wednesday',
                                     5, 'Thursday', 6, 'Friday',
                                     7, 'Saturday') dow
  , j.elapsed_seconds
  , j.time_taken_display
  , x.cf, x.df, x.i0, x.i1, x.l,
  ro.inst_id output_instance
  from V$RMAN_BACKUP_JOB_DETAILS j
  left outer join (select
                     d.session_recid, d.session_stamp,
                     sum(case when d.controlfile_included = 'YES' then d.pieces else 0 end) CF,
                     sum(case when d.controlfile_included = 'NO'
                               and d.backup_type||d.incremental_level = 'D' then d.pieces else 0 end) DF,
                     sum(case when d.backup_type||d.incremental_level = 'D0' then d.pieces else 0 end) I0,
                     sum(case when d.backup_type||d.incremental_level = 'I1' then d.pieces else 0 end) I1,
                     sum(case when d.backup_type = 'L' then d.pieces else 0 end) L
                   from
                     V$BACKUP_SET_DETAILS d
                     join V$BACKUP_SET s on s.set_stamp = d.set_stamp and s.set_count = d.set_count
                   where s.input_file_scan_only = 'NO'
                   group by d.session_recid, d.session_stamp) x
    on x.session_recid = j.session_recid and x.session_stamp = j.session_stamp
  left outer join (select o.session_recid, o.session_stamp, min(inst_id) inst_id
                   from GV$RMAN_OUTPUT o
                   group by o.session_recid, o.session_stamp)
    ro on ro.session_recid = j.session_recid and ro.session_stamp = j.session_stamp
    where j.start_time > trunc(sysdate)-&NUMBER_OF_DAYS
order by j.start_time
/
```

```sql
set lines 200
set pages 1000
select output
from GV$RMAN_OUTPUT
where session_recid = 93564
and session_stamp = 1102025740
order by recid;
```

## Componentes instalados validos en la base de datos

```sql
SET PAGESIZE 100
SET LINESIZE 180
SET VERIFY OFF
COL comp_id FOR a15 HEA 'Component ID' 
COL comp_name FOR a40 HEA 'Component' 
COL version FOR a17 HEA 'Version' 
COL status FOR a10 HEA 'Status' 
SELECT comp_id
, comp_name
, version
, status FROM dba_registry
/
```

## REVISION DE PATCH

```sql
set lines 255 pages 300
col action_time for a40
col action for a8
col namespace for a7
col version for a11
col comments for a40
select substr(ACTION_TIME,1,40) action_time
, substr(ACTION,1,8) action
, substr(NAMESPACE,1,7) namespace
, substr(VERSION,1,11) version
-- , ID
, substr(COMMENTS,1,40) comments
, BUNDLE_SERIES 
from registry$history
where BUNDLE_SERIES='PSU'; 
```

```sql
SELECT patch_id, version, status, bundle_id, bundle_series FROM dba_registry_sqlpatch;
```

```bash
# grid y oracle
$ORACLE_HOME/OPatch/opatch lsinventory|egrep "Patch  |Unique Patch ID|Patch description"
```

## REVISION Esperas de eventos

```sql
set pages 999
set line 380
column c1 heading 'Event|Name'             format a30
column c2 heading 'Total|Waits'            format 999,999,999
column c3 heading 'Seconds|Waiting'        format 999,999,999
column c4 heading 'Total|Timeouts'         format 999,999,999
column c5 heading 'Average|Wait|(in secs)' format 99.999

ttitle 'System-wide Wait Analysis|for current wait events'

select
   event                         c1,
   total_waits                   c2,
   time_waited / 100             c3,
   total_timeouts                c4,
   average_wait    /100          c5
   from
   sys.v_$system_event
   where
   event not in (
    'dispatcher timer',
    'lock element cleanup',
    'Null event',
    'parallel query dequeue wait',
    'parallel query idle wait - Slaves',
    'pipe get',
    'PL/SQL lock timer',
    'pmon timer',
    'rdbms ipc message',
    'slave wait',
    'smon timer',
    'SQL*Net break/reset to client',
    'SQL*Net message from client',
    'SQL*Net message to client',
    'SQL*Net more data to client',
    'virtual circuit status',
    'WMON goes to sleep'
   )
   AND
 event not like 'DFS%'
 and
   event not like '%done%'
   and
   event not like '%Idle%'
   AND
 event not like 'KXFX%'
 order by
   c2 desc
   /
```

```sql
select
     event "Event Name",
     waits "Waits",
     timeouts "Timeouts",
     time "Wait Time (s)",
     avgwait "Avg Wait (ms)",
     waitclass "Wait Class"
from
    (select e.event_name event
          , e.total_waits - nvl(b.total_waits,0)  waits
          , e.total_timeouts - nvl(b.total_timeouts,0) timeouts
          , (e.time_waited_micro - nvl(b.time_waited_micro,0))/1000000  time
          ,  decode ((e.total_waits - nvl(b.total_waits, 0)), 0, to_number(NULL),
            ((e.time_waited_micro - nvl(b.time_waited_micro,0))/1000) / (e.total_waits - nvl(b.total_waits,0)) ) avgwait
          , e.wait_class waitclass
     from
        dba_hist_system_event b ,
        dba_hist_system_event e
     where
                      b.snap_id(+)          = &pBgnSnap
                  and e.snap_id             = &pEndSnap
                  and b.dbid(+)             = &pDbId
                  and e.dbid                = &pDbId
                  and b.instance_number(+)  = &pInstNum
                  and e.instance_number     = &pInstNum
                  and b.event_id(+)         = e.event_id
                  and e.total_waits         > nvl(b.total_waits,0)
                  and e.wait_class          <> 'Idle' )
order by time desc, waits desc
/
```

## REVISION DE OBJETOS DE DIFERENTE TIPO EN EL MISMO TABLESPACE

```sql
set lines 180 pages 999;
col tablespace_name form a30
select tablespace_name
, segment_type
, count(1) CANT
from dba_segments
where segment_type in ('TABLE','INDEX') 
and owner not in ('SYS'
, 'SYSTEM'
, 'OUTLN'
, 'DBSNMP'
, 'WMSYS'
, 'ORDSYS'
, 'ORDPLUGINS'
, 'CTXSYS'
, 'ANONYMOUS'
, 'OLAPSYS'
, 'SYSAUX'
, 'STATSPACK_DATA')
AND TABLESPACE_NAME NOT IN ('SYSTEM','SYSAUX','USERS')
group by segment_type, tablespace_name
order by tablespace_name, segment_type;
```

## REVISION DE TABLAS CON 10 O MAS INDICES

```sql
set line 180 pages 300
col owner for a25
col TABLE_NAME for a40
col  index_count for 999,999,999
select owner||'.'||table_name TABLE_NAME
, COUNT(1) index_count
from dba_indexes
where owner not in ('SYS','SYSTEM','SYSMAN','OUTLN','CTXSYS','XDB','MDSYS','APEX_030200')
having COUNT(1) > 10
group by owner, table_name
order by COUNT(1) desc;
```

## REVISION DE INDICES CON MAYOR TAMAÑO QUE SUS TABLAS 

```sql
set lines 380 pages 2000
col OWNER format a25
col INDEXES format a30
col TABLAS format a30
select  distinct indx.owner
, index_name indexes
, indx.bytes/1024 Index_KB
, table_name tablas
, tabl.bytes/1024 Tabla_KB
from
(select owner,segment_name indexes,bytes
  from dba_segments
  where segment_type='INDEX'
    and owner not in
  ('SYS','SYSTEM','OUTLN','DBSNMP','WMSYS','ORDSYS','ORDPLUGINS','CTXSYS','ANONYMOUS','OLAPSYS','SYSMAN','PERFSTAT','ORDDATA','APEX_030200')
) indx,
(select owner,segment_name tablas,bytes
  from dba_segments
  where segment_type='TABLE'
    and owner not in ('SYS','SYSTEM','OUTLN','DBSNMP','WMSYS','ORDSYS','ORDPLUGINS','CTXSYS','ANONYMOUS','OLAPSYS','SYSMAN','PERFSTAT','ORDDATA','APEX_030200')
) tabl, dba_indexes
where indx.owner=tabl.owner
and indexes=index_name
and tablas=table_name
and indx.bytes > tabl.bytes
order by Index_KB desc,owner,index_name;
```

## REVISION DE TABLAS FRAGMENTADAS

```sql
set lines 380 pages 2000
col TABLE_NAME format a30
col OWNER format a20
col segment_type format a20
col "size (mb)"  format 999,999,999.99
col "actual_data (mb)"  format 999,999,999.99
col "wasted_space (mb)"  format 999,999,999.99
select a.owner
, table_name
, b.segment_type
, extents,round((a.blocks*8)/1024,2) "size (mb)" 
, round((a.num_rows*a.avg_row_len/1024)/1024,2) "actual_data (mb)",
  (round((a.blocks*8),2) - round((a.num_rows*a.avg_row_len/1024/1024),2)) "wasted_space (mb)"
from dba_tables a, dba_segments b
where a.owner=b.owner
and a.owner not in ('SYS','SYSTEM')
and a.table_name=segment_name
and (round((a.blocks*8),2) > round((a.num_rows*a.avg_row_len/1024),2))
and extents >=100
order by extents ,a.owner ,table_name asc;
```

## Tamaño de los redologs no óptimos

```sql
col h0 format 9999
col h1 format 9999
col h2 format 9999
col h3 format 9999
col h4 format 9999
col h5 format 9999
col h6 format 9999
col h7 format 9999
col h8 format 9999
col h9 format 9999
col h10 format 9999
col h11 format 9999
col h12 format 9999
col h13 format 9999
col h14 format 9999
col h15 format 9999
col h16 format 9999
col h17 format 9999
col h18 format 9999
col h19 format 9999
col h20 format 9999
col h21 format 9999
col h22 format 9999
col h23 format 9999
col Day format a3
col Total format 9999
set lin 240 pagesize 300
alter session set nls_date_format='dd-mm-rrrr';
SELECT TRUNC (first_time) "Date", TO_CHAR (first_time, 'Dy') "Day",
COUNT (1) "Total",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '00', 1, 0)) "h0",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '01', 1, 0)) "h1",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '02', 1, 0)) "h2",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '03', 1, 0)) "h3",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '04', 1, 0)) "h4",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '05', 1, 0)) "h5",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '06', 1, 0)) "h6",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '07', 1, 0)) "h7",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '08', 1, 0)) "h8",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '09', 1, 0)) "h9",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '10', 1, 0)) "h10",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '11', 1, 0)) "h11",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '12', 1, 0)) "h12",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '13', 1, 0)) "h13",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '14', 1, 0)) "h14",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '15', 1, 0)) "h15",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '16', 1, 0)) "h16",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '17', 1, 0)) "h17",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '18', 1, 0)) "h18",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '19', 1, 0)) "h19",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '20', 1, 0)) "h20",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '21', 1, 0)) "h21",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '22', 1, 0)) "h22",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '23', 1, 0)) "h23"
FROM v$log_history
where to_char(first_time,'YYYY-MM-DD') >= to_char(sysdate-15,'YYYY-MM-DD')
GROUP BY TRUNC (first_time), TO_CHAR (first_time, 'Dy')
ORDER BY 1 
/
```

## REVISION DE ESTADISTICAS VENCIDAS

```sql
set lines 120 pages 2000
column owner format a20
column table_name format a30
col LAST_ANALYZED for a25
col STALE_PERCENT for 999
col NUM_ROWS for 999,999,999
SELECT DT.OWNER
, DT.TABLE_NAME
, TO_CHAR(DT.LAST_ANALYZED,'YYYY-MM-DD HH24:MI:SS') LAST_ANALYZED
, ROUND ( (DELETES + UPDATES + INSERTS) / NUM_ROWS * 100) STALE_PERCENT
, NUM_ROWS
FROM   DBA_TABLES DT, DBA_TAB_MODIFICATIONS DTM
WHERE      DT.OWNER = DTM.TABLE_OWNER
AND DT.TABLE_NAME = DTM.TABLE_NAME
AND NUM_ROWS > 0
AND ROUND ( (DELETES + UPDATES + INSERTS) / NUM_ROWS * 100) >= 10 AND OWNER NOT IN ('SYS','SYSTEM','SYSMAN','DBSNMP')
ORDER BY 4 desc,5 desc;
```

## REVISION DE OBJETOS INVALIDOS

```sql
set lines 180 pages 2000
col OWNER for a25
col "OBJECT NAME" for a30
col "OBJECT TYPE" for a20
col STATUS for a10
SELECT owner
, object_name "OBJECT NAME"
, object_type "OBJECT TYPE"
, status 
from dba_objects
where status='INVALID'
order by object_type, owner;
```

## REVISION DE OBJETOS EN PAPELERA DE RECICLAJE

```sql
select COUNT(1) from dba_recyclebin;
```

## REVISION DE tablespaces

```sql
set pages 999
col tablespace_name format a40
col "size MB" format 999,999,999
col "free MB" format 99,999,999
col "% Used" format 999
col Chunks_Free format 999999 heading 'No Of Ext.'
col pct_used format 999 heading '% Used'
select tsu.tablespace_name
   , ceil(tsu.used_mb) "size MB"
   , decode(ceil(tsf.free_mb), NULL,0,ceil(tsf.free_mb)) "free MB"
   , decode(100 - ceil(tsf.free_mb/tsu.used_mb*100), NULL, 100,
      100 - ceil(tsf.free_mb/tsu.used_mb*100)) as pct_used
from (select tablespace_name
   , sum(bytes)/1024/1024 used_mb
   from dba_data_files 
   group by tablespace_name 
   union all
   select tablespace_name || '  **TEMP**'
      , sum(bytes)/1024/1024 used_mb
   from dba_temp_files 
   group by tablespace_name) tsu
, (select tablespace_name
      , sum(bytes)/1024/1024 free_mb
   from dba_free_space b
   group by tablespace_name) tsf
where tsu.tablespace_name = tsf.tablespace_name (+)
order by 4 desc
/
```

## REVISION DATAFILES AUTOEXTEND

```sql
set line 180 pagesize 300
col file_name for a60
col TABLESPACE_NAME for a20
col "AUTOEX" for a10
select file_name
, TABLESPACE_NAME
, AUTOEXTENSIBLE as "AUTOEX"
from dba_data_files
where AUTOEXTENSIBLE = 'YES'
union 
select file_name
, TABLESPACE_NAME
, AUTOEXTENSIBLE as "AUTOEX"
from dba_temp_files
where AUTOEXTENSIBLE = 'YES';
```

## REVISION TABLAS SIN PRIMARY KEY

```sql
set line 180 pages 300
col owner for a25
col table_name for a35
select owner
, table_name
from dba_tables a
where owner not in ('AWRUSER','EXFSYS','PA_AWR_USER','OE','ODM','OLAPSYS','ODM_MTR','OJVMSYS','PERFSTAT','SH','SYS','SYSTEM','WMSYS','XDB','ORDDATA','MDSYS','LBACSYS','DVSYS','CTXSYS','AUDSYS','APEX_040200','SYSMAN','APEX_030200','DBSNMP','APEX_050000','GSMADMIN_INTERNAL')
and num_rows > 0
and not exists (select null
from dba_constraints b
where a.owner = b.owner
and a.table_name = b.table_name
and b.constraint_type = 'P')
order by 1,2
/ 
```

## Tablespace Auto Management

```sql
set line 180 pagesize 300
col owner for a20
col SEGMENT_NAME for a30
col TABLESPACE_NAME for a20
SELECT TABLESPACE_NAME
, SEGMENT_NAME
, a.SEGMENT_SPACE_MANAGEMENT
FROM DBA_SEGMENTS inner join dba_tablespaces a using (TABLESPACE_NAME) 
WHERE SEGMENT_NAME LIKE '%AUD$' 
OR SEGMENT_NAME LIKE '%FGA_LOG%';
```

```sql
set line 180 pagesize 300
col SEGMENT_SPACE_MANAGEMENT for a20
col TABLESPACE_NAME for a30
select TABLESPACE_NAME
, SEGMENT_SPACE_MANAGEMENT
from dba_tablespaces
where SEGMENT_SPACE_MANAGEMENT = 'MANUAL'
AND TABLESPACE_NAME NOT IN ('SYSTEM');
```

## Uso de TAF

```sql
SET LINESIZE 200 PAGES 300
COL SID FORMAT 999999
COL SERIAL# FORMAT 999999
COL SPID FORMAT 999999
COL PID FORMAT 999999
COL USERNAME FORMAT A40
COL FAILOVER_TYPE FORMAT A25
COL FAILOVER_METHOD FORMAT A25
select distinct s.USERNAME
, FAILOVER_TYPE
, FAILOVER_METHOD
FROM GV$SESSION s
JOIN GV$PROCESS p ON p.ADDR = s.PADDR
AND p.INST_ID = S.INST_ID
WHERE s.TYPE != 'BACKGROUND'
AND s.USERNAME NOT IN ('SYS','SYSTEM','SYSRAC')
/
```

## INDEX NO UTILIZADOS

Se debe haber activado el monitoreo de index con anterioridad

```sql
set line 180 pages 1000
col INDEX_NAME for a30
col TABLE_NAME for a30
col MONITORING for a10
col USED for a5
col start_monitoring for a20
col end_monitoring for a20
select t.owner#
, io.name INDEX_NAME
, t.name TABLE_NAME
, decode(bitand(i.flags, 65536), 0, 'NO', 'YES') MONITORING
, decode(bitand(ou.flags, 1), 0, 'NO', 'YES') USED
, ou.start_monitoring
, ou.end_monitoring
from sys.obj$ io
, sys.obj$ t
, sys.ind$ i
, sys.object_usage ou
where i.obj# = ou.obj#
AND io.obj# = ou.obj#
AND t.obj# = i.bo#
AND t.owner# = 676
AND decode(bitand(ou.flags, 1), 0, 'NO', 'YES') = 'NO'
/
```

```sql
set line 180 pages 1000
col INDEX_NAME for a30
col TABLE_NAME for a30
col MONITORING for a10
col USED for a5
col start_monitoring for a20
col end_monitoring for a20
select distinct t.owner#
, decode(bitand(i.flags, 65536), 0, 'NO', 'YES') MONITORING
, decode(bitand(ou.flags, 1), 0, 'NO', 'YES') USED
from sys.obj$ io
, sys.obj$ t
, sys.ind$ i
, sys.object_usage ou
where i.obj# = ou.obj#
AND io.obj# = ou.obj#
AND t.obj# = i.bo#
AND decode(bitand(ou.flags, 1), 0, 'NO', 'YES') = 'NO'
/
```

```sql
select username from dba_users where user_id = 676;
```

```sql
set line 380
col OWNER format a30
col INDEX_NAME format a30
col TABLE_NAME format a30
select * from monitoreo_indices
where USED='NO'
AND OWNER NOT IN ('ANONYMOUS'
,'APEX_030200'
,'APEX_PUBLIC_USER'
,'APPQOSSYS'
,'BI'
,'CTXSYS'
,'DBSNMP'
,'DIP'
,'EXFSYS'
,'FLOWS_FILES'
,'HR'
,'IX'
,'MDDATA'
,'MDSYS'
,'MGMT_VIEW'
,'OE'
,'OLAPSYS'
,'ORACLE_OCM'
,'ORDDATA'
,'ORDPLUGINS'
,'ORDSYS'
,'OUTLN'
,'OWBSYS'
,'OWBSYS_AUDIT'
,'PM'
,'SCOTT'
,'SH'
,'SI_INFORMTN_SCHEMA'
,'SPATIAL_CSW_ADMIN_USR'
,'SPATIAL_WFS_ADMIN_USR'
,'SYS'
,'SYSMAN'
,'SYSTEM'
,'WMSYS'
,'XDB'
,'XS$NULL'
, 'RESPALDO'
,'PERFSTAT')
/
```

```sql
select OWNER
, COUNT(1) cant
from monitoreo_indices
where USED='NO'
AND OWNER NOT IN ('ANONYMOUS'
,'APEX_030200'
,'APEX_PUBLIC_USER'
,'APPQOSSYS'
,'BI'
,'CTXSYS'
,'DBSNMP'
,'DIP'
,'EXFSYS'
,'FLOWS_FILES'
,'HR'
,'IX'
,'MDDATA'
,'MDSYS'
,'MGMT_VIEW'
,'OE'
,'OLAPSYS'
,'ORACLE_OCM'
,'ORDDATA'
,'ORDPLUGINS'
,'ORDSYS'
,'OUTLN'
,'OWBSYS'
,'OWBSYS_AUDIT'
,'PM'
,'SCOTT'
,'SH'
,'SI_INFORMTN_SCHEMA'
,'SPATIAL_CSW_ADMIN_USR'
,'SPATIAL_WFS_ADMIN_USR'
,'SYS'
,'SYSMAN'
,'SYSTEM'
,'WMSYS'
,'XDB'
,'XS$NULL'
, 'RESPALDO'
,'PERFSTAT')
group by OWNER
/
```

```sql
select OWNER
, INDEX_NAME
, MONITORING
, USED
from monitoreo_indices
where owner  in 
('EFTADM'
,'OLCADM'
,'PPVADM'
,'SECADM')
and USED = 'NO'
/
```

## tamaño de la bd

## OBTENER IP DEL SERVIDOR DE BD

```sql
select utl_inaddr.get_host_address IP from dual;
```

## REVISION DE REDOS

```sql
set line 380
col MEMBER format a64
select * from v$logfile;
```

```sql
select * from V$log;
```

## Tamaño de schemas

```sql
set line 240
col owner for a35
col size_mb for 999,999,999,999.00
select owner, sum(bytes)/1024/1024 size_mb
from dba_segments
group by owner
order by 2 DESC;
```

## REVISION DE ESPERAS POR OBJETO

```sql
col "Object" format a32
set numwidth 12
set lines 180
set pages 50
@title132 'Object Wait Statistics'
select * from(
select 
   DECODE(GROUPING(a.object_name), 1, 'All Objects', a.object_name) AS "Object",
   sum(case when a.statistic_name = 'ITL Waits' then a.value else null end) "ITL Waits",
   sum(case when a.statistic_name = 'buffer busy waits' then a.value else null end) "Buffer Busy Waits",
   sum(case when a.statistic_name = 'row lock waits' then a.value else null end) "Row Lock Waits",
   sum(case when a.statistic_name = 'physical reads' then a.value else null end) "Physical Reads",
   sum(case when a.statistic_name = 'logical reads' then a.value else null end) "Logical Reads"
from
   v$segment_statistics a
where
   a.owner not in ('SYS','SYSTEM')
   --and a.owner = 'EFTADM'
group by rollup(a.object_name)) b
where (b."ITL Waits" > 0 or b."Buffer Busy Waits" > 0)
order by 4 desc;
```

```sql
set line 180
col owner for a25
col object_type for a30
col object_name for a40 
select owner,
object_type,
object_name
from dba_objects
where object_name = 'SL_LOG'
/
```

## SHOW TABLES

```sql
set line 180 pages 300
col pct_free for 999.99
col pct_used for 999.99
col ini_trans for 999
col max_trans for 999
select pct_free
, pct_used
, ini_trans
, max_trans
from dba_tables
where table_name = 'SERVICE_REQUESTS'
/
```

```sql
set line 180 pages 300
col pct_free for 999.99
col pct_used for 999.99
col ini_trans for 999
col max_trans for 999
select pct_free
, pct_used
, ini_trans
, max_trans
from dba_tab_partitions
where table_name = 'SERVICE_REQUESTS'
/
```

## SHOW INDEXES

En la columna `index_name` se debe especificar el nombre del Index en concreto

```sql
set line 180 pages 300
col pct_free for 999.99
col pct_used for 999.99
col ini_trans for 999
col max_trans for 999
select pct_free
, ini_trans
, max_trans
from dba_indexes
where index_name = 'EB_DEV_STATI2'
/
```

```sql
set line 180 pages 300
col pct_free for 999.99
col pct_used for 999.99
col ini_trans for 999
col max_trans for 999
select pct_free
, ini_trans
, max_trans
from dba_ind_partitions
where index_name = 'SL_LOGI1'
/
```

## REVISION DE CARDINALIDAD DE LOS INDICES

```sql
set pages 500
set lines 180
col OWNER format a35
col INDEX_NAME format a60
col num_rows format 999,999,999.00
select owner
, index_name
, num_rows
, distinct_keys
from dba_indexes
where owner not in ('SH','OE','HR','OLAPSYS','SYS','SYSTEM','SYSMAN','OUTLN','CTXSYS','XDB','MDSYS','APEX_050000','APEX_030200','APEX_040200','WMSYS','ORDDATA', 'DVSYS')
and num_rows <> distinct_keys
and distinct_keys < 10 
and owner != 'SYSTEM'
order by NUM_ROWS desc;
```

### PLSQL correr unicamente

```sql
-- exec DBMS_OUTPUT.ENABLE(1000000);
set SERVEROUTPUT on size 1000000
DECLARE 

TYPE t_bulk_collect_dba_index IS TABLE OF dba_ind_columns.COLUMN_NAME%TYPE;

  l_tab_ind     t_bulk_collect_dba_index;

v_sql varchar2(200);
BEGIN

for i in (select index_name, owner, table_name
            from dba_indexes
            where owner not in ('SH','OE','HR','OLAPSYS','SYS','SYSTEM','SYSMAN','OUTLN','CTXSYS','XDB','MDSYS','APEX_030200','APEX_040200','WMSYS','ORDDATA')
            and num_rows <> distinct_keys
            --and owner in ('OLCADM','EFTADM')
            and distinct_keys < 10 order by NUM_ROWS desc)
        LOOP
            --dbms_output.put_line(i.query);
            v_sql := 'select COLUMN_NAME from dba_ind_columns where index_name='''||i.index_name||''' and INDEX_OWNER='''||i.owner||'''';
            BEGIN
            EXECUTE IMMEDIATE v_sql BULK COLLECT INTO l_tab_ind;
            for j in l_tab_ind.first .. l_tab_ind.last
            LOOP

                -- dbms_output.put_line(v_sql ||' = '|| l_tab_ind(j));
                dbms_output.put_line('*************************************');
                dbms_output.put_line(i.index_name);
                dbms_output.put_line('-------------------------------------');
                dbms_output.put_line('select '||l_tab_ind(j) ||', COUNT(1) cant from '||i.owner||'.'||i.table_name||' group by '||l_tab_ind(j)||';'||chr(10));
            END LOOP;
            
            EXCEPTION WHEN OTHERS THEN
                dbms_output.put_line(sqlerrm);
            END;
        END LOOP;
END;
/
```

```sql
set line 180 pages 300
col table_name for a40
col index_name for a30
col COLUMN_NAME for a30
select a.table_owner ||'.'|| a.table_name table_name, a.index_name index_name, b.COLUMN_NAME COLUMN_NAME
from dba_indexes a inner join dba_ind_columns b 
on b.index_name=a.index_name and b.index_owner=a.owner
where a.owner not in ('SYS','SYSTEM','SYSMAN','OUTLN','CTXSYS','XDB','MDSYS','APEX_030200','APEX_040200','WMSYS','ORDDATA')
and a.num_rows <> a.distinct_keys
--and owner = 'GESTORDM'
and a.distinct_keys < 10 order by a.NUM_ROWS desc
/
```

> Si la data es mayor al 5% del total data, no es optimo

## REVISION CANDIDATAS A PARTICIONAR

```sql
set line 180 pages 300
col segment_name a30
col mb for 999,999,999
select owner, segment_name, mb
from (select owner, segment_name, sum(bytes)/1024/1024 MB
from dba_segments
where segment_type='TABLE'
group by owner, segment_name)
where MB > 2048
and segment_name not in
(select object_name from dba_objects
where object_type = 'TABLE PARTITION')
order by mb desc;
```

## REVISION FILAS ENCADENADAS

```sql
select owner
, table_name
, num_rows
, chain_cnt
from dba_tables 
where owner not in ('SYS','SYSTEM') 
and chain_cnt/num_rows > 0.01 
and num_rows > 0 
/ 
```

## QUERIES MAS COSTOSOS

```sql
@?/rdbms/admin/sqltrpt.sql
```

### Windows statspack 9i

```sql
@?\rdbms\admin\spauto.sql
EXECUTE statspack.snap;

EXECUTE STATSPACK.SNAP(i_snap_level=>7, i_modify_parameter=>'true');
@?\rdbms\admin\spreport.sql
```

[Queries mas costosos en Windows](https://dba.stackexchange.com/questions/224205/oracle-9i-historical-long-queries-since-instance-startup?answertab=active#tab-top)

```sql
select * from (
 select sql_id, elapsed_time / 1000000 as elapsed, SUBSTRB(REPLACE(sql_text,:newl,' '),1,55) as sql_text_fragment
 from   V$SQLSTATS
 order by elapsed_time desc
) where ROWNUM <= 15;
```

```sql
select * from (
 select stat.sql_id as sql_id, sum(elapsed_time_delta) / 1000000 as elapsed,
     (select to_char(substr(replace(st.sql_text,:newl,' '),1,55))
     from dba_hist_sqltext st
     where st.dbid = stat.dbid and st.sql_id = stat.sql_id) as sql_text_fragment
 from dba_hist_sqlstat stat, dba_hist_sqltext text
 where stat.sql_id = text.sql_id and
       stat.dbid   = text.dbid
 group by stat.dbid, stat.sql_id
 order by elapsed desc
) where ROWNUM <= 15;
```

## REVISION INDICES CON PROPIEDAD LOGIN NO ACTIVA

```sql
set line 380
col index_name format a32
col tablespace_name format a32
col owner format a32
SELECT OWNER
, INDEX_NAME
, TABLESPACE_NAME
, PARTITIONED
, LOGGING 
FROM DBA_INDEXES
WHERE LOGGING='NO'
AND OWNER NOT IN ('SYS','SYSTEM','DBSNMP')
/
```

## REVISION ALL SQLTEXT

```sql
select sql_text
from v$sqlarea
where hash_value='2993894363'
/
```

```sql
select owner,object_type from dba_objects where object_name ='V_OUTGOING_FLOW';
```

```sql
EXPLAIN PLAN FOR
SELECT T_FLOW_INFO_ID
, EMISSION_DT
, trim(SYSTEM_CODE)
, FLOW_TYPE
, N_REMISE
, BANK_CODE
, BANK_LABEL
, CURRENCY_CODE
, CURRENCY_LABEL
, NB_LOT
, CRA_DATETIME
, RESULT_CODE
, RESULT_LABEL
, N_REMISE_ANNUL 
FROM V_OUTGOING_FLOW 
WHERE T_FLOW_INFO_ID <= 203418 
AND FLOW_TYPE LIKE '%' 
AND BANK_CODE LIKE '%' 
AND SYSTEM_CODE LIKE '%' 
AND CURRENCY_CODE LIKE
'%' ORDER BY T_FLOW_INFO_ID DESC
/
```

```sql
SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());
```

## REVISION ADVISOR DEL SGA

```sql
SELECT SGA_SIZE
, SGA_SIZE_FACTOR
, ESTD_DB_TIME
, ESTD_DB_TIME_FACTOR
, ESTD_PHYSICAL_READS
FROM v$sga_target_advice
ORDER BY sga_size ASC;
```

[Advisor SGA](https://orasg.wordpress.com/2015/10/31/tuning-sga_target-using-vsga_target_advice/)

## REVISION CANTIDAD DE OBJETOS POR SCHEMA

```sql
select OWNER, count(1) from dba_objects
where owner not in ('SYS','SYSTEM','WMSYS','XDB','ORDDATA','MDSYS','LBACSYS','DVSYS','CTXSYS','AUDSYS','OUTLN','APEX_040200')
group by OWNER
order by 2
/
```

## REVISION Objetos con ITL Waits

```sql
set line 380
col OWNER format a32
col object_name format a40
col subobject_name format a32
col tablespace_name format a32
SELECT t.OWNER, t.OBJECT_NAME, t.SUBOBJECT_NAME, t.tablespace_name, t.OBJECT_TYPE, t.VALUE as ITL_Waits
FROM v$segment_statistics t
WHERE t.STATISTIC_NAME = 'ITL waits' 
AND t.OWNER not in ('SYS','SYSTEM')
AND t.VALUE > 0 order by ITL_Waits desc;
```

## REVISION QUERIES CON MAS DE 20 VERSIONES

```sql
set line 380
col SQL format a64
SELECT * FROM 
(SELECT substr(sql_text,1,50) sql, version_count, executions, hash_value,address
FROM V$SQLAREA
WHERE version_count > 20
ORDER BY version_count DESC)
WHERE rownum <= 10
/
```

## REVISION Esperas de eventos DB CPU

```sql
select
stat_name,
Round(value/1000000) "Time (Sec)"
from v$sys_time_model
where stat_name = 'DB CPU';
```

## REVISION USO DE CPU POR USUARIO

```sql
select
   ss.username,
   se.SID,
   VALUE/100 cpu_usage_seconds
from
   v$session ss,
   v$sesstat se,
   v$statname sn
where
   se.STATISTIC# = sn.STATISTIC#
and
   NAME like '%CPU used by this session%'
and
   se.SID = ss.SID
and
   ss.status='ACTIVE'
and
   ss.username is not null
order by VALUE desc;
```

## REVISION OBJETOS CON CARACTERISTICAS DE RESPALDO

```sql
set line 380
col OWNER format a32
col OBJECT_NAME format a32
select OWNER, OBJECT_NAME, OBJECT_TYPE 
FROM DBA_OBJECTS
where OWNER NOT in ('SYS','SYSMAN','SYSTEM','WMSYS','XDB','ORDDATA','MDSYS','LBACSYS','DVSYS','CTXSYS','AUDSYS','OUTLN','APEX_040200','PUBLIC','DBSNMP')
AND OBJECT_TYPE='TABLE'
AND ( OBJECT_NAME LIKE '%BK%'
OR  OBJECT_NAME LIKE '%BCK%'
OR  OBJECT_NAME LIKE 'TEMP%')
-- AND OWNER ='GESTORDM'
/
```

## REVISION DATAFILES IRRECUPERABLES POR TABLESPACE NO LOGGIN

```sql
select file#, 
unrecoverable_time, 
unrecoverable_change# 
from v$datafile 
where unrecoverable_time is not null;
```

```sql
set line 380
col OWNER format a32
col OBJECT_NAME format a32
select count(1) from (
select OWNER, OBJECT_NAME, OBJECT_TYPE 
FROM DBA_OBJECTS
where OBJECT_NAME LIKE '%BK%'
OR  OBJECT_NAME LIKE '%BCK%'
OR  OBJECT_NAME LIKE 'TEMP%'
AND OWNER not in ('SYS','SYSTEM','WMSYS','XDB','ORDDATA','MDSYS','LBACSYS','DVSYS','CTXSYS','AUDSYS','OUTLN','APEX_040200','PUBLIC','DBSNMP','SYSMAN','')
AND OWNER NOT LIKE '%SYS%'
AND OBJECT_TYPE='TABLE')
where OBJECT_TYPE='TABLE'
/
```

## CHECK DATAFILES

```sql
set line 180 pages 200
col TABLESPACE_NAME for a35
col FILE_NAME for a80
col SIZE_MB for 999,999,999
col BLOCKS for 999,999,999
col AUTOEXTENSIBLE for a10
select TABLESPACE_NAME
, FILE_NAME
, BYTES/1024/1024 SIZE_MB
, BLOCKS
, AUTOEXTENSIBLE
FROM dba_data_files
order by TABLESPACE_NAME;
```
