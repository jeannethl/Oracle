///////// ROMPA EL VIDRIO EN CASO DE EMERGENCIA ///////////
SCRIPTS SESIONES INACTIVAS
--------------------------

SET LINE 180 PAGES 300
CLEAR COLUMNS
CLEAR BREAKS
BREAK ON REPORT ON USERNAME SKIP 1
COMPUTE SUM LABEL TOTAL_SESSIONS_INACTIVES OF CANT_SESSIONS ON REPORT
COL CANT_SESSIONS FOR 999,999,999
COL USERNAME FOR A30
SELECT S.USERNAME USERNAME
, S.INST_ID
--, TO_CHAR(S.LOGON_TIME,'DD-MM-RRRR HH24:MI:SS') AS "LOGON_TIME"
, COUNT(1) CANT_SESSIONS
FROM GV$SESSION S
JOIN GV$PROCESS P ON P.ADDR = S.PADDR
AND S.STATUS='INACTIVE'
AND S.USERNAME !='SYS'
-- AND S.USERNAME='OSBTT2_OSB_INFRA'
GROUP BY S.USERNAME
, S.INST_ID
--,"LOGON_TIME"
ORDER BY CANT_SESSIONS DESC
/


---------------------------------
SCRIPTS PARA VER RECURSOS
---------------------------------

SELECT B.INSTANCE_NAME INSTANCIA,
A.RESOURCE_NAME, A.CURRENT_UTILIZATION, A.MAX_UTILIZATION,LIMIT_VALUE
FROM GV$RESOURCE_LIMIT A, GV$INSTANCE B
WHERE A.RESOURCE_NAME IN('PROCESSES', 'SESSIONS', 'TRANSACTIONS')
AND B.INST_ID = A.INST_ID
ORDER BY 1,2;

------------------------------------------------
SCRIPT PARA VER USOS DE RECURSOS HISTORICAMENTE
------------------------------------------------

SET LINESIZE 500
COL BEGIN_INTERVAL_TIME FORMAT A35
COL END_INTERVAL_TIME FORMAT A35
SELECT R.RESOURCE_NAME
, BEGIN_INTERVAL_TIME
, END_INTERVAL_TIME
, R.SNAP_ID
, R.CURRENT_UTILIZATION
, R.MAX_UTILIZATION
, R.LIMIT_VALUE
FROM DBA_HIST_RESOURCE_LIMIT R, DBA_HIST_SNAPSHOT S
WHERE R.SNAP_ID = S.SNAP_ID
AND RESOURCE_NAME IN ('PROCESSES', 'SESSIONS', 'TRANSACTIONS')
ORDER BY R.SNAP_ID;




---------------------------------------------------------------------------------
SCRIPT PARA IDENTIFICAR PROCESOS DE SISTEMA OPERATIVO QUE CONSUMEN MAYOR RECURSO
---------------------------------------------------------------------------------
ps -e -o pcpu,pid,pmem,user,tty,args |sort -n -k 1 -r|head -5
-----------
SET TIMI ON
SET TIME ON
SET LINESIZE 200
COLUMN spid FORMAT A10
COLUMN username FORMAT A30
COLUMN program FORMAT A45

SELECT s.inst_id,
       s.sid,
       s.serial#,
       p.spid,
       p.pid,
       s.username,
       s.program,
       s.LOGON_TIME,
       s.state,
       s.status
FROM   gv$session s
       JOIN gv$process p ON p.addr = s.paddr AND p.inst_id = s.inst_id    
WHERE p.spid in (26536, 22182 )
order by s.username, s.LOGON_TIME;

----------
SELECT PROGRAM, SQL_ID, SID, SERIAL#, STATE, STATUS, USERNAME  FROM GV$SESSION WHERE SID=26465;
------

 set lin 4000
 set timi on 
 set time on 
 col machine format a30
 col object format a32
 col x format a80 
 col owner format a8
 col WAIT_CLASS format a15
 col USERNAME format a10
 col MODULE format a50
 col CLIENT_INFO format a30
 col action  format a30
 col program format a30

 col type format a10
 col OSUSER format a10

 select distinct  
 b.SECONDS_IN_WAIT,b.LOGON_TIME,WAIT_CLASS,
 p.spid psid_local, b.process  psid_remote
 ,
 b.serial#
 ,a.*
 , b.machine, b.osuser, b.username, b.program, status, b.process, b.module, b.CLIENT_INFO, b.action,b.sid
 --,b.sql_id
 from gv$access a,gv$session b , gv$process p
 where a.sid=b.sid and p.addr=b.paddr
 and a.inst_id=b.inst_id and b.inst_id=p.inst_id and a.inst_id=p.inst_id
 and b.sid in (26465, 39538);
 --and b.sql_id ='c9jvn9fskmp6n'
 --and b.machine LIKE '%v5100';

 --------------------------------------
 SCRIPTS PARA VER SESIONES POR MAQUINA
 --------------------------------------

CLEAR COLUMNS
CLEAR BREAKS
SET LINESIZE 800
COL USERNAME FORMAT A12
COL PROGRAM FORMAT A35
COL INST_ID FORMAT 99
COL "LOGON_TIME" FORMAT A20
COL "DB_USER" FORMAT A20
COL "SO_USER" FORMAT A18
COL MACHINE FORMAT A45
COL CANT_SESSIONS FORMAT 999,999,999
--BREAK ON REPORT ON MACHINE SKIP 2
BREAK ON REPORT ON MACHINE SKIP PAGE
COMPUTE SUM LABEL TOTAL_SESSIONS OF CANT_SESSIONS ON REPORT
COMPUTE SUM LABEL SESSION_FOR_NODO OF CANT_SESSIONS ON MACHINE
SELECT COUNT (1) CANT_SESSIONS
, S.INST_ID
, SUBSTR(S.MACHINE,1,45) MACHINE
, S.USERNAME
, S.OSUSER AS "SO_USER"
, S.PROGRAM
-- , TO_CHAR(S.LOGON_TIME,'DD-MM-RRRR HH24:MI') AS "LOGON_TIME"
, TO_CHAR(S.LOGON_TIME,'DD-MM-RRRR') AS "LOGON_TIME"
FROM GV$SESSION S
JOIN GV$PROCESS P ON P.ADDR = S.PADDR
AND P.INST_ID = S.INST_ID
WHERE S.TYPE != 'BACKGROUND'
AND S.USERNAME !='SYS'
--AND S.MACHINE LIKE '%BDVX-CONSULTA-HISTORICO-%'
--AND S.STATUS='INACTIVE'
--AND S.USERNAME ='USRPORTAL'
GROUP BY S.MACHINE, S.USERNAME, S.PROGRAM, S.OSUSER, S.INST_ID
-- , TO_CHAR(S.LOGON_TIME,'DD-MM-RRRR HH24:MI')
, TO_CHAR(S.LOGON_TIME,'DD-MM-RRRR')
ORDER BY "LOGON_TIME", MACHINE
/
