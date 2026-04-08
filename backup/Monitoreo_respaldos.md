```sql
set line 300 
col TARGET_DESC format a13
col percent format a5
col TARGET_DESC format a13
col start_time format a20
col estimate_fin format a20
col opname format a25
col ch format a10
col broken format a4
col minute_ejecucion for 9999.999
col time_remaining for 9999.999
SELECT gvl.sid,
gvl.serial#,
gvl.opname
,  gvl.target_desc
,  vs.client_info ch
,  gvl.percent
,  gvl.sofar
,  gvl.totalwork
,  to_char(gvl.start_time,    'dd-mon-rrrr hh24:mi:ss') start_time
,  to_char(gvl.efin,          'dd-mon-rrrr hh24:mi:ss') estimate_fin
,  gvl.minute_ejecucion 
,  gvl.time_remaining
,  aio.MB_PER_S
--,  aio.LONG_WAIT_PCT
,  case when gvl.sofar <> gvl.totalwork and gvl.last_update_time < sysdate-1/10000 then '*' else null end broken
FROM
  (SELECT sid,
     serial#,
     opname,
     target_desc, 
     sofar,
     totalwork,
     to_char(CASE
             WHEN totalwork = 0 THEN 1
             ELSE sofar / totalwork
             END *100,    '990') percent,
     start_time,
     last_update_time,
     start_time +((elapsed_seconds + time_remaining) / 86400) efin
     ,elapsed_seconds/60 minute_ejecucion
     ,time_remaining/60 time_remaining
   FROM Gv$session_longops
   ORDER BY  CASE
             WHEN sofar = totalwork
                THEN 1
                ELSE 0 END,
          efin DESC) gvl
  , v$session vs
  , (select sid,
        serial,
        100* sum (long_waits) / decode(sum (io_count),0,1) as "LONG_WAIT_PCT",
        sum (effective_bytes_per_second)/1024/1024 as "MB_PER_S"
      from v$backup_async_io
      group by sid, serial) aio
WHERE gvl.sofar <> gvl.totalwork
and  vs.sid = gvl.sid
and vs.serial# = gvl.serial#
and aio.sid (+)= vs.sid
and aio.serial (+)= vs.serial#;
```

```sql
set lines 380;
set pages 300
col INICIO format a18;
col FIN format a18;
col STATUS format a32;
col device format a10;
col TIPO format a11;
SELECT TO_CHAR(start_time,'dd-mm-yy hh24:mi:ss') as INICIO
, TO_CHAR(end_time,'dd-mm-yy hh24:mi:ss') as FIN
, NVL(output_device_type, 'SBT_TYPE') DEVICE
, REPLACE(input_type,'DB FULL','DB_FULL') TIPO
, REPLACE(status,'COMPLETED WITH WARNINGS','COMPLETED_WITH_WARNINGS') STATUS
FROM sys.v$rman_backup_job_details
where  trunc(start_TIME) >= trunc(sysdate-3)
order by start_time;
```
