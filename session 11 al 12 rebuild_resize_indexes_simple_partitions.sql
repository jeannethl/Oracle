spool resize_sysaux_tbs.sql



spool resize_sysaux_tbs.sql
set pages 1000
column cmd format a150 word_wrapped
select 'alter database datafile ''' || file_name || ''' resize ' ||
DECODE(ceil( (nvl(hwm,1)*&&blksize)/1024/1024),1,10,ceil( (nvl(hwm,1)*&&blksize)/1024/1024)) || 'm;' cmd
from dba_data_files a,
( select file_id, max(block_id+blocks-1) hwm
from dba_extents
group by file_id ) b
where a.file_id = b.file_id(+)
and ceil( blocks*&&blksize/1024/1024) -
ceil( (nvl(hwm,1)*&&blksize)/1024/1024 ) > 0
AND TABLESPACE_NAME = 'SYSAUX_TEMP'
order by ceil( (nvl(hwm,1)*&&blksize)/1024/1024 )
/
spool off;

********
set line 240
col CMD format a140
select 'alter database datafile ''' || file_name || ''' resize ' ||
ceil( (nvl(hwm,1)*&&blksize)/1024/1024 ) || 'm;' cmd
from dba_data_files a,
( select file_id, max(block_id+blocks-1) hwm
from dba_extents
group by file_id ) b
where a.file_id = b.file_id(+)
and ceil( blocks*&&blksize/1024/1024) - ceil( (nvl(hwm,1)*&&blksize)/1024/1024 ) > 0
and tablespace_name IN ('RBS_POSTING_IDX')
order by tablespace_name desc
/


********
*espacio recuperable
********


set verify off
set line 180 pages 1000
column file_name format a80 word_wrapped
column smallest format 999,990 heading "Smallest|Size|Poss."
column currsize format 999,990 heading "Current|Size"
column savings format 999,999,990 heading "Poss.|Savings"
break on report
compute sum label "TOTAL_SAVE:" of savings on report
column value new_val blksize
select value from v$parameter where name = 'db_block_size'
/


******
******

set line 180 pages 1000
select file_name,
ceil( (nvl(hwm,1)*&&blksize)/1024/1024 ) smallest,
ceil( blocks*&&blksize/1024/1024) currsize,
ceil( blocks*&&blksize/1024/1024) -
ceil( (nvl(hwm,1)*&&blksize)/1024/1024 ) savings
from dba_data_files a,
( select file_id, max(block_id+blocks-1) hwm
from dba_extents
group by file_id ) b
where a.file_id = b.file_id(+)
AND a.TABLESPACE_NAME = 'RBS_POSTING_IDX'
order by savings
/



******



select * from 
(
select owner, segment_name, segment_type, block_id
from dba_extents
where file_id = ( select file_id
from dba_data_files
where file_name = '+DATA/TRZSP/DATAFILE/rbs_posting_idx.1044.1143642313' )
order by block_id desc
)
 where rownum <= 20




+DATA/TRZSP/DATAFILE/rbs_posting_idx.832.1132757939




-----MOVER INDICES SIMPLES

set line 240
col segment_name format a30
col segment_type format a20
col QUERY format a80
col tablespace_name format a20

select 'alter index '||owner||'.'||segment_name||' rebuild tablespace MANTENIMIENTOS_TX ONLINE;' QUERY
from dba_segments
where tablespace_name in ('RBS_POSTING_IDX') and segment_type='INDEX';


select 'alter index '||owner||'.'||segment_name||' rebuild tablespace RBS_POSTING_IDX PARALLEL 64;' QUERY
from dba_segments
where tablespace_name in ('MANTENIMIENTOS_TX') and segment_type='INDEX';




**********
alter index TX.PK_POSTING rebuild tablespace MANTENIMIENTOS_TX ONLINE PARALLEL 64;
alter index TX.IDX_POSTING_ACCOUNTDAY rebuild tablespace MANTENIMIENTOS_TX ONLINE PARALLEL 64;


alter index TX.PK_POSTING rebuild tablespace RBS_POSTING_IDX NOPARALLEL;
alter index TX.IDX_POSTING_ACCOUNTDAY rebuild tablespace RBS_POSTING_IDX NOPARALLEL;




-----MOVER INDICES particionados


select 'ALTER INDEX '||INDEX_OWNER||'.'||INDEX_NAME||' REBUILD PARTITION '||partition_name||' TABLESPACE MANTENIMIENTOS_TX;' QUERY
from dba_ind_partitions
where tablespace_name='RBS_POSTING_IDX';


select 'ALTER INDEX '||INDEX_OWNER||'.'||INDEX_NAME||' REBUILD PARTITION '||partition_name||' TABLESPACE RBS_POSTING_IDX;' QUERY
from dba_ind_partitions
where tablespace_name='MANTENIMIENTOS_TX';


******





-- check the object_id

SQL> 
select obj# ,name from obj$ where OBJ#=974612;

OBJ# NAME
---------- ------------------------------
94771 SOTRAN00_IDX1


--- Run dbms_repair for the object_id


SQL> 
declare
lv_ret BOOLEAN;
begin
lv_ret :=dbms_repair.online_index_clean(974612);
end;
/



--- Verify whether index has been dropped or not

SQL> 

select obj# ,name from obj$ where OBJ#=974612;


no rows selected




-Consultar los segmentos

set line 240
set pagesize 200
col owner format a20
col segment_name format a30
col segment_type format a20

select owner, segment_name, segment_type, bytes/1024/1024/1024 SIZE_GB, bytes, tablespace_name
from dba_segments
where tablespace_name in ('MANTENIMIENTOS_TX');



-----CONSULTAR LOS INDICES NOUSABLE
select INDEX_NAME
  ,PARTITION_NAME
  ---,unique STATUS
from dba_ind_partitions
 where INDEX_OWNER ='TX'
  and STATUS='UNUSABLE';



BEGIN
        FOR x IN
        (
                SELECT 'ALTER INDEX '||OWNER||'.'||INDEX_NAME||' REBUILD ONLINE PARALLEL' comm
                FROM    dba_indexes
                WHERE   status = 'UNUSABLE'
                UNION ALL
                SELECT 'ALTER INDEX '||index_owner||'.'||index_name||' REBUILD PARTITION '||partition_name||' ONLINE PARALLEL;'
                FROM    dba_ind_PARTITIONS
                WHERE   status = 'UNUSABLE'
        )
        LOOP
                dbms_output.put_line(x.comm);
                EXECUTE immediate x.comm;
       END LOOP;
END;
/




SELECT COUNT(1)
from DBA_IND_PARTITIONS
WHERE STATUS ='UNUSABLE';










SELECT index_name, owner, degree 
FROM DBA_INDEXES
WHERE index_name='C_ILM_PARAM';



 
SET LINESIZE 500
col SEGMENT_NAME format a50
col PARTITION_NAME format a50
select 
SEGMENT_NAME
,PARTITION_NAME
,BYTES/1024/1024/1024
from dba_segments
where SEGMENT_NAME = 'WRH$_LATCH_CHILDREN';