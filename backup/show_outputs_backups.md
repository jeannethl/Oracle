---
Author(s): Nelson Díaz - DBA Team - ADSI
Enviroment: Oracle Database 11 or higher
Last Change: 19/02/2024
Tags: oracle, backups, rman
---

# Show backups and outputs

show output backups rman from sqlplus

## Show all backups

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
  (j.output_bytes/1024/1024) output_mbytes, j.status, j.input_type,
  decode(to_char(j.start_time, 'd'), 1, 'Sunday', 2, 'Monday',
                                     3, 'Tuesday', 4, 'Wednesday',
                                     5, 'Thursday', 6, 'Friday',
                                     7, 'Saturday') dow,
  j.elapsed_seconds, j.time_taken_display,
  x.cf, x.df, x.i0, x.i1, x.l,
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
    where j.start_time > trunc(sysdate)-NVL(&NUMBER_OF_DAYS,15)
order by j.start_time
/
```

## Show backups failed

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
  (j.output_bytes/1024/1024) output_mbytes, j.status, j.input_type,
  decode(to_char(j.start_time, 'd'), 1, 'Sunday', 2, 'Monday',
                                     3, 'Tuesday', 4, 'Wednesday',
                                     5, 'Thursday', 6, 'Friday',
                                     7, 'Saturday') dow,
  j.elapsed_seconds, j.time_taken_display,
  x.cf, x.df, x.i0, x.i1, x.l,
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
    where j.status = 'FAILED'
    and j.start_time > trunc(sysdate) - &NUMBER_OF_DAYS
order by j.start_time
/
```

## Show output backups

```sql
set lines 380;
set pages 300 feedback on;
set head on
set timi on time on
col INICIO format a18;
col FIN format a18;
col STATUS format a32;
col device format a10;
col TIPO format a15;
SELECT SESSION_RECID
, SESSION_STAMP
, to_char(start_time,'dd-mm-yy_hh24:mi:ss') as INICIO
, to_char(end_time,'dd-mm-yy_hh24:mi:ss') as FIN
, NVL(output_device_type, 'SBT_TYPE') DEVICE
, REPLACE(input_type,'DB FULL','DB_FULL') TIPO
, REPLACE(status,'COMPLETED WITH WARNINGS','COMPLETED_WITH_WARNINGS') STATUS
FROM sys.v$rman_backup_job_details
where  trunc(start_TIME) >= trunc(sysdate-15)
order by start_time;
```

### Show output

```sql
ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY HH24:MI:SS";

set lines 200
set pages 1000
select output
from GV$RMAN_OUTPUT ro
INNER JOIN sys.v$rman_backup_job_details rbd
ON ro.session_recid = rbd.session_recid
where rbd.status = 'FAILED';
```

---

### Show output backup with `SESSION_RECID` and `SESSION_STAMP`

```sql
 21846    1181566902
ALTER SESSION SET NLS_DATE_FORMAT='RRRR-MM-DD HH24:MI:SS';
set lines 200
set pages 1000
select output
, rbd.start_time
, rbd.end_time
-- , rbd.ELAPSED_SECONDS
from GV$RMAN_OUTPUT ro
INNER JOIN sys.v$rman_backup_job_details rbd
ON ro.session_recid = rbd.session_recid
where ro.session_recid = 36073
AND ro.SESSION_STAMP = 1193522854;
```

```sql
ALTER SESSION SET NLS_DATE_FORMAT='RRRR-MM-DD HH24:MI:SS';
spool /tmp/output_backup.txt
set lines 200
set pages 1000
select output
, rbd.start_time
, rbd.end_time
-- , rbd.ELAPSED_SECONDS
from GV$RMAN_OUTPUT ro
INNER JOIN sys.v$rman_backup_job_details rbd
ON ro.session_recid = rbd.session_recid
where ro.session_recid = 30437
AND ro.SESSION_STAMP = 1194037238;
spool off;
```

```sql
set lines 220
set pages 1000
col backup_type for a4 heading "TYPE"
col controlfile_included heading "CF?"
col incremental_level heading "INCR LVL"
col pieces for 999 heading "PCS"
col elapsed_seconds heading "ELAPSED|SECONDS"
col device_type for a10 trunc heading "DEVICE|TYPE"
col compressed for a4 heading "ZIP?"
col output_mbytes for 9,999,999 heading "OUTPUT|MBYTES"
col input_file_scan_only for a4 heading "SCAN|ONLY"
select
d.bs_key, d.backup_type, d.controlfile_included, d.incremental_level, d.pieces,
to_char(d.start_time, 'yyyy-mm-dd hh24:mi:ss') start_time,
to_char(d.completion_time, 'yyyy-mm-dd hh24:mi:ss') completion_time,
d.elapsed_seconds, d.device_type, d.compressed, (d.output_bytes/1024/1024) output_mbytes, s.input_file_scan_only
from V$BACKUP_SET_DETAILS d
join V$BACKUP_SET s on s.set_stamp = d.set_stamp and s.set_count = d.set_count
where session_recid = 2347
and session_stamp = 1175237187
order by d.start_time;
```

```sql
set lines 220
set pages 1000
col cf for 9,999
col df for 9,999
col elapsed_seconds heading "ELAPSED|SECONDS"
col i0 for 9,999
col i1 for 9,999
col l for 9,999
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
(j.output_bytes/1024/1024) output_mbytes, j.status, j.input_type,
decode(to_char(j.start_time, 'd'), 1, 'Sunday', 2, 'Monday',
3, 'Tuesday', 4, 'Wednesday',
5, 'Thursday', 6, 'Friday',
7, 'Saturday') dow,
j.elapsed_seconds, j.time_taken_display,
x.cf, x.df, x.i0, x.i1, x.l,
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
and ro.session_recid
and ro.session_stamp
order by j.start_time;
```
