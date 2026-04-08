SCRIPTS PARA VER LAS SESIONES DE UNOS ESQUEMAS

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
       s.LOGON_TIME
FROM   gv$session s
       JOIN gv$process p ON p.addr = s.paddr AND p.inst_id = s.inst_id    
WHERE s.username in ('ASI','USU_ASI','INVENT','USU_INVENT')
--where SID = '24'
order by s.username, s.LOGON_TIME;

SCRIPTS PARA MATAR SESSIONES MANUALMENTE

set head OFF
set feed off

SELECT 'ALTER SYSTEM KILL SESSION ' || ''''|| s.sid || ',' || s.serial#
|| ''';'
FROM   gv$session s
JOIN gv$process p ON p.addr = s.paddr AND p.inst_id = s.inst_id
WHERE s.username in ('ASI','USU_ASI','INVENT','USU_INVENT')
--WHERE s.username ='USU_MSI'
order by s.username, s.LOGON_TIME;
