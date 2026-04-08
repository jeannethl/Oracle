---Matar todas las sesiones
set serveroutput on
declare
cursor sessions_for_kill is
SELECT s.sid
, s.serial# serial
from gv$session s
JOIN gv$process p ON p.addr = s.paddr
AND p.inst_id = s.inst_id
--WHERE s.username='BDVEMPP'
AND s.OSUSER !='SYSDBA' AND s.status = 'INACTIVE'
--and s.MODULE like '%backup%'
--and s.sid IN (39775,51983,9255)
order by s.username, s.LOGON_TIME;

BEGIN
    FOR cur in sessions_for_kill
    LOOP
      BEGIN
         EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION '''||cur.sid||','||cur.serial||''''||' IMMEDIATE';
      END;
    END LOOP;
END;
/



---- CONSULTAR

SET LINESIZE 200
COLUMN spid FORMAT A10
COLUMN username FORMAT A10
COLUMN program FORMAT A45

SELECT s.inst_id,
       s.sid,
       s.serial#,
       p.spid,
       p.pid,
       s.username,
       s.program,
       s.SQL_ID,
       s.LOGON_TIME
FROM   gv$session s
       JOIN gv$process p ON p.addr = s.paddr AND p.inst_id = s.inst_id  
--WHERE s.username in ('ASI','USU_ASI','INVENT','USU_INVENT')
where s.sid in ('10534')
order by s.username, s.LOGON_TIME;


--- PROCEDER A MATAR

Alter system kill session 'sid,serial#';

--- EJEMPLO
Alter system kill session '10534,27535';








SELECT sid, serial#, username, status, osuser, machine, program FROM v$session WHERE program LIKE '%rman%';

SELECT p.spid, s.sid, s.serial#, s.username, s.status, s.osuser, s.machine FROM v$process p JOIN v$session s ON p.addr = s.paddr WHERE s.program LIKE '%rman%';







SELECT s.sid
, s.serial# serial, 
s.username
from gv$session s
JOIN gv$process p ON p.addr = s.paddr
AND p.inst_id = s.inst_id
--WHERE s.username='BDVEMPP'
WHERE s.OSUSER !='SYSDBA'
and s.sid IN (1601) 
order by s.username, s.LOGON_TIME;



--- Matar sesiones inactivas
set serveroutput on
declare
cursor sessions_for_kill is
SELECT s.sid
, s.serial# serial
from gv$session s
JOIN gv$process p ON p.addr = s.paddr
AND p.inst_id = s.inst_id
WHERE s.username IN ('SPIDERCX', 'EICDATOSCX', 'E2FDATOSCX', 'BMICX')
AND s.status = 'INACTIVE'
AND s.OSUSER !='SYSDBA'
--and s.MODULE like '%backup%'
--and s.sid IN (39775,51983,9255)
order by s.username, s.LOGON_TIME;

BEGIN
    FOR cur in sessions_for_kill
    LOOP
      BEGIN
         EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION '''||cur.sid||','||cur.serial||''''||' IMMEDIATE';
      END;
    END LOOP;
END;
/



-- Consultar sesiones inactivas
SELECT s.status, s.username, s.sid
, s.serial# serial
from gv$session s
JOIN gv$process p ON p.addr = s.paddr
AND p.inst_id = s.inst_id
WHERE s.username NOT IN ('SYS', 'SYSTEM', 'DBSNMP')
--AND s.status = 'INACTIVE'
AND s.OSUSER !='SYSDBA'
--and s.MODULE like '%backup%'
--and s.sid IN (39775,51983,9255)
order by s.username, s.LOGON_TIME;



set lin 4000
set timi on
set time on
col machine format a60
col sql_id format a10
col object format a32
col x format a80
col owner format a8
col WAIT_CLASS format a15
col USERNAME format a10
col MODULE format a90
col CLIENT_INFO format a30
col action  format a70

col type format a10
col OSUSER format a10

select distinct  
b.SECONDS_IN_WAIT,b.LOGON_TIME,WAIT_CLASS,
--'alter system kill session '''||b.sid||','||b.serial#||''' immediate;' x,
p.spid psid_local, b.process  psid_remote
,
b.serial#
--,a.*
, b.machine, b.osuser, b.username, b.program, status, b.process, b.module, b.CLIENT_INFO, b.action,b.sid
,b.sql_id
from gv$access a,gv$session b , gv$process p
where a.sid=b.sid and p.addr=b.paddr
and a.inst_id=b.inst_id and b.inst_id=p.inst_id and a.inst_id=p.inst_id
--and b.sid in (13403)
--and b.module = 'ExCle.BioPOS.ScheduleJobs.Services.exe'
--and a.object =upper('DOEREXTMSG')
--and b.status = 'ACTIVE'
and b.sql_id ='8masb1wkvjt00'
--a.object =upper('BDVX_REGISTRO_MOVIMIENTO_N3')
     --   a.object =upper('INSTACCTMAP')
     -- p.spid=13713
