set verify off
ACCEPT inicio CHAR PROMPT 'Fecha inicio >';
ACCEPT fin CHAR PROMPT 'Fecha fin >';
ACCEPT sqlid CHAR PROMPT 'SQL ID >';
compute sum of total on report
break on report
select TO_CHAR(sample_time,'DD-MM-YYYY HH24:MI') time
, COUNT(1) total
from dba_hist_active_sess_history
where sample_time >= to_date('&inicio','YYYY/MM/DD HH24:MI:SS')
and sample_time <= to_date('&fin','YYYY/MM/DD HH24:MI:SS')
and sql_exec_start is not null
and IS_SQLID_CURRENT='Y' 
--and sql_id = '&sqlid'
GROUP BY TO_CHAR(sample_time,'DD-MM-YYYY HH24:MI') 
ORDER BY 1;