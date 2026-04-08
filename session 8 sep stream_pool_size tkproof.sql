BEGIN

    DBMS_STATS.GATHER_SYSTEM_STATS;
    DBMS_STATS.GATHER_DICTIONARY_STATS(Degree=> 160);
    DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;

  END;

  /



  *********
1. Set STREAMS_POOL_SIZE=240MB ( minimum ) explicitly before the start of the datapump job.

2. Gather the statistics for Dictionary and Fixed Objects as follows:

SQL> connect / as sysdba
SQL> exec dbms_stats.gather_dictionary_stats(Degree=> 64); 
SQL> exec dbms_stats.lock_table_stats (null,'X$KCCLH');
SQL> exec dbms_stats.gather_fixed_objects_stats;
SQL> exec dbms_stats.gather_database_stats (gather_sys=>true);
3. Generate trace

++ before restarting the expdp/impdp check if there are orphan Data Pump jobs left in database. Use << Note 336014.1 >>
++ Add the following parameters with the export/import data pump command : METRICS=Y TRACE=1ff0300
++ Generate trace as per Doc id 813737.1

Please upload the:
- alert log,
- expdp/impdp log file and
- tkprof output
- AWR report generated on an hourly basis


Create standard tkprof output files for Data Pump Master and Worker SQL traces:

% tkprof orcl_dm00_xxxx_.trc tkprof_orcl_dm00_xxxx.out waits=y sort=exeela
% tkprof orcl_dw01_xxxx.trc tkprof_orcl_dw01_xxxx.out waits=y sort=exeela

******************
******************

******************
******************

080924

select * from
 (select owner,segment_name||'~'||partition_name segment_name,bytes/(1024*1024) size_m
 from dba_segments
 where tablespace_name = 'SYSAUX'
 ORDER BY BLOCKS desc)
 where rownum < 40




 List segments are using the more space in the SYSAUX tablespace

set lines 130
set pages 10000
col SgmntSize heading 'Sgmnt|Size|Mb'
col SgmntSize format 99999
col TSname heading 'TSpace|Name|'
col TSname format a25
col SgmntOwner heading 'Sgmnt|Owner|'
col SgmntOwner format a15
col SgmntName heading 'Sgmnt|Name|'
col SgmntName format a35
col SgmntType heading 'Sgmnt|Type|'
col SgmntType format a5
SELECT
  ROUND(SUM(ds.bytes)/1024/1024,0) as "SgmntSize",
  ds.TableSpace_name as "TSname",
  ds.owner as "SgmntOwner",
  ds.segment_name as "SgmntName",
  ds.segment_type as "SgmntType"
FROM dba_segments ds
WHERE ds.segment_type IN ('TABLE','INDEX')
AND TableSpace_name = 'SYSAUX'
GROUP BY
  ds.TableSpace_name,
  ds.owner,
  ds.segment_name,
  ds.segment_type
ORDER BY "SgmntSize"
/

*******************************************************
set lines 130
set pages 10000
col SgmntSize heading 'Sgmnt|Size|Mb'
col SgmntSize format 99999
col TSname heading 'TSpace|Name|'
col TSname format a25
col SgmntOwner heading 'Sgmnt|Owner|'
col SgmntOwner format a15
col SgmntName heading 'Sgmnt|Name|'
col SgmntName format a35
col SgmntType heading 'Sgmnt|Type|'
col SgmntType format a5
CLEAR COMPUTE
COMPUTE sum LABEL TOTAL OF "SgmntSize" ON REPORT
SELECT
  ds.TableSpace_name as "TSname",
  ds.owner as "SgmntOwner",
  ds.segment_name as "SgmntName",
  ds.segment_type as "SgmntType",
  ROUND(SUM(ds.bytes)/1024/1024,0) as "SgmntSize"
FROM dba_segments ds
WHERE ds.segment_type IN ('TABLE','INDEX')
AND TableSpace_name = 'SYSAUX'
GROUP BY
  ds.TableSpace_name,
  ds.owner,
  ds.segment_name,
  ds.segment_type
ORDER BY "SgmntSize"
/