--or a.object =upper('DOEREXTMSG')
--)
--and b.status = 'ACTIVE'
;

---Ver historico de sesiones
set line 180 pages 300
CLEAR COLUMNS
CLEAR BREAKS
col SAMPLE_TIME format a25
--col SESSION_ID format a25
col SQL_ID format a25
col EVENT format a25
col MACHINE format a25
col CLIENT_ID format a25
SELECT SAMPLE_TIME, SESSION_ID, SQL_ID, EVENT, WAIT_TIME, MACHINE, CLIENT_ID
FROM DBA_HIST_ACTIVE_SESS_HISTORY
WHERE ROWNUM <= 1000
ORDER BY SAMPLE_TIME DESC;


--Sesiones activas por maquina
set line 180 pages 300
CLEAR COLUMNS
CLEAR BREAKS
BREAK ON REPORT ON USERNAME SKIP 1
COMPUTE SUM LABEL TOTAL_SESSIONS_ACTIVES OF CANT_SESSIONS ON REPORT
col CANT_SESSIONS for 999,999,999
col USERNAME for a15
col machine for a60
select s.USERNAME USERNAME
, s.INST_ID
, s.MACHINE
, TO_CHAR(s.LOGON_TIME,'DD-MM-RRRR HH24:MI:SS') AS "LOGON_TIME"
, COUNT(1) CANT_SESSIONS
FROM GV$SESSION s
JOIN GV$PROCESS p ON p.ADDR = s.PADDR
AND s.STATUS!='ACTIVE'
--AND s.USERNAME ='BDVEMPP'
--and s.INST_ID =1
-- AND S.USERNAME='OSBTT2_OSB_INFRA'
group by s.USERNAME
, s.INST_ID
, s.machine
,"LOGON_TIME"
order by CANT_SESSIONS desc
/


SET LINE 180 PAGES 300
CLEAR COLUMNS
CLEAR BREAKS
BREAK ON REPORT ON USERNAME SKIP 1
COMPUTE SUM LABEL TOTAL_SESSIONS_ACTIVES OF CANT_SESSIONS ON REPORT
COL CANT_SESSIONS FOR 999,999,999
COL USERNAME FOR A15
COL MACHINE FOR A60

SELECT s.USERNAME USERNAME,
       s.INST_ID,
       s.MACHINE,
       -- TO_CHAR(s.LOGON_TIME,'DD-MM-RRRR HH24:MI:SS') AS "LOGON_TIME",
       COUNT(1) CANT_SESSIONS
FROM GV$SESSION s
JOIN GV$PROCESS p ON p.ADDR = s.PADDR
WHERE s.STATUS != 'ACTIVE'
  AND s.USERNAME = 'INTRANETCORP'
  -- AND s.INST_ID = 1
  -- AND s.USERNAME = 'OSBTT2_OSB_INFRA'
GROUP BY s.USERNAME,
         s.INST_ID,
         s.MACHINE
       -- ,"LOGON_TIME"
ORDER BY CANT_SESSIONS DESC
/




set lin 4000
set timi on
set time on
col machine format a30
col object format a32
col x format a80
col owner format a8
col WAIT_CLASS format a15
col USERNAME format a10
col MODULE format a90
col CLIENT_INFO format a30
col action  format a70

col type format a10
col OSUSER format a10

select distinct  
b.SECONDS_IN_WAIT,b.LOGON_TIME,WAIT_CLASS,
'alter system kill session '''||b.sid||','||b.serial#||''' immediate;' x,
p.spid psid_local, b.process  psid_remote
,
b.serial#
--,a.*
, b.machine, b.osuser, b.username, b.program, status, b.process, b.module, b.CLIENT_INFO, b.action,b.sid
,b.sql_id
from gv$access a,gv$session b , gv$process p
where a.sid=b.sid and p.addr=b.paddr
and a.inst_id=b.inst_id and b.inst_id=p.inst_id and a.inst_id=p.inst_id
--and b.sid in (13403)
--and b.module = 'ExCle.BioPOS.ScheduleJobs.Services.exe'
--and a.object =upper('DOEREXTMSG')
--and b.status = 'ACTIVE'
and b.sql_id ='647v02405nj2j'
--a.object =upper('BDVX_REGISTRO_MOVIMIENTO_N3')
     --   a.object =upper('INSTACCTMAP')
     -- p.spid=13713
--or a.object =upper('DOEREXTMSG')
--)
--and b.status = 'ACTIVE'
;


alter system kill session '7617,30873' immediate;
alter system kill session '1941,14692' immediate;
alter system kill session '6359,64520' immediate;