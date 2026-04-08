ALTER TABLE <NOMBRE_TABLA>TRUNCATE PARTITION <NOMBRE_PARTICION>
UPDATE GLOBAL INDEXES;


Bloquear estadisticas

--BEGIN
--   DBMS_STATS.LOCK_TABLE_STATS('SYS', 'WRH$_LATCH_CHILDREN');
--END;

exec DBMS_STATS.LOCK_TABLE_STATS('SYS', 'WRH$_LATCH_CHILDREN');

verificar bloqueo

col format STATTYPE_LOCKED a20
col format TABLE_NAME a20
SELECT STATTYPE_LOCKED, TABLE_NAME, PARTITION_NAME FROM USER_TAB_STATISTICS WHERE TABLE_NAME = 'WRH$_LATCH_CHILDREN';


desbloquear

BEGIN
   DBMS_STATS.UNLOCK_TABLE_STATS('SYS', 'WRH$_LATCH_CHILDREN');
END;


SYS.WRH$_LATCH_CHILDREN




  
  ----EL PORCENTAJE DE TRABAJO REALIZADO, COMO EN:
SELECT b.username, a.sid, b.opname, b.target,
round(b.SOFAR*100/b.TOTALWORK,0) || '%' as "%DONE", b.TIME_REMAINING,
to_char(b.start_time,'YYYY/MM/DD HH24:MI:SS') start_time
FROM v$session_longops b, v$session a
WHERE a.sid = b.sid
ORDER BY 6;



-----EL PORCENTAJE DE TRABAJO REALIZADO Y EL ESTADO ACTUAL DEL TRABAJO DATAPUMP:
SELECT sl.sid, sl.serial#, sl.sofar, sl.totalwork, dp.owner_name, dp.state, dp.job_mode
FROM v$session_longops sl, v$datapump_job dp
WHERE sl.opname = dp.job_name
AND sl.sofar != sl.totalwork;





----LA SIGUIENTE CONSULTA MUESTRA LA CANTIDAD DE TRABAJO REALIZADO HASTA EL MOMENTO:

SQL> 
SELECT sl.sid, sl.serial#, sl.sofar, sl.MESSAGE,sl.totalwork, dp.owner_name, dp.state, dp.job_mode
FROM v$session_longops sl, v$datapump_job dp
WHERE sl.opname = dp.job_name;