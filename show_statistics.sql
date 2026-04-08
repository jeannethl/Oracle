set pagesize 600
col owner for a25
col table_name for a30
col LAST_ANALYZED for a30
select owner
, table_name
, to_char(LAST_ANALYZED,'RRRR-MM-DD HH24:mi:ss') LAST_ANALYZED
from dba_tab_statistics
where owner like 'CBK%'
order by LAST_ANALYZED
/


set lines 120 pages 2000
column owner format a20
column table_name format a30
SELECT DT.OWNER
, DT.TABLE_NAME
, TO_CHAR(DT.LAST_ANALYZED,'DD-MM-YYYY HH24:MI:SS') LAST_ANALYZED
, ROUND ( (DELETES + UPDATES + INSERTS) / NUM_ROWS * 100) STALE_PERCENT
, NUM_ROWS
FROM DBA_TABLES DT, DBA_TAB_MODIFICATIONS DTM
WHERE DT.OWNER = DTM.TABLE_OWNER
AND DT.TABLE_NAME = DTM.TABLE_NAME
AND NUM_ROWS > 0
AND ROUND ( (DELETES + UPDATES + INSERTS) / NUM_ROWS * 100) >= 10 
AND OWNER NOT IN ('SYS','SYSTEM','SYSMAN','DBSNMP')
ORDER BY 4 desc, 5 desc;
