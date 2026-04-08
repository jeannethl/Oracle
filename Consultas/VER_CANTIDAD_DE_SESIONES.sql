-----------------------------------------------------
--- VER CANTIDAD DE SESIONES EN DISTINTOS MINUTOS ---
-----------------------------------------------------

col TIME format a20
select TO_CHAR(sample_time,'DD-MM-YYYY HH24:MI') time, COUNT(1) total
--, INSTANCE_NUMBER
from
dba_hist_active_sess_history
where
sample_time >= to_date('2025/06/17 09:00:00','YYYY/MM/DD HH24:MI:SS')
and sample_time <= to_date('2025/06/17 09:45:00','YYYY/MM/DD HH24:MI:SS')
and sql_exec_start is not null
and IS_SQLID_CURRENT='Y'
-- and sql_id = '8vp5sknd8bq6d'
GROUP BY TO_CHAR(sample_time,'DD-MM-YYYY HH24:MI')--, INSTANCE_NUMBER
ORDER BY 1;



--- Util para ver las cantidades de secciones


set line 180 pages 300
CLEAR COLUMNS
CLEAR BREAKS
BREAK ON REPORT ON USERNAME SKIP 1
COMPUTE SUM LABEL TOTAL_SESSIONS_ACTIVES OF CANT_SESSIONS ON REPORT
col CANT_SESSIONS for 999,999,999
col USERNAME for a30
select s.USERNAME USERNAME
, s.INST_ID
--, TO_CHAR(s.LOGON_TIME,'DD-MM-RRRR HH24:MI:SS') AS "LOGON_TIME"
, COUNT(1) CANT_SESSIONS
FROM GV$SESSION s
JOIN GV$PROCESS p ON p.ADDR = s.PADDR
--AND s.STATUS ='KILLED'
--AND s.USERNAME !='SYS'
--and s.INST_ID =1
-- AND S.USERNAME='OSBTT2_OSB_INFRA'
group by s.USERNAME
, s.INST_ID
--,"LOGON_TIME"
order by CANT_SESSIONS desc
/



-----investigar

while true; do netstat -nat | grep -i time; sleep 5; done
$ORACLE_HOME/suptools/oratop/./oratop / as sysdba
netstat -nat | grep -i time
