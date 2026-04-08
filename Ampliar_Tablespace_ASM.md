/*-- Index --*/

1.- Show tablespaces
2.- Show sequence datafiles from tablespaces
3.- Extend tablespace
4.- Check changes

/*-- Content --*/


DATA_SHCCHIPLOG


1.- Show tablespaces
====================

```sql
set pages 999
col tablespace_name format a40
col "size MB" format 999,999,999
col "free MB" format 99,999,999
col "% Used" format 999
select tsu.tablespace_name
	, ceil(tsu.used_mb) "size MB"
	, decode(ceil(tsf.free_mb), NULL,0,ceil(tsf.free_mb)) "free MB"
	, decode(100 - ceil(tsf.free_mb/tsu.used_mb*100), NULL, 100,
		100 - ceil(tsf.free_mb/tsu.used_mb*100)) "% used"
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
	from dba_free_space 
	group by tablespace_name) tsf
where tsu.tablespace_name = tsf.tablespace_name (+)
order by 4
/
```



2.- Show sequence datafiles from tablespaces
============================================


set pages 100
set line 200
set timi on
COL file_name FORMAT A60
COL SIZE(MB) FORMAT 999,999,999
col TABLESPACE_NAME format a30
col AUTOEXTENSIBLE format a6
SELECT file_id
, file_name
, BYTES/1024/1024 AS "SIZE(MB)"
, TABLESPACE_NAME
, AUTOEXTENSIBLE
FROM dba_data_files
WHERE tablespace_name = 'SYSAUX'
ORDER BY file_id, file_name, "SIZE(MB)";


3.- Extend tablespace
=====================


NOTA: Se debe respetar el mismo size que poseen los anteriores datafiles y diskgroup donde estan escritos


ALTER TABLESPACE SYSAUX ADD DATAFILE '+DG_DATA/' SIZE 10G AUTOEXTEND OFF;

ALTER TABLESPACE IND_POS_TER_CAP_TRANS ADD DATAFILE '+DATA/' SIZE 2G;

ALTER TABLESPACE OLCADM_IND3_4096 ADD DATAFILE 'G:\MVPPVINDEX7\EFTADM\OLCADM_IND3_4096_20.DBF' SIZE 2G;


4.- Check changes
=================

```sql
set pages 999
col tablespace_name format a40
col "size MB" format 999,999,999
col "free MB" format 99,999,999
col "% Used" format 999
select tsu.tablespace_name
	, ceil(tsu.used_mb) "size MB"
	, decode(ceil(tsf.free_mb), NULL,0,ceil(tsf.free_mb)) "free MB"
	, decode(100 - ceil(tsf.free_mb/tsu.used_mb*100), NULL, 100,
		100 - ceil(tsf.free_mb/tsu.used_mb*100)) "% used"
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
	from dba_free_space 
	group by tablespace_name) tsf
where tsu.tablespace_name = tsf.tablespace_name (+)
-- and tsu.tablespace_name not like 'UNDOTBS%'
and tsu.tablespace_name = 'SYSAUX'
order by 4
/
```
